# DSN

Ruby parser for [RFC 3463](https://tools.ietf.org/html/rfc3463) Delivery Status Notification codes.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'dsn'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dsn

## Usage

```ruby
dsn = DSN.new('5.7.5')
dsn.valid?
# => true
dsn.success?
# => false
dsn.transient_failure?
# => false
dsn.failed?
# => true
dsn.to_s
# => "5.7.5"
dsn.subcode.to_s
# => "X.7.5"

dsn = DSN.new('5.7.999')
dsn.valid?
# => false
dsn.class_subcode.valid?
# => true
dsn.subject_subcode.valid?
# => true
dsn.detail_subcode.valid?
# => false
dsn.to_s
# => "5.7.999"
dsn.subcode.to_s
# => "X.7.XXX"

msg = DSN::Message.new(dsn.subcode)
msg.summary
# => "Security or Policy Status"
msg.body
# => "The security or policy status codes report failures involving policies such as per-recipient or per-host filtering and cryptographic operations.  Security and policy status issues are assumed to be under the control of either or both the sender and recipient.  Both the sender and recipient must permit the exchange of messages and arrange the exchange of necessary keys and certificates for cryptographic operations."

DSN.message('5.7.5').summary
# => "Cryptographic failure"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/garethrees/dsn.
