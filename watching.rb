require 'watchr'

RSPEC_ROOT = 'spec/log_parslet'
watch('(spec/**/.*\.rb)') {|t| system "rspec #{RSPEC_ROOT}"}
watch('lib/**/.*?\.rb') {|t| system "rspec #{RSPEC_ROOT}"}
