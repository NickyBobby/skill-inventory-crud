require_relative '../test_helper'
require 'pry'

class SkillInventoryTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_skill
    data = {
      name:   "a skill",
      status: "a status"
    }
    skill_inventory.create(data)

    skill = skill_inventory.all.last

    assert skill.id
    assert_equal "a skill", skill.name
    assert_equal "a status", skill.status
  end

  def test_it_returns_all_skills_in_the_database
    create_skills(3)

    assert_equal 3, skill_inventory.all.count
    assert_equal Skill, skill_inventory.all.last.class
    assert skill_inventory.all.last.id
    assert_equal "a skill 3", skill_inventory.all.last.name
    assert_equal "a status 3", skill_inventory.all.last.status
  end


  def test_it_can_find_a_specific_skill_by_id
    create_skills(3)
    id = skill_inventory.all.last.id

    skill = skill_inventory.find(id)
    assert_equal Skill, skill.class
    assert_equal "a skill 3", skill.name
    assert_equal "a status 3", skill.status
    assert_equal id, skill.id
  end

  def test_it_can_update_an_existing_task
    data = {
      name:       "a skill",
      status:     "a status"
      }
    new_task = {
      name:       "new skill",
      status:     "new status"
      }
    skill_inventory.create(data)
    skill_inventory.create(data)
    skill_inventory.create(data)
    id = skill_inventory.all.last.id
    skill_inventory.update(new_task, id)

    assert_equal "new skill", skill_inventory.find(id).name
    assert_equal "new status", skill_inventory.find(id).status
  end

  def test_it_can_delete_a_skill_from_zee_database
    create_skills(3)
    initial_count = skill_inventory.all.count
    assert_equal 3, skill_inventory.all.count
    id = skill_inventory.all.last.id

    skill_inventory.delete(id)

    final_count = skill_inventory.all.count
    assert_equal 1, (initial_count - final_count)
  end


end
