# inpay gem

## What is it?
A Ruby gem wrapping the inpay.com merchant API.

## Who should use it?
Any Ruby on Rails developer who wants/needs to work with inpay.

## Usage

### Installation

    gem install inpay

### Configuration

By default the environment is set to test. Add the following line to the environments/production.rb:

    Inpay::Config.mode = :production

You will also need to define the IP (or IPs) you will accept postbacks form. Add a private method in your application controller, something like this:
    
    private
    
    def set_inpay_ips
      Inpay::Config.server_ips = 'xxx.xxx.xxx.xxx'
    end

You can also use an array:
    
    private
    
    def set_inpay_ips
      Inpay::Config.server_ips = ['xxx.xxx.xxx.xxx', 'xxx.xxx.xxx.xxx', 'xxx.xxx.xxx.xxx']
    end

In the controller that will process the postback add a before filter:

    before_filter :set_inpay_ips

### The form in your view

Create a form tag and use the inpay_setup method to generate the necessary hidden fields:
    
    <%= form_tag inpay_flow_url do %>
      <%= raw inpay_setup(amount, options) %>
    <% end %>

The amount can be either a float or a Money object. Options should be passed as a hash with symbolized keys.

These are all required options:

- :order_id 
- :merchant_id        _(your merchant id at inpay)_
- :currency           _(defaults to :EUR)_
- :order_text         _(a brief description)_
- :buyer_email
- :secret_key         _(your sectret key from inpay)_
- :flow_layout        _(defaults to :multi_page)_

These are nonmandatory:

- :return_url         _(defaults to the return url set in the inpay admin)_
- :pending_url        _(defaults to the return url set in the inpay admin)_
- :cancel_url         _(defaults to the return url set in the inpay admin)_
- :notify_url         _(defaults to the postback url set in the inpay admin)_
- :country
- :invoice_comment    _(will be attached to the created invoice)_
- :buyer_name
- :buyer_address      _(street, zip code, city, state, country)_
- :buyer_information  _(free text field where you can put information that could be relevant to the customer)_
- :extra_your_param   _(those parameters will be added to the return url without the "extra_" prefix)_

### Handling a postback in your controller

An Inpay postback controller might look something like this:

    class InpaysController < ApplicationController
      skip_before_filter :verify_authenticity_token
    
      def postback
        begin
          @postback = Inpay::Postback.new(request, _your_inpay_secret_key_ )
          
          if @postback.genuine?
            if @postback.approved?
              ... yay ...
            else
              ... meh ...
            end
          end
        rescue Exception => e
          ... handle the error ...
        end
        
        render :nothing => true
      end
    end

Important: make sure no errors are thrown when something goes wrong. Logically Inpay will see this as a failure and keep on sending postbacks. Hence the begin/rescue block.

The Inpay::Postback instance has a lot of methods for the result of the transactions:

- genuine? _(verifies the checksum and IP of the server that performed the postback)_
- pending?
- sum_too_low?
- approved?
- cancelled?
- refunded?
- refund_pending?
- error? _(when something went wrong with connection)_

The inpay server will post back the following params:

- :invoice_currency
- :invoice_reference
- :checksum
- :order_id
- :invoice_amount
- :invoice_created_at _(e.g. 2011-02-19 10:41:55)_
- :invoice_status

You might need some of those params to fetch the invoice, status and so on.

## Important

This gem is written for Rails 3. Rails 2 might work but it's not tested.

## Contributing to inpay
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Wout Fierens. See LICENSE.txt for
further details.

