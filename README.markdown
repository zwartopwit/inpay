# inpay gem

## What is it?
A Ruby gem wrapping the inpay.com API for online bank payments.

## Who should use it?
Any Ruby on Rails developer who wants/needs to work with inpay.

## Usage

### Installation

    gem install inpay

### Configuration

By default the environment is set to test. Add the following line to the environments/production.rb:

    Inpay::Config.mode = :production

You will also need to define the IP (or IP's) you will accept postbacks form. Add a private method in your application controller, something like this:

    def set_inpay_ips
      Inpay::Config.server_ips = 'xxx.xxx.xxx.xxx'
    end

You can also use an array:

    def set_inpay_ips
      Inpay::Config.server_ips = ['xxx.xxx.xxx.xxx', 'xxx.xxx.xxx.xxx', 'xxx.xxx.xxx.xxx']
    end

In the controller that will process the postback add a before filter:

    before_filter :set_inpay_ips

### In your view

Create a form tag and use the inpay_setup method to generate the necessary hidden fields:
    
    <%= form_tag inpay_flow_url do %>
      <%= raw inpay_setup(amount, options) %>
    <% end %>

The amount can be either a float or a Money object. Options should be passed as a hash with symbolized keys.

These are all required options:

- :order_id 
- :merchant_id      __(your merchant id at inpay)__
- :currency         __(defaults to :EUR)__
- :order_text       __(a brief description)__
- :buyer_email
- :secret_key       __(your sectret key from inpay)__
- :flow_layout      __(defaults to :multi_page)__

These are nonmandatory:

- :return_url       __(defaults to the return url set in the inpay admin)__
- :pending_url      __(defaults to the return url set in the inpay admin)__
- :cancel_url       __(defaults to the return url set in the inpay admin)__
- :country
- :invoice_comment
- :buyer_name
- :buyer_address


## Contributing to inpay
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 wout fierens. See LICENSE.txt for
further details.

