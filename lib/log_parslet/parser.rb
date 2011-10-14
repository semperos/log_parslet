module LogParslet

  module Common
    include Parslet
    include LogParslet::IPv4
  end

  class Parser < Parslet::Parser
    include LogParslet::Common

    def parse(str)
      ipv4.parse(str)
    end
  end

end
