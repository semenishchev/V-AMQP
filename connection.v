module main

import sync
import io
import time

type Dial = fn (network string, address string) Connection

struct Config {
	sasl []Authentication
	v_host string
	channel_max int
	frame_size int
	heartbeat time.Time

	properties Table
	locale string
	dial Dial
}

struct Connection {
	destructor sync.Once  // shutdown once
	send_m      sync.Mutex // conn writer mutex
	m          sync.Mutex // struct field mutex

	conn io.ReaderWriter

	// rpc       chan message
	writer    &io.Writer
	sends     chan time.Time     // timestamps of each frame sent
	deadlines chan ReadDeadliner // heartbeater updates read deadlines

	allocator &Allocator // id generator valid after openTune
	channels  map[u16]&Channel

	no_notify bool // true when we will never notify again
	closes   []chan &AmqpError
	blocks   []chan Blocking

	errors chan &AmqpError

	config Config // The negotiated Config after connection.open

	major      int      // Server's major version
	minor      int      // Server's minor version
	properties Table    // Server properties
	locales    []string // Server locales

	closed int // Will be 1 if the connection is closed, 0 otherwise. Should only be accessed as atomic
}

interface ReadDeadliner {
	set_read_deadline(time.Time)
}
