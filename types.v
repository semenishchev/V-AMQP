module vamqp
import time
import io

// Constants for standard AMQP 0-9-1 exchange types.

// 	bool, byte, i16, int, i64, f32, f64, string, []byte, Decimal, time.Time, None
type Any = bool | byte | i16 | int | i64 | f32 | f64 | string | []byte | Decmical | time.Time | Table | None | []Any
const (
	exchange_direct  = "direct"
	exchange_fanout  = "fanout"
	exchange_topic   = "topic"
	exchange_headers = "headers"
)

// Errors returned by the library.
const (
    // ErrClosed is returned when the channel or connection is not open
	err_closed =           &AmqpError{code: channel_error, reason: "channel/connection is not open"}

	// ErrChannelMax is returned when Connection.Channel has been called enough
	// times that all channel IDs have been exhausted in the client or the
	// server.
	err_channel_max =      &AmqpError{code: channel_error, reason: "channel id space exhausted"}
	
	// ErrSASL is returned from Dial when the authentication mechanism could not
	// be negoated.
	err_sasl =             &AmqpError{code: access_refused, reason: "SASL could not negotiate a shared mechanism"}

	// ErrCredentials is returned when the authenticated client is not authorized
	// to any vhost.
	err_credentials =      &AmqpError{code: access_refused, reason: "username or password not allowed"}

	// ErrVhost is returned when the authenticated user is not permitted to
	// access the requested Vhost.
	err_vhost =            &AmqpError{code: access_refused, reason: "no access to this vhost"}

	// ErrSyntax is hard protocol error, indicating an unsupported protocol,
	// implementation or encoding.
	err_syntax =           &AmqpError{code: syntax_error, reason: "invalid field or value inside of a frame"}

	// ErrFrame is returned when the protocol frame cannot be read from the
	// server, indicating an unsupported protocol or unsupported frame type.
	err_frame =            &AmqpError{code: frame_error, reason: "frame could not be parsed"}

	// ErrCommandInvalid is returned when the server sends an unexpected response
	// to this requested message type. This indicates a bug in this client.
	err_command_invalid =  &AmqpError{code: command_invalid, reason: "unexpected command received"}

	// ErrUnexpectedFrame is returned when something other than a method or
	// heartbeat frame is delivered to the Connection, indicating a bug in the
	// client.
	err_unexpected_frame = &AmqpError{code: unexpected_frame, reason: "unexpected frame received"}

	// ErrFieldType is returned when writing a message containing a V (Go) type unsupported by AMQP.
	err_field_type =       &AmqpError{code: syntax_error, reason: "unsupported table field type"}
)

// Error captures the code and reason a channel or connection has been closed
// by the server.
struct AmqpError {
	code    int
	reason  string
	server  bool
	recover bool
}

pub fn new_error(code int, reason string) &AmqpError {
	return &AmqpError{code: code, reason: reason}
}

pub fn (e AmqpError) error() string {
	return "Exception ${e.code} Reason: ${e.reason}"
}

// Used by header frames to capture routing and header information
struct Properties {
	contenttype_     string    // MIME content type
	content_encoding string    // MIME content encoding
	headers          Table     // Application or header exchange table
	delivery_mode    u8        // queue implementation use - Transient (1) or Persistent (2)
	priority         u8        // queue implementation use - 0 to 9
	correlation_id   string    // application use - correlation identifier
	reply_to         string    // application use - address to to reply to (ex: RPC)
	expiration       string    // implementation use - message expiration spec
	message_id       string    // application use - message identifier
	timestamp        time.Time // application use - message timestamp
	type_            string    // application use - message type name
	user_id          string    // application use - creating user id
	app_id           string    // application use - creating application
	reserved         string    // was cluster-id - process for buffer consumption
}

// DeliveryMode.  Transient means higher throughput but messages will not be
// restored on broker restart.  The delivery mode of publishings is unrelated
// to the durability of the queues they reside on.  Transient messages will
// not be restored to durable queues, persistent messages will be restored to
// durable queues and lost on non-durable queues during server restart.
//
// This remains typed as uint8 to match Publishing.DeliveryMode.  Other
// delivery modes specific to custom queue implementations are not enumerated
// here.
const (
	transient  = u8(1)
	persistent = u8(2)
)

// The property flags are an array of bits that indicate the presence or
// absence of each property value in sequence.  The bits are ordered from most
// high to low - bit 15 indicates the first property.
const (
	flag_content_type     = 0x8000
	flag_content_encoding = 0x4000
	flag_headers          = 0x2000
	flag_delivery_mode    = 0x1000
	flag_priority         = 0x0800
	flag_correlation_id   = 0x0400
	flag_reply_to         = 0x0200
	flag_expiration       = 0x0100
	flag_message_id       = 0x0080
	flag_timestamp        = 0x0040
	flag_type             = 0x0020
	flag_user_id          = 0x0010
	flag_app_id           = 0x0008
	flag_reserved1        = 0x0004
)

struct Blocking {
	active bool   // TCP pushback active/inactive on server
	reason string // Server reason for activation
}

// Queue captures the current server state of the queue on the server returned
// from Channel.queue_declare or Channel.queue_inspect.
struct Queue {
	name      string // server confirmed or generated name
	messages  int    // count of messages not awaiting acknowledgment
	consumers int    // number of consumers receiving deliveries
}

// Publishing captures the client message sent to the server.  The fields
// outside of the Headers table included in this struct mirror the underlying
// fields in the content frame.  They use native types for convenience and
// efficiency.
struct Publishing {
	headers          Table     // headers table

	content_type     string    // MIME content type
	content_encoding string    // MIME content encoding
	delivery_mode    u8        // Transient (0 or 1) or Persistent (2)
	priority         u8        // 0 to 9
	correlation_id   string    // correlation identifier
	reply_to         string    // address to to reply to (ex: RPC)
	expiration       string    // message expiration spec
	message_id       string    // message identifier
	timestamp        time.Time // message timestamp
	type_            string    // message type name
	user_id          string    // creating user id - ex: "guest"
	app_id           string    // creating application id
	
	body             []byte    // the application specific payload of the message
}

struct Confirmation {
	delivery_tag u64
	ack 	     bool
}

struct Decmical {
	scale u8
	value int
}

type Table = map[string]Any

struct None{}

//  bool, byte, int, int16, int32, int64, float32, float64, string, []byte, Decimal, time.Time:
// quote each word line up
// "bool", "byte", "int", "int16", "int32", "int64", "float32", "float64", "string", "[]byte", "Decimal", "time.Time"

pub fn validate_field(f Any) bool {
	if f is Table {
		for key, value in f {
			if !validate_field(key) {
				return false
			}
			if !validate_field(value) {
				return false
			}
		}
	} else if f is []Any {
		for value in f {
			if !validate_field(value) {
				return false
			}
		}
	}
	return false
}

type TagSet = []u64

// func (set tagSet) Len() int              { return len(set) }
// func (set tagSet) Less(i, j int) bool    { return (set)[i] < (set)[j] }
// func (set tagSet) Swap(i, j int)         { (set)[i], (set)[j] = (set)[j], (set)[i] }
// func (set *tagSet) Push(tag interface{}) { *set = append(*set, tag.(uint64)) }
// func (set *tagSet) Pop() interface{} {
// 	val := (*set)[len(*set)-1]
// 	*set = (*set)[:len(*set)-1]
// 	return val
// }

pub fn (set TagSet) less(i int, j int) bool {
	return (set)[i] < (set)[j]
}

pub fn (mut set TagSet) swap(i int, j int) {
	i_val := set[i]
	j_val := set[j]
	set[i] = j_val
	set[j] = i_val

}

pub fn (mut set TagSet) push(tag u64) {
	set << tag
}

interface Message {
	id() (u16, u16)
	wait() bool
	read(io.Reader) ?
	write(io.Writer) ?
}

interface MessageWithContent {
	Message
	get_content() (Properties, []byte)
	set_content(Properties, []byte)
}
/*
The base interface implemented as:

2.3.5  frame Details

All frames consist of a header (7 octets), a payload of arbitrary size, and a 'frame-end' octet that detects
malformed frames:

  0      1         3             7                  size+7 size+8
  +------+---------+-------------+  +------------+  +-----------+
  | type | channel |     size    |  |  payload   |  | frame-end |
  +------+---------+-------------+  +------------+  +-----------+
   octet   short         long         size octets       octet

To read a frame, we:

 1. Read the header and check the frame type and channel.
 2. Depending on the frame type, we read the payload and process it.
 3. Read the frame end octet.

In realistic implementations where performance is a concern, we would use
“read-ahead buffering” or “gathering reads” to avoid doing three separate
system calls to read a frame.

*/

interface Frame {
	write(io.Writer) ?
	channel() u16
}

struct VReader {
	r io.Reader
}

struct VWriter {
	w io.Writer
}

struct ProtocolHeader {}

pub fn (h ProtocolHeader) write(mut w io.Writer) ? {
	mut to_write := []u8{cap: 8}
	to_write << 'AMQP'.bytes()
	to_write << 0
	to_write << 0
	to_write << 9
	to_write << 1
	w.write(to_write) or {
		return err
	}
}

pub fn (h ProtocolHeader) channel() u16 {
	panic("only valid as initial handshake")
}

