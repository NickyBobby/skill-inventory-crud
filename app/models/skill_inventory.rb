require 'pry'

class SkillInventory
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(skill)
    database.from(:skills).insert(skill)
  end

  def raw_skills
    database.transaction do
      database['skills'] || []
    end
  end

  def all
    database.from(:skills).to_a.map { |data| Skill.new(data) }
  end

  def raw_skill(id)
    raw_skills.find { |skill| skill["id"] == id }
  end

  def dataset
    database.from(:skills)
  end

  def find(id)
    data = dataset.where(:id => id).to_a.first
    Skill.new(data)
  end


  def update(skill, id)
    dataset.where(:id => id).update(skill)
  end

  def delete(id)
    dataset.where(:id => id).delete
  end

  def delete_all
    database.transaction do
      database['skills'] = []
      database['total'] = 0
    end
  end

end
