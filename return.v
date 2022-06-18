module vamqp

import time

struct Return {
	reply_code u16
	reply_text string
	exchange string
	routing_key string

	content_type string
	content_encoding string
	headers Table
	delivery_mode u8
	priority u8
	correlation_id string
	reply_to string
	expiration string
	message_id string
	timestamp time.Time
	type_ string
	user_id string
	app_id string

	body []u8
}

// TODO: implement
pub fn new_return(msg string) &Return {
	return &Return{}
}