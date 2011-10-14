module LogParslet

  module Base
    include Parslet

    rule(:space)    { match('\s').repeat(1) }
    rule(:space?)    { match('\s').maybe }

    rule(:lbracket) { str('[') }
    rule(:rbracket) { str(']') }
    rule(:dquote) { str('"') }
    rule(:slash) { str('/') }
    rule(:colon) { str(':') }
    rule(:plus) { str('+') }
    rule(:minus) { str('-') }
    rule(:dot) { str('.') }

    rule(:date) { match('\d').repeat(1,2) }
    rule(:month) { match('[A-Za-z]').repeat(3) }
    rule(:year) { match('\d').repeat(4) }
    rule(:hours) { match('\d').repeat(2) }
    rule(:minutes) { match('\d').repeat(2) }
    rule(:seconds) { match('\d').repeat(2) }
    rule(:timezone) { (plus | minus) >> match('\d').repeat(4) }

    rule(:http_method) { match('[A-Z]').repeat(3,6) }
    rule(:http_resource) { match('[^ ]').repeat(1) }
    rule(:http_protocol) { str('HTTP') >> str('S').maybe >> slash >> match('\d') >> dot >> match('\d') }
  end

  # 127.0.0.1 - frank [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326 "http://www.example.com/start.html" "Mozilla/4.08 [en] (Win98; I ;Nav)"
  module Common
    include Parslet
    include LogParslet::Base
    include LogParslet::IPv4

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

  module Combined
    include Parslet
    include LogParslet::Base
    include LogParslet::Common

    rule(:referer) { (dquote >> match('[^"]').repeat >> dquote | nil_field).as(:referer) >> space }
    rule(:user_agent) { (dquote >> match('[^"]').repeat >> dquote | nil_field).as(:user_agent) >> space? }
    rule(:combined_entry) { common_entry >> referer >> user_agent }
  end

  class Parser < Parslet::Parser
    include LogParslet::Common
    include LogParslet::Combined

    root :combined_entry
  end

end
