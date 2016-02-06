require_relative '../test_helper'

class UserUpdatesSkillTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_with_valid_attributes
    create_skills(2)
    # As a user
    # When I visit the edit page
    # And I enter in the new title
    # And I enter in the new description
    # And I hit submit
    # Then I see the tasks page with my newly updated task
    id = skill_inventory.all.last.id
    
    visit("/skills/#{id}/edit")
    fill_in('skill[name]', with: 'new skill')
    fill_in('skill[status]', with: 'new status')
    click_button('submit')

    assert_equal "/skills/#{id}", current_path

  end
end
