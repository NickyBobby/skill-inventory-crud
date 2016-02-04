require_relative '../test_helper'

class UserUpdatesTaskTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_with_valid_attributes
    create_tasks(2)
    # As a user
    # When I visit the edit page
    # And I enter in the new title
    # And I enter in the new description
    # And I hit submit
    # Then I see the tasks page with my newly updated task

    visit('/tasks/1/edit')
    fill_in('task[title]', with: 'new title')
    fill_in('task[description]', with: 'new description')
    click_button('submit')

    assert_equal "/tasks/1", current_path

  end
end
