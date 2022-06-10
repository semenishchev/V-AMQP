module main

const (
	free = 0
	allocated = 1
)

struct Allocator {
	pool *u64
	last int
	low int
	high int
}

fn new_allocator(low int, high int) {
	return &Allocator{
		pool: 0
		last: low
		low: low
		high: high
	}
}