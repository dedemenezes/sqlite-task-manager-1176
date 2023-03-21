# frozen_string_literal: true

require 'pry-byebug'

class Task
  attr_reader :id, :title, :description
  attr_accessor :done

  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end

  def self.all
    # retrieve the information about all tasks
    results = DB.execute('SELECT * FROM tasks')
    if results.empty?
      []
    else
      # recreate all tasks
      # return an ARRAY OF TASK INSTANCES
      results.map do |result|
        build_task(result)
      end
    end
  end

  def self.find(id)
    # 1. retrieve the right info from the table
    result = DB.execute('SELECT * FROM tasks WHERE id = ?', id).first
    p result
    # 2. instantiate the Task
    if result.nil?
      nil
    else
      # binding.pry
      build_task(result)
      # 3. return the task
    end
  end

  def destroy
    # find the right task
    # 2. delete it from the database
    DB.execute('DELETE FROM tasks WHERE id = ?', @id)
  end

  def save
    # binding.pry
    if @id.nil?
      # CREATE
      DB.execute('INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)', @title, @description, @done ? 1 : 0)
      @id = DB.last_insert_row_id
    else
      # UPDATE
      DB.execute(
        'UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?',
        @title, @description, @done ? 1 : 0, @id
      )
    end
  end

  def self.build_task(row)
    Task.new(
      id: row['id'],
      title: row['title'],
      description: row['description'],
      done: row['done'] == 1
    )
  end
end
