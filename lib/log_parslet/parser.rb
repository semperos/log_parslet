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
    rule(:host) { (ipv4.as(:host) | nil_field.as(:host)) >> space }
    rule(:ident) { nil_field.as(:ident) >> space }
    rule(:authuser) { (match('[^ ]').repeat(1).as(:authuser) | nil_field.as(:authuser)) >> space }
    rule(:datetime) { ((lbracket >> date.as(:date) >> slash >>
                                   month.as(:month) >> slash >>
                                   year.as(:year) >> colon >>
                                   hours.as(:hours) >> colon >>
                                   minutes.as(:minutes) >> colon >>
                                   seconds.as(:seconds) >> space >>
                                   timezone.as(:timezone) >> rbracket).as(:datetime) | nil_field.as(:datetime)) >> space }
    rule(:request) { (dquote >> (http_method.as(:http_method) >> space >>
                                 http_resource.as(:http_resource)  >> space >>
                                 http_protocol.as(:http_protocol)).as(:request) >> dquote | nil_field.as(:request)) >> space }
    rule(:status) { (match('\d').repeat(3).as(:status) | nil_field.as(:status)) >> space }
    rule(:bytes) { (match('\d').repeat(1).as(:bytes) | nil_field.as(:bytes)) >> space?}
    rule(:entry) { host >> ident >> authuser >> datetime >> request >> status >> bytes }

  end

  class Parser < Parslet::Parser
    include LogParslet::Common

    root :entry
  end

end
