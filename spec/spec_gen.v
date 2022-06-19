
// Copyright (c) 2021 VMware, Inc. or its affiliates. All Rights Reserved.
// Copyright (c) 2012-2021, Sean Treadway, SoundCloud Ltd.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/* GENERATED FILE - DO NOT EDIT */
/* Rebuild from the spec/gen.go tool */


module vamqp
import encoding.binary
import io

// Error codes that can be sent from the server during a connection or
// channel exception or used by the client to indicate a class of error like
// ErrCredentials.  The text of the error is likely more interesting than
// these constants.
const ( 
	frame_method = 1
	frame_header = 2
	frame_body = 3
	frame_heartbeat = 8
	frame_min_size = 4096
	frame_end = 206
	reply_success = 200
	content_too_large = 311
	no_route = 312
	no_consumers = 313
	connection_forced = 320
	invalid_path = 402
	access_refused = 403
	not_found = 404
	resource_locked = 405
	precondition_failed = 406
	frame_error = 501
	syntax_error = 502
	command_invalid = 503
	channel_error = 504
	unexpected_frame = 505
	resource_error = 506
	not_allowed = 530
	not_implemented = 540
	internal_error = 541 
)

fn is_soft_exception_code(code int) bool {
	match code {
		         311 {
			return true
		}  312 {
			return true
		}  313 {
			return true
		}    403 {
			return true
		}  404 {
			return true
		}  405 {
			return true
		}  406 {
			return true
		}         
	}
	return false
}

struct ConnectionStart {
	mut:
	
	versionMajor u8 
	versionMinor u8 
	serverProperties Table 
	mechanisms string 
	locales string 
	
}

fn (msg *ConnectionStart) id() (u16, u16) {
	return 10, 10
}

fn (msg *ConnectionStart) wait() (bool) {
	return true
}

fn (msg *ConnectionStart) write(w io.Writer) {
	
	
     if err = binary.Write(w, binary.BigEndian, msg.versionMajor); err != nil { return }
     if err = binary.Write(w, binary.BigEndian, msg.versionMinor); err != nil { return }
    
  
     if err = writeTable(w, msg.serverProperties); err != nil { return }
    
  
     if err = writeLongstr(w, msg.mechanisms); err != nil { return }
     if err = writeLongstr(w, msg.locales); err != nil { return }
    
  
	return
}

fn (msg *ConnectionStart) read(r io.Reader) (err error) {


     if err = binary.Read(r, binary.BigEndian, &msg.versionMajor); err != nil { return }
     if err = binary.Read(r, binary.BigEndian, &msg.versionMinor); err != nil { return }
    
  
     if msg.serverProperties, err = readTable(r); err != nil { return }
    
  
     if msg.mechanisms, err = readLongstr(r); err != nil { return }
     if msg.locales, err = readLongstr(r); err != nil { return }
    
  
    return
}

struct ConnectionStartOk {
	mut:
	
	clientProperties Table 
	mechanism string 
	response string 
	locale string 
	
}

fn (msg *ConnectionStartOk) id() (u16, u16) {
	return 10, 11
}

fn (msg *ConnectionStartOk) wait() (bool) {
	return true
}

fn (msg *ConnectionStartOk) write(w io.Writer) {
	
	
     if err = writeTable(w, msg.clientProperties); err != nil { return }
    
  
     if err = writeShortstr(w, msg.mechanism); err != nil { return }
    
  
     if err = writeLongstr(w, msg.response); err != nil { return }
    
  
     if err = writeShortstr(w, msg.locale); err != nil { return }
    
  
	return
}

fn (msg *ConnectionStartOk) read(r io.Reader) (err error) {


     if msg.clientProperties, err = readTable(r); err != nil { return }
    
  
     if msg.mechanism, err = readShortstr(r); err != nil { return }
    
  
     if msg.response, err = readLongstr(r); err != nil { return }
    
  
     if msg.locale, err = readShortstr(r); err != nil { return }
    
  
    return
}

struct ConnectionSecure {
	mut:
	
	challenge string 
	
}

fn (msg *ConnectionSecure) id() (u16, u16) {
	return 10, 20
}

fn (msg *ConnectionSecure) wait() (bool) {
	return true
}

fn (msg *ConnectionSecure) write(w io.Writer) {
	
	
     if err = writeLongstr(w, msg.challenge); err != nil { return }
    
  
	return
}

fn (msg *ConnectionSecure) read(r io.Reader) (err error) {


     if msg.challenge, err = readLongstr(r); err != nil { return }
    
  
    return
}

struct ConnectionSecureOk {
	mut:
	
	response string 
	
}

fn (msg *ConnectionSecureOk) id() (u16, u16) {
	return 10, 21
}

fn (msg *ConnectionSecureOk) wait() (bool) {
	return true
}

fn (msg *ConnectionSecureOk) write(w io.Writer) {
	
	
     if err = writeLongstr(w, msg.response); err != nil { return }
    
  
	return
}

fn (msg *ConnectionSecureOk) read(r io.Reader) (err error) {


     if msg.response, err = readLongstr(r); err != nil { return }
    
  
    return
}

struct ConnectionTune {
	mut:
	
	channelMax u16 
	frameMax u32 
	heartbeat u16 
	
}

fn (msg *ConnectionTune) id() (u16, u16) {
	return 10, 30
}

fn (msg *ConnectionTune) wait() (bool) {
	return true
}

fn (msg *ConnectionTune) write(w io.Writer) {
	
	
     if err = binary.Write(w, binary.BigEndian, msg.channelMax); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.frameMax); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.heartbeat); err != nil { return }
    
  
	return
}

fn (msg *ConnectionTune) read(r io.Reader) (err error) {


     if err = binary.Read(r, binary.BigEndian, &msg.channelMax); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.frameMax); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.heartbeat); err != nil { return }
    
  
    return
}

struct ConnectionTuneOk {
	mut:
	
	channelMax u16 
	frameMax u32 
	heartbeat u16 
	
}

fn (msg *ConnectionTuneOk) id() (u16, u16) {
	return 10, 31
}

fn (msg *ConnectionTuneOk) wait() (bool) {
	return true
}

fn (msg *ConnectionTuneOk) write(w io.Writer) {
	
	
     if err = binary.Write(w, binary.BigEndian, msg.channelMax); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.frameMax); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.heartbeat); err != nil { return }
    
  
	return
}

fn (msg *ConnectionTuneOk) read(r io.Reader) (err error) {


     if err = binary.Read(r, binary.BigEndian, &msg.channelMax); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.frameMax); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.heartbeat); err != nil { return }
    
  
    return
}

struct ConnectionOpen {
	mut:
	
	virtualHost string 
	reserved1 string 
	reserved2 bool 
	
}

fn (msg *ConnectionOpen) id() (u16, u16) {
	return 10, 40
}

fn (msg *ConnectionOpen) wait() (bool) {
	return true
}

fn (msg *ConnectionOpen) write(w io.Writer) {
	mut bits u8
	
     if err = writeShortstr(w, msg.virtualHost); err != nil { return }
     if err = writeShortstr(w, msg.reserved1); err != nil { return }
    
  
    
    if msg.reserved2 { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *ConnectionOpen) read(r io.Reader) (err error) {
var bits u8

     if msg.virtualHost, err = readShortstr(r); err != nil { return }
     if msg.reserved1, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.reserved2 = (bits & (1 << 0) > 0)
    
  
    return
}

struct ConnectionOpenOk {
	mut:
	
	reserved1 string 
	
}

fn (msg *ConnectionOpenOk) id() (u16, u16) {
	return 10, 41
}

fn (msg *ConnectionOpenOk) wait() (bool) {
	return true
}

fn (msg *ConnectionOpenOk) write(w io.Writer) {
	
	
     if err = writeShortstr(w, msg.reserved1); err != nil { return }
    
  
	return
}

fn (msg *ConnectionOpenOk) read(r io.Reader) (err error) {


     if msg.reserved1, err = readShortstr(r); err != nil { return }
    
  
    return
}

struct ConnectionClose {
	mut:
	
	replyCode u16 
	replyText string 
	classId u16 
	methodId u16 
	
}

fn (msg *ConnectionClose) id() (u16, u16) {
	return 10, 50
}

fn (msg *ConnectionClose) wait() (bool) {
	return true
}

fn (msg *ConnectionClose) write(w io.Writer) {
	
	
     if err = binary.Write(w, binary.BigEndian, msg.replyCode); err != nil { return }
    
  
     if err = writeShortstr(w, msg.replyText); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.classId); err != nil { return }
     if err = binary.Write(w, binary.BigEndian, msg.methodId); err != nil { return }
    
  
	return
}

fn (msg *ConnectionClose) read(r io.Reader) (err error) {


     if err = binary.Read(r, binary.BigEndian, &msg.replyCode); err != nil { return }
    
  
     if msg.replyText, err = readShortstr(r); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.classId); err != nil { return }
     if err = binary.Read(r, binary.BigEndian, &msg.methodId); err != nil { return }
    
  
    return
}

struct ConnectionCloseOk {
	mut:
	
	
}

fn (msg *ConnectionCloseOk) id() (u16, u16) {
	return 10, 51
}

fn (msg *ConnectionCloseOk) wait() (bool) {
	return true
}

fn (msg *ConnectionCloseOk) write(w io.Writer) {
	
	
	return
}

fn (msg *ConnectionCloseOk) read(r io.Reader) (err error) {


    return
}

struct ConnectionBlocked {
	mut:
	
	reason string 
	
}

fn (msg *ConnectionBlocked) id() (u16, u16) {
	return 10, 60
}

fn (msg *ConnectionBlocked) wait() (bool) {
	return false
}

fn (msg *ConnectionBlocked) write(w io.Writer) {
	
	
     if err = writeShortstr(w, msg.reason); err != nil { return }
    
  
	return
}

fn (msg *ConnectionBlocked) read(r io.Reader) (err error) {


     if msg.reason, err = readShortstr(r); err != nil { return }
    
  
    return
}

struct ConnectionUnblocked {
	mut:
	
	
}

fn (msg *ConnectionUnblocked) id() (u16, u16) {
	return 10, 61
}

fn (msg *ConnectionUnblocked) wait() (bool) {
	return false
}

fn (msg *ConnectionUnblocked) write(w io.Writer) {
	
	
	return
}

fn (msg *ConnectionUnblocked) read(r io.Reader) (err error) {


    return
}

struct ChannelOpen {
	mut:
	
	reserved1 string 
	
}

fn (msg *ChannelOpen) id() (u16, u16) {
	return 20, 10
}

fn (msg *ChannelOpen) wait() (bool) {
	return true
}

fn (msg *ChannelOpen) write(w io.Writer) {
	
	
     if err = writeShortstr(w, msg.reserved1); err != nil { return }
    
  
	return
}

fn (msg *ChannelOpen) read(r io.Reader) (err error) {


     if msg.reserved1, err = readShortstr(r); err != nil { return }
    
  
    return
}

struct ChannelOpenOk {
	mut:
	
	reserved1 string 
	
}

fn (msg *ChannelOpenOk) id() (u16, u16) {
	return 20, 11
}

fn (msg *ChannelOpenOk) wait() (bool) {
	return true
}

fn (msg *ChannelOpenOk) write(w io.Writer) {
	
	
     if err = writeLongstr(w, msg.reserved1); err != nil { return }
    
  
	return
}

fn (msg *ChannelOpenOk) read(r io.Reader) (err error) {


     if msg.reserved1, err = readLongstr(r); err != nil { return }
    
  
    return
}

struct ChannelFlow {
	mut:
	
	active bool 
	
}

fn (msg *ChannelFlow) id() (u16, u16) {
	return 20, 20
}

fn (msg *ChannelFlow) wait() (bool) {
	return true
}

fn (msg *ChannelFlow) write(w io.Writer) {
	mut bits u8
	
    
    if msg.active { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *ChannelFlow) read(r io.Reader) (err error) {
var bits u8

    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.active = (bits & (1 << 0) > 0)
    
  
    return
}

struct ChannelFlowOk {
	mut:
	
	active bool 
	
}

fn (msg *ChannelFlowOk) id() (u16, u16) {
	return 20, 21
}

fn (msg *ChannelFlowOk) wait() (bool) {
	return false
}

fn (msg *ChannelFlowOk) write(w io.Writer) {
	mut bits u8
	
    
    if msg.active { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *ChannelFlowOk) read(r io.Reader) (err error) {
var bits u8

    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.active = (bits & (1 << 0) > 0)
    
  
    return
}

struct ChannelClose {
	mut:
	
	replyCode u16 
	replyText string 
	classId u16 
	methodId u16 
	
}

fn (msg *ChannelClose) id() (u16, u16) {
	return 20, 40
}

fn (msg *ChannelClose) wait() (bool) {
	return true
}

fn (msg *ChannelClose) write(w io.Writer) {
	
	
     if err = binary.Write(w, binary.BigEndian, msg.replyCode); err != nil { return }
    
  
     if err = writeShortstr(w, msg.replyText); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.classId); err != nil { return }
     if err = binary.Write(w, binary.BigEndian, msg.methodId); err != nil { return }
    
  
	return
}

fn (msg *ChannelClose) read(r io.Reader) (err error) {


     if err = binary.Read(r, binary.BigEndian, &msg.replyCode); err != nil { return }
    
  
     if msg.replyText, err = readShortstr(r); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.classId); err != nil { return }
     if err = binary.Read(r, binary.BigEndian, &msg.methodId); err != nil { return }
    
  
    return
}

struct ChannelCloseOk {
	mut:
	
	
}

fn (msg *ChannelCloseOk) id() (u16, u16) {
	return 20, 41
}

fn (msg *ChannelCloseOk) wait() (bool) {
	return true
}

fn (msg *ChannelCloseOk) write(w io.Writer) {
	
	
	return
}

fn (msg *ChannelCloseOk) read(r io.Reader) (err error) {


    return
}

struct ExchangeDeclare {
	mut:
	
	reserved1 u16 
	exchange string 
	type string 
	passive bool 
	durable bool 
	autoDelete bool 
	internal bool 
	noWait bool 
	arguments Table 
	
}

fn (msg *ExchangeDeclare) id() (u16, u16) {
	return 40, 10
}

fn (msg *ExchangeDeclare) wait() (bool) {
	return true
}

fn (msg *ExchangeDeclare) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.exchange); err != nil { return }
     if err = writeShortstr(w, msg.type); err != nil { return }
    
  
    
    if msg.passive { bits |= 1 << 0 }
    
    if msg.durable { bits |= 1 << 1 }
    
    if msg.autoDelete { bits |= 1 << 2 }
    
    if msg.internal { bits |= 1 << 3 }
    
    if msg.noWait { bits |= 1 << 4 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
     if err = writeTable(w, msg.arguments); err != nil { return }
    
  
	return
}

fn (msg *ExchangeDeclare) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.exchange, err = readShortstr(r); err != nil { return }
     if msg.type, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.passive = (bits & (1 << 0) > 0)
     msg.durable = (bits & (1 << 1) > 0)
     msg.autoDelete = (bits & (1 << 2) > 0)
     msg.internal = (bits & (1 << 3) > 0)
     msg.noWait = (bits & (1 << 4) > 0)
    
  
     if msg.arguments, err = readTable(r); err != nil { return }
    
  
    return
}

struct ExchangeDeclareOk {
	mut:
	
	
}

fn (msg *ExchangeDeclareOk) id() (u16, u16) {
	return 40, 11
}

fn (msg *ExchangeDeclareOk) wait() (bool) {
	return true
}

fn (msg *ExchangeDeclareOk) write(w io.Writer) {
	
	
	return
}

fn (msg *ExchangeDeclareOk) read(r io.Reader) (err error) {


    return
}

struct ExchangeDelete {
	mut:
	
	reserved1 u16 
	exchange string 
	ifUnused bool 
	noWait bool 
	
}

fn (msg *ExchangeDelete) id() (u16, u16) {
	return 40, 20
}

fn (msg *ExchangeDelete) wait() (bool) {
	return true
}

fn (msg *ExchangeDelete) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.exchange); err != nil { return }
    
  
    
    if msg.ifUnused { bits |= 1 << 0 }
    
    if msg.noWait { bits |= 1 << 1 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *ExchangeDelete) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.exchange, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.ifUnused = (bits & (1 << 0) > 0)
     msg.noWait = (bits & (1 << 1) > 0)
    
  
    return
}

struct ExchangeDeleteOk {
	mut:
	
	
}

fn (msg *ExchangeDeleteOk) id() (u16, u16) {
	return 40, 21
}

fn (msg *ExchangeDeleteOk) wait() (bool) {
	return true
}

fn (msg *ExchangeDeleteOk) write(w io.Writer) {
	
	
	return
}

fn (msg *ExchangeDeleteOk) read(r io.Reader) (err error) {


    return
}

struct ExchangeBind {
	mut:
	
	reserved1 u16 
	destination string 
	source string 
	routingKey string 
	noWait bool 
	arguments Table 
	
}

fn (msg *ExchangeBind) id() (u16, u16) {
	return 40, 30
}

fn (msg *ExchangeBind) wait() (bool) {
	return true
}

fn (msg *ExchangeBind) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.destination); err != nil { return }
     if err = writeShortstr(w, msg.source); err != nil { return }
     if err = writeShortstr(w, msg.routingKey); err != nil { return }
    
  
    
    if msg.noWait { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
     if err = writeTable(w, msg.arguments); err != nil { return }
    
  
	return
}

fn (msg *ExchangeBind) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.destination, err = readShortstr(r); err != nil { return }
     if msg.source, err = readShortstr(r); err != nil { return }
     if msg.routingKey, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.noWait = (bits & (1 << 0) > 0)
    
  
     if msg.arguments, err = readTable(r); err != nil { return }
    
  
    return
}

struct ExchangeBindOk {
	mut:
	
	
}

fn (msg *ExchangeBindOk) id() (u16, u16) {
	return 40, 31
}

fn (msg *ExchangeBindOk) wait() (bool) {
	return true
}

fn (msg *ExchangeBindOk) write(w io.Writer) {
	
	
	return
}

fn (msg *ExchangeBindOk) read(r io.Reader) (err error) {


    return
}

struct ExchangeUnbind {
	mut:
	
	reserved1 u16 
	destination string 
	source string 
	routingKey string 
	noWait bool 
	arguments Table 
	
}

fn (msg *ExchangeUnbind) id() (u16, u16) {
	return 40, 40
}

fn (msg *ExchangeUnbind) wait() (bool) {
	return true
}

fn (msg *ExchangeUnbind) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.destination); err != nil { return }
     if err = writeShortstr(w, msg.source); err != nil { return }
     if err = writeShortstr(w, msg.routingKey); err != nil { return }
    
  
    
    if msg.noWait { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
     if err = writeTable(w, msg.arguments); err != nil { return }
    
  
	return
}

fn (msg *ExchangeUnbind) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.destination, err = readShortstr(r); err != nil { return }
     if msg.source, err = readShortstr(r); err != nil { return }
     if msg.routingKey, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.noWait = (bits & (1 << 0) > 0)
    
  
     if msg.arguments, err = readTable(r); err != nil { return }
    
  
    return
}

struct ExchangeUnbindOk {
	mut:
	
	
}

fn (msg *ExchangeUnbindOk) id() (u16, u16) {
	return 40, 51
}

fn (msg *ExchangeUnbindOk) wait() (bool) {
	return true
}

fn (msg *ExchangeUnbindOk) write(w io.Writer) {
	
	
	return
}

fn (msg *ExchangeUnbindOk) read(r io.Reader) (err error) {


    return
}

struct QueueDeclare {
	mut:
	
	reserved1 u16 
	queue string 
	passive bool 
	durable bool 
	exclusive bool 
	autoDelete bool 
	noWait bool 
	arguments Table 
	
}

fn (msg *QueueDeclare) id() (u16, u16) {
	return 50, 10
}

fn (msg *QueueDeclare) wait() (bool) {
	return true
}

fn (msg *QueueDeclare) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.queue); err != nil { return }
    
  
    
    if msg.passive { bits |= 1 << 0 }
    
    if msg.durable { bits |= 1 << 1 }
    
    if msg.exclusive { bits |= 1 << 2 }
    
    if msg.autoDelete { bits |= 1 << 3 }
    
    if msg.noWait { bits |= 1 << 4 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
     if err = writeTable(w, msg.arguments); err != nil { return }
    
  
	return
}

fn (msg *QueueDeclare) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.queue, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.passive = (bits & (1 << 0) > 0)
     msg.durable = (bits & (1 << 1) > 0)
     msg.exclusive = (bits & (1 << 2) > 0)
     msg.autoDelete = (bits & (1 << 3) > 0)
     msg.noWait = (bits & (1 << 4) > 0)
    
  
     if msg.arguments, err = readTable(r); err != nil { return }
    
  
    return
}

struct QueueDeclareOk {
	mut:
	
	queue string 
	messageCount u32 
	consumerCount u32 
	
}

fn (msg *QueueDeclareOk) id() (u16, u16) {
	return 50, 11
}

fn (msg *QueueDeclareOk) wait() (bool) {
	return true
}

fn (msg *QueueDeclareOk) write(w io.Writer) {
	
	
     if err = writeShortstr(w, msg.queue); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.messageCount); err != nil { return }
     if err = binary.Write(w, binary.BigEndian, msg.consumerCount); err != nil { return }
    
  
	return
}

fn (msg *QueueDeclareOk) read(r io.Reader) (err error) {


     if msg.queue, err = readShortstr(r); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.messageCount); err != nil { return }
     if err = binary.Read(r, binary.BigEndian, &msg.consumerCount); err != nil { return }
    
  
    return
}

struct QueueBind {
	mut:
	
	reserved1 u16 
	queue string 
	exchange string 
	routingKey string 
	noWait bool 
	arguments Table 
	
}

fn (msg *QueueBind) id() (u16, u16) {
	return 50, 20
}

fn (msg *QueueBind) wait() (bool) {
	return true
}

fn (msg *QueueBind) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.queue); err != nil { return }
     if err = writeShortstr(w, msg.exchange); err != nil { return }
     if err = writeShortstr(w, msg.routingKey); err != nil { return }
    
  
    
    if msg.noWait { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
     if err = writeTable(w, msg.arguments); err != nil { return }
    
  
	return
}

fn (msg *QueueBind) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.queue, err = readShortstr(r); err != nil { return }
     if msg.exchange, err = readShortstr(r); err != nil { return }
     if msg.routingKey, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.noWait = (bits & (1 << 0) > 0)
    
  
     if msg.arguments, err = readTable(r); err != nil { return }
    
  
    return
}

struct QueueBindOk {
	mut:
	
	
}

fn (msg *QueueBindOk) id() (u16, u16) {
	return 50, 21
}

fn (msg *QueueBindOk) wait() (bool) {
	return true
}

fn (msg *QueueBindOk) write(w io.Writer) {
	
	
	return
}

fn (msg *QueueBindOk) read(r io.Reader) (err error) {


    return
}

struct QueueUnbind {
	mut:
	
	reserved1 u16 
	queue string 
	exchange string 
	routingKey string 
	arguments Table 
	
}

fn (msg *QueueUnbind) id() (u16, u16) {
	return 50, 50
}

fn (msg *QueueUnbind) wait() (bool) {
	return true
}

fn (msg *QueueUnbind) write(w io.Writer) {
	
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.queue); err != nil { return }
     if err = writeShortstr(w, msg.exchange); err != nil { return }
     if err = writeShortstr(w, msg.routingKey); err != nil { return }
    
  
     if err = writeTable(w, msg.arguments); err != nil { return }
    
  
	return
}

fn (msg *QueueUnbind) read(r io.Reader) (err error) {


     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.queue, err = readShortstr(r); err != nil { return }
     if msg.exchange, err = readShortstr(r); err != nil { return }
     if msg.routingKey, err = readShortstr(r); err != nil { return }
    
  
     if msg.arguments, err = readTable(r); err != nil { return }
    
  
    return
}

struct QueueUnbindOk {
	mut:
	
	
}

fn (msg *QueueUnbindOk) id() (u16, u16) {
	return 50, 51
}

fn (msg *QueueUnbindOk) wait() (bool) {
	return true
}

fn (msg *QueueUnbindOk) write(w io.Writer) {
	
	
	return
}

fn (msg *QueueUnbindOk) read(r io.Reader) (err error) {


    return
}

struct QueuePurge {
	mut:
	
	reserved1 u16 
	queue string 
	noWait bool 
	
}

fn (msg *QueuePurge) id() (u16, u16) {
	return 50, 30
}

fn (msg *QueuePurge) wait() (bool) {
	return true
}

fn (msg *QueuePurge) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.queue); err != nil { return }
    
  
    
    if msg.noWait { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *QueuePurge) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.queue, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.noWait = (bits & (1 << 0) > 0)
    
  
    return
}

struct QueuePurgeOk {
	mut:
	
	messageCount u32 
	
}

fn (msg *QueuePurgeOk) id() (u16, u16) {
	return 50, 31
}

fn (msg *QueuePurgeOk) wait() (bool) {
	return true
}

fn (msg *QueuePurgeOk) write(w io.Writer) {
	
	
     if err = binary.Write(w, binary.BigEndian, msg.messageCount); err != nil { return }
    
  
	return
}

fn (msg *QueuePurgeOk) read(r io.Reader) (err error) {


     if err = binary.Read(r, binary.BigEndian, &msg.messageCount); err != nil { return }
    
  
    return
}

struct QueueDelete {
	mut:
	
	reserved1 u16 
	queue string 
	ifUnused bool 
	ifEmpty bool 
	noWait bool 
	
}

fn (msg *QueueDelete) id() (u16, u16) {
	return 50, 40
}

fn (msg *QueueDelete) wait() (bool) {
	return true
}

fn (msg *QueueDelete) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.queue); err != nil { return }
    
  
    
    if msg.ifUnused { bits |= 1 << 0 }
    
    if msg.ifEmpty { bits |= 1 << 1 }
    
    if msg.noWait { bits |= 1 << 2 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *QueueDelete) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.queue, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.ifUnused = (bits & (1 << 0) > 0)
     msg.ifEmpty = (bits & (1 << 1) > 0)
     msg.noWait = (bits & (1 << 2) > 0)
    
  
    return
}

struct QueueDeleteOk {
	mut:
	
	messageCount u32 
	
}

fn (msg *QueueDeleteOk) id() (u16, u16) {
	return 50, 41
}

fn (msg *QueueDeleteOk) wait() (bool) {
	return true
}

fn (msg *QueueDeleteOk) write(w io.Writer) {
	
	
     if err = binary.Write(w, binary.BigEndian, msg.messageCount); err != nil { return }
    
  
	return
}

fn (msg *QueueDeleteOk) read(r io.Reader) (err error) {


     if err = binary.Read(r, binary.BigEndian, &msg.messageCount); err != nil { return }
    
  
    return
}

struct BasicQos {
	mut:
	
	prefetchSize u32 
	prefetchCount u16 
	global bool 
	
}

fn (msg *BasicQos) id() (u16, u16) {
	return 60, 10
}

fn (msg *BasicQos) wait() (bool) {
	return true
}

fn (msg *BasicQos) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.prefetchSize); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.prefetchCount); err != nil { return }
    
  
    
    if msg.global { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *BasicQos) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.prefetchSize); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.prefetchCount); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.global = (bits & (1 << 0) > 0)
    
  
    return
}

struct BasicQosOk {
	mut:
	
	
}

fn (msg *BasicQosOk) id() (u16, u16) {
	return 60, 11
}

fn (msg *BasicQosOk) wait() (bool) {
	return true
}

fn (msg *BasicQosOk) write(w io.Writer) {
	
	
	return
}

fn (msg *BasicQosOk) read(r io.Reader) (err error) {


    return
}

struct BasicConsume {
	mut:
	
	reserved1 u16 
	queue string 
	consumerTag string 
	noLocal bool 
	noAck bool 
	exclusive bool 
	noWait bool 
	arguments Table 
	
}

fn (msg *BasicConsume) id() (u16, u16) {
	return 60, 20
}

fn (msg *BasicConsume) wait() (bool) {
	return true
}

fn (msg *BasicConsume) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.queue); err != nil { return }
     if err = writeShortstr(w, msg.consumerTag); err != nil { return }
    
  
    
    if msg.noLocal { bits |= 1 << 0 }
    
    if msg.noAck { bits |= 1 << 1 }
    
    if msg.exclusive { bits |= 1 << 2 }
    
    if msg.noWait { bits |= 1 << 3 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
     if err = writeTable(w, msg.arguments); err != nil { return }
    
  
	return
}

fn (msg *BasicConsume) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.queue, err = readShortstr(r); err != nil { return }
     if msg.consumerTag, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.noLocal = (bits & (1 << 0) > 0)
     msg.noAck = (bits & (1 << 1) > 0)
     msg.exclusive = (bits & (1 << 2) > 0)
     msg.noWait = (bits & (1 << 3) > 0)
    
  
     if msg.arguments, err = readTable(r); err != nil { return }
    
  
    return
}

struct BasicConsumeOk {
	mut:
	
	consumerTag string 
	
}

fn (msg *BasicConsumeOk) id() (u16, u16) {
	return 60, 21
}

fn (msg *BasicConsumeOk) wait() (bool) {
	return true
}

fn (msg *BasicConsumeOk) write(w io.Writer) {
	
	
     if err = writeShortstr(w, msg.consumerTag); err != nil { return }
    
  
	return
}

fn (msg *BasicConsumeOk) read(r io.Reader) (err error) {


     if msg.consumerTag, err = readShortstr(r); err != nil { return }
    
  
    return
}

struct BasicCancel {
	mut:
	
	consumerTag string 
	noWait bool 
	
}

fn (msg *BasicCancel) id() (u16, u16) {
	return 60, 30
}

fn (msg *BasicCancel) wait() (bool) {
	return true
}

fn (msg *BasicCancel) write(w io.Writer) {
	mut bits u8
	
     if err = writeShortstr(w, msg.consumerTag); err != nil { return }
    
  
    
    if msg.noWait { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *BasicCancel) read(r io.Reader) (err error) {
var bits u8

     if msg.consumerTag, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.noWait = (bits & (1 << 0) > 0)
    
  
    return
}

struct BasicCancelOk {
	mut:
	
	consumerTag string 
	
}

fn (msg *BasicCancelOk) id() (u16, u16) {
	return 60, 31
}

fn (msg *BasicCancelOk) wait() (bool) {
	return true
}

fn (msg *BasicCancelOk) write(w io.Writer) {
	
	
     if err = writeShortstr(w, msg.consumerTag); err != nil { return }
    
  
	return
}

fn (msg *BasicCancelOk) read(r io.Reader) (err error) {


     if msg.consumerTag, err = readShortstr(r); err != nil { return }
    
  
    return
}

struct BasicPublish {
	mut:
	
	reserved1 u16 
	exchange string 
	routingKey string 
	mandatory bool 
	immediate bool 
	Properties properties
	body []u8
}

fn (msg *BasicPublish) id() (u16, u16) {
	return 60, 40
}

fn (msg *BasicPublish) wait() (bool) {
	return false
}

fn (msg &BasicPublish) getContent() (properties, []u8) {
	return msg.properties, msg.body
}

fn (mut msg BasicPublish) setContent(props properties, body []u8) {
	msg.properties = props 
	msg.body = body
}

fn (msg *BasicPublish) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.exchange); err != nil { return }
     if err = writeShortstr(w, msg.routingKey); err != nil { return }
    
  
    
    if msg.mandatory { bits |= 1 << 0 }
    
    if msg.immediate { bits |= 1 << 1 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *BasicPublish) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.exchange, err = readShortstr(r); err != nil { return }
     if msg.routingKey, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.mandatory = (bits & (1 << 0) > 0)
     msg.immediate = (bits & (1 << 1) > 0)
    
  
    return
}

struct BasicReturn {
	mut:
	
	replyCode u16 
	replyText string 
	exchange string 
	routingKey string 
	Properties properties
	body []u8
}

fn (msg *BasicReturn) id() (u16, u16) {
	return 60, 50
}

fn (msg *BasicReturn) wait() (bool) {
	return false
}

fn (msg &BasicReturn) getContent() (properties, []u8) {
	return msg.properties, msg.body
}

fn (mut msg BasicReturn) setContent(props properties, body []u8) {
	msg.properties = props 
	msg.body = body
}

fn (msg *BasicReturn) write(w io.Writer) {
	
	
     if err = binary.Write(w, binary.BigEndian, msg.replyCode); err != nil { return }
    
  
     if err = writeShortstr(w, msg.replyText); err != nil { return }
     if err = writeShortstr(w, msg.exchange); err != nil { return }
     if err = writeShortstr(w, msg.routingKey); err != nil { return }
    
  
	return
}

fn (msg *BasicReturn) read(r io.Reader) (err error) {


     if err = binary.Read(r, binary.BigEndian, &msg.replyCode); err != nil { return }
    
  
     if msg.replyText, err = readShortstr(r); err != nil { return }
     if msg.exchange, err = readShortstr(r); err != nil { return }
     if msg.routingKey, err = readShortstr(r); err != nil { return }
    
  
    return
}

struct BasicDeliver {
	mut:
	
	consumerTag string 
	deliveryTag u64 
	redelivered bool 
	exchange string 
	routingKey string 
	Properties properties
	body []u8
}

fn (msg *BasicDeliver) id() (u16, u16) {
	return 60, 60
}

fn (msg *BasicDeliver) wait() (bool) {
	return false
}

fn (msg &BasicDeliver) getContent() (properties, []u8) {
	return msg.properties, msg.body
}

fn (mut msg BasicDeliver) setContent(props properties, body []u8) {
	msg.properties = props 
	msg.body = body
}

fn (msg *BasicDeliver) write(w io.Writer) {
	mut bits u8
	
     if err = writeShortstr(w, msg.consumerTag); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.deliveryTag); err != nil { return }
    
  
    
    if msg.redelivered { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
     if err = writeShortstr(w, msg.exchange); err != nil { return }
     if err = writeShortstr(w, msg.routingKey); err != nil { return }
    
  
	return
}

fn (msg *BasicDeliver) read(r io.Reader) (err error) {
var bits u8

     if msg.consumerTag, err = readShortstr(r); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.deliveryTag); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.redelivered = (bits & (1 << 0) > 0)
    
  
     if msg.exchange, err = readShortstr(r); err != nil { return }
     if msg.routingKey, err = readShortstr(r); err != nil { return }
    
  
    return
}

struct BasicGet {
	mut:
	
	reserved1 u16 
	queue string 
	noAck bool 
	
}

fn (msg *BasicGet) id() (u16, u16) {
	return 60, 70
}

fn (msg *BasicGet) wait() (bool) {
	return true
}

fn (msg *BasicGet) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.reserved1); err != nil { return }
    
  
     if err = writeShortstr(w, msg.queue); err != nil { return }
    
  
    
    if msg.noAck { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *BasicGet) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.reserved1); err != nil { return }
    
  
     if msg.queue, err = readShortstr(r); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.noAck = (bits & (1 << 0) > 0)
    
  
    return
}

struct BasicGetOk {
	mut:
	
	deliveryTag u64 
	redelivered bool 
	exchange string 
	routingKey string 
	messageCount u32 
	Properties properties
	body []u8
}

fn (msg *BasicGetOk) id() (u16, u16) {
	return 60, 71
}

fn (msg *BasicGetOk) wait() (bool) {
	return true
}

fn (msg &BasicGetOk) getContent() (properties, []u8) {
	return msg.properties, msg.body
}

fn (mut msg BasicGetOk) setContent(props properties, body []u8) {
	msg.properties = props 
	msg.body = body
}

fn (msg *BasicGetOk) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.deliveryTag); err != nil { return }
    
  
    
    if msg.redelivered { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
     if err = writeShortstr(w, msg.exchange); err != nil { return }
     if err = writeShortstr(w, msg.routingKey); err != nil { return }
    
  
     if err = binary.Write(w, binary.BigEndian, msg.messageCount); err != nil { return }
    
  
	return
}

fn (msg *BasicGetOk) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.deliveryTag); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.redelivered = (bits & (1 << 0) > 0)
    
  
     if msg.exchange, err = readShortstr(r); err != nil { return }
     if msg.routingKey, err = readShortstr(r); err != nil { return }
    
  
     if err = binary.Read(r, binary.BigEndian, &msg.messageCount); err != nil { return }
    
  
    return
}

struct BasicGetEmpty {
	mut:
	
	reserved1 string 
	
}

fn (msg *BasicGetEmpty) id() (u16, u16) {
	return 60, 72
}

fn (msg *BasicGetEmpty) wait() (bool) {
	return true
}

fn (msg *BasicGetEmpty) write(w io.Writer) {
	
	
     if err = writeShortstr(w, msg.reserved1); err != nil { return }
    
  
	return
}

fn (msg *BasicGetEmpty) read(r io.Reader) (err error) {


     if msg.reserved1, err = readShortstr(r); err != nil { return }
    
  
    return
}

struct BasicAck {
	mut:
	
	deliveryTag u64 
	multiple bool 
	
}

fn (msg *BasicAck) id() (u16, u16) {
	return 60, 80
}

fn (msg *BasicAck) wait() (bool) {
	return false
}

fn (msg *BasicAck) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.deliveryTag); err != nil { return }
    
  
    
    if msg.multiple { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *BasicAck) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.deliveryTag); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.multiple = (bits & (1 << 0) > 0)
    
  
    return
}

struct BasicReject {
	mut:
	
	deliveryTag u64 
	requeue bool 
	
}

fn (msg *BasicReject) id() (u16, u16) {
	return 60, 90
}

fn (msg *BasicReject) wait() (bool) {
	return false
}

fn (msg *BasicReject) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.deliveryTag); err != nil { return }
    
  
    
    if msg.requeue { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *BasicReject) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.deliveryTag); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.requeue = (bits & (1 << 0) > 0)
    
  
    return
}

struct BasicRecoverAsync {
	mut:
	
	requeue bool 
	
}

fn (msg *BasicRecoverAsync) id() (u16, u16) {
	return 60, 100
}

fn (msg *BasicRecoverAsync) wait() (bool) {
	return false
}

fn (msg *BasicRecoverAsync) write(w io.Writer) {
	mut bits u8
	
    
    if msg.requeue { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *BasicRecoverAsync) read(r io.Reader) (err error) {
var bits u8

    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.requeue = (bits & (1 << 0) > 0)
    
  
    return
}

struct BasicRecover {
	mut:
	
	requeue bool 
	
}

fn (msg *BasicRecover) id() (u16, u16) {
	return 60, 110
}

fn (msg *BasicRecover) wait() (bool) {
	return true
}

fn (msg *BasicRecover) write(w io.Writer) {
	mut bits u8
	
    
    if msg.requeue { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *BasicRecover) read(r io.Reader) (err error) {
var bits u8

    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.requeue = (bits & (1 << 0) > 0)
    
  
    return
}

struct BasicRecoverOk {
	mut:
	
	
}

fn (msg *BasicRecoverOk) id() (u16, u16) {
	return 60, 111
}

fn (msg *BasicRecoverOk) wait() (bool) {
	return true
}

fn (msg *BasicRecoverOk) write(w io.Writer) {
	
	
	return
}

fn (msg *BasicRecoverOk) read(r io.Reader) (err error) {


    return
}

struct BasicNack {
	mut:
	
	deliveryTag u64 
	multiple bool 
	requeue bool 
	
}

fn (msg *BasicNack) id() (u16, u16) {
	return 60, 120
}

fn (msg *BasicNack) wait() (bool) {
	return false
}

fn (msg *BasicNack) write(w io.Writer) {
	mut bits u8
	
     if err = binary.Write(w, binary.BigEndian, msg.deliveryTag); err != nil { return }
    
  
    
    if msg.multiple { bits |= 1 << 0 }
    
    if msg.requeue { bits |= 1 << 1 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *BasicNack) read(r io.Reader) (err error) {
var bits u8

     if err = binary.Read(r, binary.BigEndian, &msg.deliveryTag); err != nil { return }
    
  
    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.multiple = (bits & (1 << 0) > 0)
     msg.requeue = (bits & (1 << 1) > 0)
    
  
    return
}

struct TxSelect {
	mut:
	
	
}

fn (msg *TxSelect) id() (u16, u16) {
	return 90, 10
}

fn (msg *TxSelect) wait() (bool) {
	return true
}

fn (msg *TxSelect) write(w io.Writer) {
	
	
	return
}

fn (msg *TxSelect) read(r io.Reader) (err error) {


    return
}

struct TxSelectOk {
	mut:
	
	
}

fn (msg *TxSelectOk) id() (u16, u16) {
	return 90, 11
}

fn (msg *TxSelectOk) wait() (bool) {
	return true
}

fn (msg *TxSelectOk) write(w io.Writer) {
	
	
	return
}

fn (msg *TxSelectOk) read(r io.Reader) (err error) {


    return
}

struct TxCommit {
	mut:
	
	
}

fn (msg *TxCommit) id() (u16, u16) {
	return 90, 20
}

fn (msg *TxCommit) wait() (bool) {
	return true
}

fn (msg *TxCommit) write(w io.Writer) {
	
	
	return
}

fn (msg *TxCommit) read(r io.Reader) (err error) {


    return
}

struct TxCommitOk {
	mut:
	
	
}

fn (msg *TxCommitOk) id() (u16, u16) {
	return 90, 21
}

fn (msg *TxCommitOk) wait() (bool) {
	return true
}

fn (msg *TxCommitOk) write(w io.Writer) {
	
	
	return
}

fn (msg *TxCommitOk) read(r io.Reader) (err error) {


    return
}

struct TxRollback {
	mut:
	
	
}

fn (msg *TxRollback) id() (u16, u16) {
	return 90, 30
}

fn (msg *TxRollback) wait() (bool) {
	return true
}

fn (msg *TxRollback) write(w io.Writer) {
	
	
	return
}

fn (msg *TxRollback) read(r io.Reader) (err error) {


    return
}

struct TxRollbackOk {
	mut:
	
	
}

fn (msg *TxRollbackOk) id() (u16, u16) {
	return 90, 31
}

fn (msg *TxRollbackOk) wait() (bool) {
	return true
}

fn (msg *TxRollbackOk) write(w io.Writer) {
	
	
	return
}

fn (msg *TxRollbackOk) read(r io.Reader) (err error) {


    return
}

struct ConfirmSelect {
	mut:
	
	nowait bool 
	
}

fn (msg *ConfirmSelect) id() (u16, u16) {
	return 85, 10
}

fn (msg *ConfirmSelect) wait() (bool) {
	return true
}

fn (msg *ConfirmSelect) write(w io.Writer) {
	mut bits u8
	
    
    if msg.nowait { bits |= 1 << 0 }
    
    if err = binary.Write(w, binary.BigEndian, bits); err != nil { return }
  
	return
}

fn (msg *ConfirmSelect) read(r io.Reader) (err error) {
var bits u8

    if err = binary.Read(r, binary.BigEndian, &bits); err != nil {
      return
    }
     msg.nowait = (bits & (1 << 0) > 0)
    
  
    return
}

struct ConfirmSelectOk {
	mut:
	
	
}

fn (msg *ConfirmSelectOk) id() (u16, u16) {
	return 85, 11
}

fn (msg *ConfirmSelectOk) wait() (bool) {
	return true
}

fn (msg *ConfirmSelectOk) write(w io.Writer) {
	
	
	return
}

fn (msg *ConfirmSelectOk) read(r io.Reader) (err error) {


    return
}

fn (r *reader) parseMethodFrame(channel uint16, size uint32) Frame? {
    mf := &MethodFrame {
      channe;_id: channel,
    }

    if err = binary.Read(r.r, binary.BigEndian, &mf.ClassId); err != nil {
      return
    }

    if err = binary.Read(r.r, binary.BigEndian, &mf.MethodId); err != nil {
      return
    }

	match mf.class_id {
		
		
		10 { // connection
			match mf.MethodId { 
				10 { // connection start
					//fmt.Println("NextMethod: class:10 method:10")
					method := &ConnectionStart{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				11 { // connection start-ok
					//fmt.Println("NextMethod: class:10 method:11")
					method := &ConnectionStartOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				20 { // connection secure
					//fmt.Println("NextMethod: class:10 method:20")
					method := &ConnectionSecure{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				21 { // connection secure-ok
					//fmt.Println("NextMethod: class:10 method:21")
					method := &ConnectionSecureOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				30 { // connection tune
					//fmt.Println("NextMethod: class:10 method:30")
					method := &ConnectionTune{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				31 { // connection tune-ok
					//fmt.Println("NextMethod: class:10 method:31")
					method := &ConnectionTuneOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				40 { // connection open
					//fmt.Println("NextMethod: class:10 method:40")
					method := &ConnectionOpen{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				41 { // connection open-ok
					//fmt.Println("NextMethod: class:10 method:41")
					method := &ConnectionOpenOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				50 { // connection close
					//fmt.Println("NextMethod: class:10 method:50")
					method := &ConnectionClose{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				51 { // connection close-ok
					//fmt.Println("NextMethod: class:10 method:51")
					method := &ConnectionCloseOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				60 { // connection blocked
					//fmt.Println("NextMethod: class:10 method:60")
					method := &ConnectionBlocked{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				61 { // connection unblocked
					//fmt.Println("NextMethod: class:10 method:61")
					method := &ConnectionUnblocked{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				else {
					return error("Bad method frame, unknown method ${mf.method_id} for class ${mf.class_id}")
				}
			}
		}
		
		
		20 { // channel
			match mf.MethodId { 
				10 { // channel open
					//fmt.Println("NextMethod: class:20 method:10")
					method := &ChannelOpen{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				11 { // channel open-ok
					//fmt.Println("NextMethod: class:20 method:11")
					method := &ChannelOpenOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				20 { // channel flow
					//fmt.Println("NextMethod: class:20 method:20")
					method := &ChannelFlow{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				21 { // channel flow-ok
					//fmt.Println("NextMethod: class:20 method:21")
					method := &ChannelFlowOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				40 { // channel close
					//fmt.Println("NextMethod: class:20 method:40")
					method := &ChannelClose{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				41 { // channel close-ok
					//fmt.Println("NextMethod: class:20 method:41")
					method := &ChannelCloseOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				else {
					return error("Bad method frame, unknown method ${mf.method_id} for class ${mf.class_id}")
				}
			}
		}
		
		
		40 { // exchange
			match mf.MethodId { 
				10 { // exchange declare
					//fmt.Println("NextMethod: class:40 method:10")
					method := &ExchangeDeclare{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				11 { // exchange declare-ok
					//fmt.Println("NextMethod: class:40 method:11")
					method := &ExchangeDeclareOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				20 { // exchange delete
					//fmt.Println("NextMethod: class:40 method:20")
					method := &ExchangeDelete{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				21 { // exchange delete-ok
					//fmt.Println("NextMethod: class:40 method:21")
					method := &ExchangeDeleteOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				30 { // exchange bind
					//fmt.Println("NextMethod: class:40 method:30")
					method := &ExchangeBind{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				31 { // exchange bind-ok
					//fmt.Println("NextMethod: class:40 method:31")
					method := &ExchangeBindOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				40 { // exchange unbind
					//fmt.Println("NextMethod: class:40 method:40")
					method := &ExchangeUnbind{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				51 { // exchange unbind-ok
					//fmt.Println("NextMethod: class:40 method:51")
					method := &ExchangeUnbindOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				else {
					return error("Bad method frame, unknown method ${mf.method_id} for class ${mf.class_id}")
				}
			}
		}
		
		
		50 { // queue
			match mf.MethodId { 
				10 { // queue declare
					//fmt.Println("NextMethod: class:50 method:10")
					method := &QueueDeclare{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				11 { // queue declare-ok
					//fmt.Println("NextMethod: class:50 method:11")
					method := &QueueDeclareOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				20 { // queue bind
					//fmt.Println("NextMethod: class:50 method:20")
					method := &QueueBind{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				21 { // queue bind-ok
					//fmt.Println("NextMethod: class:50 method:21")
					method := &QueueBindOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				50 { // queue unbind
					//fmt.Println("NextMethod: class:50 method:50")
					method := &QueueUnbind{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				51 { // queue unbind-ok
					//fmt.Println("NextMethod: class:50 method:51")
					method := &QueueUnbindOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				30 { // queue purge
					//fmt.Println("NextMethod: class:50 method:30")
					method := &QueuePurge{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				31 { // queue purge-ok
					//fmt.Println("NextMethod: class:50 method:31")
					method := &QueuePurgeOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				40 { // queue delete
					//fmt.Println("NextMethod: class:50 method:40")
					method := &QueueDelete{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				41 { // queue delete-ok
					//fmt.Println("NextMethod: class:50 method:41")
					method := &QueueDeleteOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				else {
					return error("Bad method frame, unknown method ${mf.method_id} for class ${mf.class_id}")
				}
			}
		}
		
		
		60 { // basic
			match mf.MethodId { 
				10 { // basic qos
					//fmt.Println("NextMethod: class:60 method:10")
					method := &BasicQos{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				11 { // basic qos-ok
					//fmt.Println("NextMethod: class:60 method:11")
					method := &BasicQosOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				20 { // basic consume
					//fmt.Println("NextMethod: class:60 method:20")
					method := &BasicConsume{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				21 { // basic consume-ok
					//fmt.Println("NextMethod: class:60 method:21")
					method := &BasicConsumeOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				30 { // basic cancel
					//fmt.Println("NextMethod: class:60 method:30")
					method := &BasicCancel{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				31 { // basic cancel-ok
					//fmt.Println("NextMethod: class:60 method:31")
					method := &BasicCancelOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				40 { // basic publish
					//fmt.Println("NextMethod: class:60 method:40")
					method := &BasicPublish{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				50 { // basic return
					//fmt.Println("NextMethod: class:60 method:50")
					method := &BasicReturn{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				60 { // basic deliver
					//fmt.Println("NextMethod: class:60 method:60")
					method := &BasicDeliver{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				70 { // basic get
					//fmt.Println("NextMethod: class:60 method:70")
					method := &BasicGet{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				71 { // basic get-ok
					//fmt.Println("NextMethod: class:60 method:71")
					method := &BasicGetOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				72 { // basic get-empty
					//fmt.Println("NextMethod: class:60 method:72")
					method := &BasicGetEmpty{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				80 { // basic ack
					//fmt.Println("NextMethod: class:60 method:80")
					method := &BasicAck{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				90 { // basic reject
					//fmt.Println("NextMethod: class:60 method:90")
					method := &BasicReject{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				100 { // basic recover-async
					//fmt.Println("NextMethod: class:60 method:100")
					method := &BasicRecoverAsync{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				110 { // basic recover
					//fmt.Println("NextMethod: class:60 method:110")
					method := &BasicRecover{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				111 { // basic recover-ok
					//fmt.Println("NextMethod: class:60 method:111")
					method := &BasicRecoverOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				120 { // basic nack
					//fmt.Println("NextMethod: class:60 method:120")
					method := &BasicNack{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				else {
					return error("Bad method frame, unknown method ${mf.method_id} for class ${mf.class_id}")
				}
			}
		}
		
		
		90 { // tx
			match mf.MethodId { 
				10 { // tx select
					//fmt.Println("NextMethod: class:90 method:10")
					method := &TxSelect{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				11 { // tx select-ok
					//fmt.Println("NextMethod: class:90 method:11")
					method := &TxSelectOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				20 { // tx commit
					//fmt.Println("NextMethod: class:90 method:20")
					method := &TxCommit{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				21 { // tx commit-ok
					//fmt.Println("NextMethod: class:90 method:21")
					method := &TxCommitOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				30 { // tx rollback
					//fmt.Println("NextMethod: class:90 method:30")
					method := &TxRollback{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				31 { // tx rollback-ok
					//fmt.Println("NextMethod: class:90 method:31")
					method := &TxRollbackOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				else {
					return error("Bad method frame, unknown method ${mf.method_id} for class ${mf.class_id}")
				}
			}
		}
		
		
		85 { // confirm
			match mf.MethodId { 
				10 { // confirm select
					//fmt.Println("NextMethod: class:85 method:10")
					method := &ConfirmSelect{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				11 { // confirm select-ok
					//fmt.Println("NextMethod: class:85 method:11")
					method := &ConfirmSelectOk{}
					if err = method.read(r.r); err != nil {
						return
					}
					mf.Method = method
				}
				
				else {
					return error("Bad method frame, unknown method ${mf.method_id} for class ${mf.class_id}")
				}
			}
		}
		
		else {
		  return nil, fmt.Errorf("Bad method frame, unknown class ${mf.class_id}")
		}
	}
	return mf, nil
}


  
  
  
  
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  

  