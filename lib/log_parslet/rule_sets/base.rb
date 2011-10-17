module LogParslet

  module RuleSet

    module Base
      include Parslet

      rule(:space) { match('\s').repeat(1) }
      rule(:space?) { match('\s').maybe }

      rule(:lbracket) { str('[') }
      rule(:rbracket) { str(']') }
      rule(:dquote) { str('"') }
      rule(:slash) { str('/') }
      rule(:colon) { str(':') }
      rule(:plus) { str('+') }
      rule(:minus) { str('-') }
      rule(:dot) { str('.') }

      rule(:date) { match('\d').repeat(1,2) }
      rule(:month) { match('[A-Za-z]').repeat(3,3) }
      rule(:year) { match('\d').repeat(4,4) }
      rule(:hours) { match('\d').repeat(2,2) }
      rule(:minutes) { match('\d').repeat(2,2) }
      rule(:seconds) { match('\d').repeat(2,2) }
      rule(:timezone) { (plus | minus) >> match('\d').repeat(4,4) }

      rule(:http_method) { match('[A-Z]').repeat(3,6) }
      rule(:http_resource) { match('[^ ]').repeat(1) }
      rule(:http_protocol) { str('HTTP') >> str('S').maybe >> slash >> match('\d') >> dot >> match('\d') }
    end

  end

end
