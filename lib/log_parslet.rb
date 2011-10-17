require 'rubygems'
require_relative "log_parslet/version"

require 'parslet'
require 'parslet/convenience'
require 'pp'

require_relative 'log_parslet/rule_sets/base'
require_relative 'log_parslet/rule_sets/ipv4'
require_relative 'log_parslet/rule_sets/common'
require_relative 'log_parslet/rule_sets/combined'

require_relative 'log_parslet/parsers/common'
require_relative 'log_parslet/parsers/combined'

require_relative 'log_parslet/parser'
# require_relative 'log_parslet/transform'

module LogParslet

  def self.parse(s)
    parser = LogParslet.new_parser(:combined)
#    transform = LogParslet::Transform.new

    out = parser.parse(s)
#    out = transform.apply(tree)

    out
  rescue Parslet::ParseFailed => e
    puts e, parser.root.error_tree
  end

end

# Ruby version compatibility for require/require_relative
unless Kernel.respond_to?(:require)
  module Kernel
    def require(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end
