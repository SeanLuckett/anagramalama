require 'factory_girl_rails'

# allows shorter factory creation syntax
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
