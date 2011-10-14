require "log_parslet/version"

require 'parslet'
require 'parslet/convenience'
require 'pp'

require 'log_parslet/parser/ipv4'

require 'log_parslet/parser'
require 'log_parslet/transform'

module LogParslet

  def self.parse(s)
    parser = LogParslet::Parser.new
#    transform = LogParslet::Transform.new

    out = parser.parse(s)
#    out = transform.apply(tree)

    pp out
  rescue Parslet::ParseFailed => e
    puts e, parser.root.error_tree
  end

end

# Ruby version compatibility

unless Kernel.respond_to?(:require)
  module Kernel
    def require(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end
