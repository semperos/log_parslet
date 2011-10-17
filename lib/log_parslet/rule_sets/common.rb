module LogParslet

  module RuleSet

    module Common
      include Parslet
      include LogParslet::RuleSet::Base
      include LogParslet::RuleSet::IPv4

      # host ident authuser date request status bytes
      rule(:nil_field) { str('-') }
      rule(:host) { (ipv4 | nil_field).as(:host) >> space }
      rule(:ident) { nil_field.as(:ident) >> space }
      rule(:authuser) { (match('[^ ]').repeat(1) | nil_field).as(:authuser) >> space }
      rule(:datetime) { ((lbracket >> date.as(:date) >> slash >>
                                      month.as(:month) >> slash >>
                                      year.as(:year) >> colon >>
                                      hours.as(:hours) >> colon >>
                                      minutes.as(:minutes) >> colon >>
                                      seconds.as(:seconds) >> space >>
                                      timezone.as(:timezone) >> rbracket) | nil_field).as(:datetime) >> space }
      rule(:request) { (dquote >> (http_method.as(:http_method) >> space >>
                                   http_resource.as(:http_resource)  >> space >>
                                   http_protocol.as(:http_protocol)) >> dquote | nil_field).as(:request) >> space }
      rule(:status) { (match('\d').repeat(3) | nil_field).as(:status) >> space }
      rule(:bytes) { (match('\d').repeat(1) | nil_field).as(:bytes) >> space?}
      rule(:common_entry) { host >> ident >> authuser >> datetime >> request >> status >> bytes }

    end

  end

end
