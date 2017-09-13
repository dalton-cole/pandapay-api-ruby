# PandaPay API Ruby Library [![Gem Version](https://badge.fury.io/rb/pandapay_api.svg)](https://badge.fury.io/rb/pandapay_api) [![Build Status](https://travis-ci.org/dalton-cole/pandapay-api-ruby.svg?branch=master)](https://travis-ci.org/dalton-cole/pandapay-api-ruby) [![Code Climate](https://codeclimate.com/github/dalton-cole/pandapay-api-ruby/badges/gpa.svg)](https://codeclimate.com/github/dalton-cole/pandapay-api-ruby)

The [PandaPay](https://www.pandapay.io/) API Ruby gem provides convenient access to the [PandaPay API](http://docs.pandapay.io/getting-started-pandapay-api/api-reference) for applications written in the Ruby language. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pandapay_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pandapay_api

### Requirements

* Ruby 2.1+.

## Usage

The library needs to be configured with your account's secret key which is
available in your [PandaPay Dashboard](https://dashboard.pandapay.io/dashboard). Set `PandaPay.api_key` to its
value:

``` ruby
require "pandapay_api"
PandaPay.api_key = "sk_test_..."

# Create a customer
PandaPay::Customer.create(
email: "test@pandapay.io", 
source: "V45VnfsKzGJR9LIT9fgt4Kna6gz"
)

```

### Panda.js Tokens
In order to create customer objects or donation objects without a `customer_id`, you will need a payment `source` token from panda.js. To get more information about this, please refer to the API section of your dashboard. 


### Donations
Creating a donation is simple with the Pandapay_API gem. All you need is the payment `source`, the `amount`, and the `receipt_email`. You can also add a `platform_fee`, `destination`, and `restriction`. 

``` ruby
# Create a donation
PandaPay::Donation.create(
source: "7uKpZcziQ5mrAQ5BVSMhm2ZPX7o", 
amount: "5000", 
receipt_email: "test@pandapay.io"
) 

#Example response:
#<PandaPay::Donation:0x007fbedb04ee70 @id="ch_AZ4xFphfWsjhS0GW93ofmg", @object="donation", @created=1505171888, @livemode=false, @charge_amount=5000, @platform_fee=0, @donation_after_fees=4775, @currency="usd", @payment_token="7uKpZcziQ5mrAQ5BVSMhm2ZPX7o", @customer=nil, @grants=[], @receipt_email="test@pandapay.io", @destination="", @restriction=nil>



# Create a donation with a destination to automatically generate a grant
PandaPay::Donation.create(
source: "K2vUvDrRTTc37y0q26bppoEQ2Iy", 
amount: "5000",
receipt_email: "test@pandapay.io",
destination: "95-4604782" 
) 

#Example response
#<PandaPay::Donation:0x007fbeda0be550 @id="ch_LTBoq-Ln2T9BFXTCmcwtjA", @object="donation", @created=1505172101, @livemode=false, @charge_amount=5000, @platform_fee=0, @donation_after_fees=4775, @currency="usd", @payment_token="K2vUvDrRTTc37y0q26bppoEQ2Iy", @customer=nil, @grants=["gr_ZMPNOx_7fMMZFQJuQs01qQ"], @receipt_email="test@pandapay.io", @destination="95-4604782", @restriction=nil>
```

### Grants
If you have a balance in your 'Unallocated Donation Amount' on your [PandaPay Dashboard](https://dashboard.pandapay.io/dashboard), you can create a grant. All you need to provide is an `amount` (less than the aformentioned balance) and a `destination`.

``` ruby
PandaPay::Grant.create(
destination: "95-4604782", 
amount: "10000"
)

#Example Response
#<PandaPay::Grant:0x007fbeda85fde0 @id="gr_RmL6PhFwlyWugBTdSmy5vw", @object="grant", @created=1505172414, @livemode=false, @amount=10000, @status="pending", @currency="usd", @type="npo", @destination="95-4604782", @restriction=nil>

```

### Customers
The PandaPay_API Ruby gem permits customer creation, updates, and deletion using the following methods. To create a user, you must provide an `email` and a panda.js payment `source` token. To update a user, you need to provide a PandaPay `customer_id` and the value you want to update (`email` and/or `source`). To delete a user, you just need the `customer_id`.

``` ruby
# Create a customer
PandaPay::Customer.create(
email: "test@pandapay.io", 
source: "V45VnfsKzGJR9LIT9fgt4Kna6gz"
)

#Example response:
#<PandaPay::Customer:0x007fb5cc87d1e0 @id="cus_XZh_d56chDzNqFZyqT7YcA", @object="customer", @email="test@pandapay.io", @livemode=false, @cards=[{"id"=>"card_V45VnfsKzGJR9LIT9fgt4Kna6gz", "object"=>"card", "created"=>1505170021, "livemode"=>false, "customer"=>"cus_XZh_d56chDzNqFZyqT7YcA", "last4"=>"1111"}]>



# Update a customer 
PandaPay::Customer.update(
customer_id: "cus_IOHfSE0z4KxVbF53DzSxhA",
source: "SPfZl6YXK1zsc3gDZrOCc8Y3NRp",
email: "newemail@pandapay.io" 
)

#Example response:
#<PandaPay::Customer:0x007fb5cb82fc70 @id="cus_IOHfSE0z4KxVbF53DzSxhA", @object="customer", @email="newemail@pandapay.io", @livemode=false, @cards=[{"id"=>"card_88SB6AJIjVCCPCMtiyd3ykuDQ8F", "object"=>"card", "created"=>1505168696, "livemode"=>false, "customer"=>"cus_IOHfSE0z4KxVbF53DzSxhA", "last4"=>"1111"}, {"id"=>"card_SPfZl6YXK1zsc3gDZrOCc8Y3NRp", "object"=>"card", "created"=>1505170178, "livemode"=>false, "customer"=>"cus_IOHfSE0z4KxVbF53DzSxhA", "last4"=>"1111"}]>



# Delete a customer
PandaPay::Customer.delete(
customer_id: "cus_IOHfSE0z4KxVbF53DzSxhA"
)

#Example response
#<PandaPay::Customer:0x007fb5cca14a08 @id="cus_IOHfSE0z4KxVbF53DzSxhA", @object="customer", @email="newemail@pandapay.io", @livemode=false, @cards=[{"id"=>"card_88SB6AJIjVCCPCMtiyd3ykuDQ8F", "object"=>"card", "created"=>1505168696, "livemode"=>false, "customer"=>"cus_IOHfSE0z4KxVbF53DzSxhA", "last4"=>"1111"}, {"id"=>"card_SPfZl6YXK1zsc3gDZrOCc8Y3NRp", "object"=>"card", "created"=>1505170178, "livemode"=>false, "customer"=>"cus_IOHfSE0z4KxVbF53DzSxhA", "last4"=>"1111"}]>
```



## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dalton-cole/pandapay.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
