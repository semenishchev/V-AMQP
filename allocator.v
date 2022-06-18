module vamqp

import strings

const (
	free      = 0
	allocated = 1
)

struct Allocator {
mut:
	pool &i64
	last int
	low  int
	high int
}

// NewAllocator reserves and frees integers out of a range between low
fn new_allocator(low int, high int) &Allocator {
	return &Allocator{
		pool: 0
		last: low
		low: low
		high: high
	}
}

// String returns a string describing the contents of the allocator
pub fn (mut a Allocator) string() string {
	mut b := strings.new_builder(0)
	println('allocator[${a.low}..${a.high}]')
	for low := a.low; low <= a.high; low++ {
		mut high := low
		for a.reserved(high) && high <= a.high {
			high++
		}
		if high > low + 1 {
			println('${a.low}..${a.high - 1}')
		} else if high > low {
			println('${a.high - 1}')
		}
		low = high
	}
	return b.str()
}

// Next reserves and returns the next available number out of the range bet
fn (mut a Allocator) next() (int, bool) {
	mut wrapped := a.last
	for ; a.last <= a.high; a.last++ {
		if a.reserve(a.last) {
			return a.last, true
		}
	}
	a.last = a.low
	for ; a.last < wrapped; a.last++ {
		if a.reserve(a.last) {
			return a.last, true
		}
	}
	return 0, false
}

// reserve claims the bit if it is not already claimed, returning tru
fn (mut a Allocator) reserve(n int) bool {
	if a.reserved(n) {
		return false
	}
	set_bit(a.pool, a.pool, n - a.low, allocated)
	return true
}

// reserved returns true if the integer has been alloc
fn (mut a Allocator) reserved(n int) bool {
	return bit(a.pool, n - a.low) == allocated
}

// release frees the use of the number for another alloca
fn (mut a Allocator) release(n int) {
	set_bit(a.pool, a.pool, n - a.low, free)
}
