require_relative '../test_helper'
require 'pry'

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_task
    data = {
      title:       "a title",
      description: "a description"
      }
    task_manager.create(data)

    task = task_manager.all.last

    assert task.id
    assert_equal "a title", task.title
    assert_equal "a description", task.description
  end

  def test_it_returns_all_items_in_the_database
    data = {
      title:       "a title",
      description: "a description"
      }
    task_manager.create(data)
    task_manager.create(data)
    task_manager.create(data)

    assert_equal 3, task_manager.all.count
    assert_equal Task, task_manager.all.last.class
    assert task_manager.all.last.id
    assert_equal "a title", task_manager.all.last.title
    assert_equal "a description", task_manager.all.last.description
  end

  def create_tasks(num)
    num.times do |i|
      task_manager.create({
        title:       "a title #{i+1}",
        description: "a description #{i+1}"
        })
    end
  end

  def test_it_can_find_a_specific_task_by_id
    create_tasks(3)
    task = task_manager.find(2)
    assert_equal Task, task.class
    assert_equal "a title 2", task.title
    assert_equal "a description 2", task.description
    assert_equal 2, task.id
  end

  def test_it_can_update_an_existing_task
    data = {
      title:       "a title",
      description: "a description"
      }
    new_task = {
      'title'       => "new title",
      'description' => "new description"
      }
    task_manager.create(data)
    task_manager.create(data)
    task_manager.create(data)
    task_manager.update(new_task, 1)

    assert_equal "new title", task_manager.find(1).title
    assert_equal "new description", task_manager.find(1).description
  end

  def test_it_can_delete_an_item_from_zee_database
    data = {
      title:       "a title",
      description: "a description"
      }
      task_manager.create(data)
      task_manager.create(data)
      task_manager.create(data)
      assert_equal 3, task_manager.all.count

      task_manager.delete(1)

      assert_equal 2, task_manager.all.count
  end

  
end
