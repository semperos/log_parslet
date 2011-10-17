module LogParslet

  class Parser
    def self.new_parser(parser_name)
      parser_name = "LogParslet::RuleSet::#{parser_name.to_s.capitalize}"

      # Borrowed from ActiveSupport#constantize
      names = parser_name.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  end

end
