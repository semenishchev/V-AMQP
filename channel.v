module main

import sync

const (
	frame_header_size = 1 + 2 + 4 + 1
)


struct Channel {
	destructor sync.Once
	m          sync.Mutex // struct field mutex
	confirm_m  sync.Mutex // publisher confirms state mutex
	notify_m   sync.RwMutex

	connection &Connection
}

