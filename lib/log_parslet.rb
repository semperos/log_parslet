$:.push File.expand_path(__FILE__)

require "log_parslet/version"

require 'parslet'
require 'parslet/convenience'

require 'log_parslet/parser'
require 'log_parslet/transform'


module LogParslet

  def self.parse(s)
    parser = LogParslet::Parser.new
    transform = LogParslet::Transform.new

    tree = parser.parse(s)
    out = transform.apply(tree)

    out
  rescue Parslet::ParseFailed => e
    puts e, parser.root.error_tree
  end

end
