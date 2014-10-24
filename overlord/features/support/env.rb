require "capybara/cucumber"
require "rspec/expectations"

require_relative "../../overlord_app"

Capybara.default_driver = :selenium
Capybara.app = Overlord
