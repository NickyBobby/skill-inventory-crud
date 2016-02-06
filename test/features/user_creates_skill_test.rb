require_relative '../test_helper'

class UserCreatesSkillTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_with_valid_attributes
    # As a user
    # When I visit the home page
    # And I click "new task"
    # And I fill in the title
    # And I fill in the description
    # And I click submit
    # Then I should see my task

    visit '/'
    click_link("New Skill")
    fill_in("skill[name]", with: "pizza")
    fill_in("skill[status]", with: "is juicy")
    click_button("submit")

    assert_equal "/skills", current_path

    within("#skills") do
      assert page.has_content?("pizza")
    end
    save_and_open_page
  end
end
