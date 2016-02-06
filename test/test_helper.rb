ENV["RACK_ENV"] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'tilt/erb'

Capybara.app = SkillInventoryApp

Capybara.save_and_open_page_path = "tmp/capybara"

DatabaseCleaner[:sequel, {:connection => Sequel.sqlite("db/skill_inventory_test.sqlite3")}].strategy = :truncation

module TestHelpers

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def create_skills(num)
    num.times do |i|
      skill_inventory.database.from(:skills).insert(
        name:       "a skill #{i+1}",
        status: "a status #{i+1}"
        )
    end
  end

  def skill_inventory
    database = Sequel.sqlite('db/skill_inventory_test.sqlite3')
    @skill_inventory ||= SkillInventory.new(database)
  end
end

Capybara.app = SkillInventoryApp
Capybara.save_and_open_page_path = 'tmp/capybara'

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
