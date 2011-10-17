# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/log_parslet/parsers/(.+)\.rb$})     { |m| "spec/log_parslet/parsers/#{m[1]}_spec.rb" }
  watch(%r{^lib/log_parslet/rule_sets/base\.rb$})     { |m| "spec/log_parslet/parsers/base_spec.rb" }

  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('spec/spec_helper.rb')                        { "spec" }
end



