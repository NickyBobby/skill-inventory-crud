require 'sequel'

environments = ["development", "test" ]
environments.each do |env|
  Sequel.sqlite("db/skill_inventory_#{env}.sqlite3").create_table(:skills) do
    primary_key :id
    String :name
    String :status
  end
end



# Sequel.migration do
#   up do
#     create_table(:tasks) do
#       primary_key :id
#       String :title, :null => false
#     end
#   end
#
#   down do
#     drop_table(:tasks)
#   end
# end

# DB.create_table :tasks do
#   primary_key :id
#   column :title, :text
#   String :content
#   index :title
# end
