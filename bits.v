module vamqp

pub fn set_bit(z i64, x i64, i int, b u8) i64 {
	if b == 0 {
		return z &~ (1 << i)
	}
	if b == 1 {
		return z | (1 << i)
	}
	panic("set_bit: invalid value for b")
}

// Bit returns the value of the i'th bit of x. That is, it
// returns (x>>i)&1. The bit index i must be >= 0.
pub fn bit(z i64, i int) i64 {
	return (z >> i) & 1
}

pub fn has_bit(z i64, i int) bool {
	return bit(z, i) == 1
}