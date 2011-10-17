module LogParslet

  module RuleSet

    module IPv4
      include Parslet

      # A host identified by an IPv4 literal address is represented in
      # dotted-decimal notation (a sequence of four decimal numbers in the range 0
      # to 255, separated by "."), as described in [RFC1123] by reference to
      # [RFC0952].  Note that other forms of dotted notation may be interpreted on
      # some platforms, as described in Section 7.4, but only the dotted-decimal
      # form of four octets is allowed by this grammar.
      rule(:ipv4) {
          (dec_octet >> str('.') >> dec_octet >> str('.') >>
            dec_octet >> str('.') >> dec_octet)
      }

      rule(:dec_octet) {
          str('25') >> match("[0-5]") |
          str('2') >> match("[0-4]") >> digit |
          str('1') >> digit >> digit |
          match('[1-9]') >> digit |
          digit
      }

      rule(:digit) {
          match('[0-9]')
      }
    end

  end

end
