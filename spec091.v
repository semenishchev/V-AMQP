module vamqp

const (
	frame_method		= 1
	frame_header		= 2
	frame_body			= 3
	frame_heartbeat		= 8
	frame_min_size		= 4096
	frame_end			= 206
	reply_success		= 200
	content_too_large	= 311
	no_route			= 312
	no_consumers		= 313
	connection_forced	= 320
	invalid_path		= 402
	access_refused		= 403
	not_found			= 404
	resource_locked		= 405
	precondition_failed	= 406
	frame_error			= 501
	syntax_error		= 502
	command_invalid		= 503
	channel_error		= 504
	unexpected_frame	= 505
	resource_error		= 506
	not_allowed			= 530
	not_implemented		= 540
	internal_error		= 541
)