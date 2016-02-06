require_relative '../test_helper'

class SkillTest < Minitest::Test
  def test_skill_attributes_assigned_correctly
    data = {
      "id"         => 1,
      "name"       => "hot breath",
      "status"     => "It's FIREEE"
    }

    skill = Skill.new(data)

    assert_equal 1, skill.id
    assert_equal "hot breath", skill.name
    assert_equal "It's FIREEE", skill.status
  end
end
