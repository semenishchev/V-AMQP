module vamqp

import sync

struct Confirms {
	mut:
	m sync.Mutex
	listeners []chan Confirmation
	sequencer map[u64]Confirmation
	deferred_confirmations DeferredConfirmations
	published u64
	published_mut sync.Mutex
	expecting u64
}

pub fn new_confirms() &Confirms {
	return &Confirms{
		sequencer: map[u64]Confirmation{}
		deferred_confirmations: new_defferred_confirmations()
		published: 0
		expecting: 1
	}
}

pub fn (mut c Confirms) listen(l chan Confirmation) {
	c.m.@lock()
	defer { c.m.unlock() }
	c.listeners << l
}

pub fn (mut c Confirms) publish() &DeferredConfirmation {
	c.published_mut.@lock()
	defer { c.published_mut.unlock() }
	c.published += 1
	return c.deferred_confirmations.add(c.published)
}

pub fn (mut c Confirms) confirm(confirmation Confirmation) {
	c.expecting += 1
	for _, l in c.listeners {
		l <- confirmation
	}
}

pub fn (mut c Confirms) resequence() {
	c.published_mut.@lock()
	defer { c.published_mut.unlock() }

	for c.expecting <= c.published {
		sequenced := c.sequencer[c.expecting] or {return}
		c.confirm(sequenced)
	}
}

pub fn (mut c Confirms) one(confirmed Confirmation) {
	c.m.@lock()
	defer { c.m.unlock() }

	c.deferred_confirmations.confirm(confirmed)

	if c.expecting == confirmed.delivery_tag {
		c.confirm(confirmed)
	} else {
		c.sequencer[confirmed.delivery_tag] = confirmed
	}
	c.resequence()
}

pub fn (mut c Confirms) multiple(confirmed Confirmation) {
	c.m.@lock()
	defer { c.m.unlock() }

	c.deferred_confirmations.confirm_multiple(confirmed)

	for c.expecting <= confirmed.delivery_tag {
		c.confirm(Confirmation{delivery_tag: c.expecting, ack: confirmed.ack})
	}
	c.resequence()
}

pub fn (mut c Confirms) close() {
	c.m.@lock()
	defer { c.m.unlock() }

	c.deferred_confirmations.close()

	for l in c.listeners {
		l.close()
	}
	c.listeners.clear()
	unsafe {
		free(c.listeners)
	}
}

struct DeferredConfirmations {
	mut:
	m sync.Mutex
	confirmations map[u64]&DeferredConfirmation
}

pub fn new_defferred_confirmations() &DeferredConfirmations {
	return &DeferredConfirmations{
		confirmations: map[u64]&DeferredConfirmation{}
	}
}

pub fn (mut d DeferredConfirmations) add(tag u64) &DeferredConfirmation {
	d.m.@lock()
	defer { d.m.unlock() }
	
	mut dc := &DeferredConfirmation{delivery_tag: tag}
	dc.wg.add(1)
	d.confirmations[tag] = dc
	return dc
}

pub fn (mut d DeferredConfirmations) confirm(confirmed Confirmation) {
	d.m.@lock()
	defer { d.m.unlock() }

	mut dc := d.confirmations[confirmed.delivery_tag] or {return}
	dc.confirmation = confirmed
	dc.wg.done()
	d.confirmations.delete(confirmed.delivery_tag)
}

pub fn (mut d DeferredConfirmations) confirm_multiple(confirmed Confirmation) {
	d.m.@lock()
	defer { d.m.unlock() }

	for _, mut dc in d.confirmations {
		dc.confirmation = confirmed
		dc.wg.done()
	}
	d.confirmations.clear()
}

pub fn (mut d DeferredConfirmations) close() {
	d.m.@lock()
	defer { d.m.unlock() }

	for _, mut dc in d.confirmations {
		dc.confirmation = Confirmation{delivery_tag: dc.delivery_tag, ack: false}
		dc.wg.done()
	}
	d.confirmations.clear()
	unsafe {
		free(d.confirmations)
	}
}

pub fn (mut d DeferredConfirmation) wait() bool {
	d.wg.wait()
	return d.confirmation.ack
}