require_relative '../test_helper'

class UserCreatesTaskTest < Minitest::Test
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
    click_link("New Task")
    fill_in("task[title]", with: "pizza")
    fill_in("task[description]", with: "is juicy")
    click_button("submit")

    assert_equal "/tasks", current_path

    within("#tasks") do
      assert page.has_content?("pizza")
    end
    save_and_open_page
  end
end
