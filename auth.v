module vamqp

interface Authentication {
	mechanism() string
	response() string
}

struct PlainAuth {
	username string
	password string
}

fn (a PlainAuth) mechanism() string {
	return "PLAIN"
}

fn (a PlainAuth) response() string {
	//return a.username + "\x00" + a.username + "\x00" + a.password
	return "\000${a.username}\000${a.password}"
}

struct AMQPlainAuth {
	username string
	password string
}

fn (a AMQPlainAuth) mechanism() string {
	return "AMQPLAIN"
}

fn (a AMQPlainAuth) response() string {
	return "LOGIN:${a.username};PASSWORD:${a.password}"
}

struct NoneAuth {}

fn (a NoneAuth) mechanism() string {
	return "NONE"
}

fn (a NoneAuth) response() string {
	return ""
}

const (
	none_auth = NoneAuth{}
)

pub fn pick_sasl_mechanism(client []Authentication, server_mechanisms []string) Authentication {
	for auth in client {
		for mechanism in server_mechanisms {
			if auth.mechanism() == mechanism {
				return auth
			}
		}
	}
	return none_auth
}