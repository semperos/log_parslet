module LogParslet

  module Parsers

    class Common < Parslet::Parser
      include LogParslet::RuleSet::Common

      root :common_entry
    end

  end

end
