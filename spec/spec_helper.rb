RSpec.configure do |c|
  c.mock_with :rspec
end

require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.formatter = :documentation
  c.tty       = true
end
