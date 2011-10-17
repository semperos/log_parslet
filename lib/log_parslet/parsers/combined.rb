module LogParslet

  module Parsers

    class Combined < Parslet::Parser
      include LogParslet::RuleSet::Combined

      root :combined_entry
    end

  end

end
