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
    results = DB.execute("SELECT * FROM tasks")
    if results.empty?
      []
    else
      # recreate all tasks
      results.map do |result|
        Task.new(
          id: result['id'],
          title: result['title'],
          description: result['description'],
          done: result['done'] == 1
        )
      end
    end
    # return an ARRAY OF TASK INSTANCES

  end

  def self.find(id)
    # 1. retrieve the right info from the table
    result = DB.execute("SELECT * FROM tasks WHERE id = ?", id).first
    p result
    # 2. instantiate the Task
    if result.nil?
      nil
    else
      # binding.pry
      task = Task.new(
        id: result['id'],
        title: result['title'],
        description: result['description'],
        done: result['done'] == 0 ? false : true
      )
      # 3. return the task
    end
  end

  def destroy
    # find the right task
    # 2. delete it from the database
    DB.execute("DELETE FROM tasks WHERE id = ?", @id)
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
        "UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?",
        @title, @description, @done ? 1 : 0, @id
      )
    end
  end
end