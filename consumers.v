module vamqp

import sync

__global (
	consumer_sequence u64
)

const (
	consumer_tag_length_max = 0xFF
)

pub fn unique_consumer_tag() string {
	return ""
}

type ConsumerBuffers = map[string] chan &Delivery

struct Consumers {
	sync.WaitGroup
	sync.Mutex
	closed chan Any
	chans ConsumerBuffers
}

pub fn new_consumers() &Consumers {
	return &Consumers{
		closed: chan Any{}
		chans: ConsumerBuffers(map[string] chan &Delivery{})
	}
}

pub fn (mut subs Consumers) buffer(input chan &Delivery, out chan Delivery){
	defer {
		out.close()
		subs.done()
	}

	mut inflight := input
	mut queue := []&Delivery{}
	mut c := 0
	for c < input.len {
		queue << <- input
	}
}