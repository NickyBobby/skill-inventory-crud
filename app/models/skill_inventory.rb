class SkillInventory
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(skill)
    database.transaction do
      database['skills'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['skills'] << { "id" => database['total'], "name" => skill[:name], "status" => skill[:status] }
    end
  end

  def raw_skills
    database.transaction do
      database['skills'] || []
    end
  end

  def all
    raw_skills.map { |data| Skill.new(data) }
  end

  def raw_skill(id)
    raw_skills.find { |skill| skill["id"] == id }
  end

  def find(id)
    Skill.new(raw_skill(id))
  end

  def update(skill, id)
    database.transaction do
      target_skill = database["skills"].find { |skill| skill["id"] == id }
      target_skill["name"] = skill['name']
      target_skill["status"] = skill['status']
    end
  end

  def delete(id)
    database.transaction do
      database["skills"].delete_if { |skill| skill["id"] == id }
    end
  end

  def delete_all
    database.transaction do
      database['skills'] = []
      database['total'] = 0
    end
  end

  # def self.database
  #   @database ||= YAML::Store.new("db/skill_inventory")
  # end


end
