# frozen_string_literal: true

# Reading code
# ::method     -> :: means that this is a CLASS METHOD
# e.g. ::parse -> JSON.parse
# #method      -> # means that this is a INSTANCE METHOD
# e.g. #join  -> ['le', 'Wagon'].join(' ')

require 'sqlite3'
DB = SQLite3::Database.new('tasks.db')
DB.results_as_hash = true
require_relative 'task'

# 1. Implement the READ logic to find a given task (by its id)
# ::find
task_one = Task.find(1)
puts "#{task_one.title} - #{task_one.description}"
# #=> 'Complete Livecode	- Implement CRUD on Task'

# task = Task.find(10)
# puts "#{task.title} - #{task.description}"
#=> this sequence will raise an error because task is nil

# 2. Implement the CREATE logic in a save instance method
# #save
save_method_task = Task.new(title: 'Save method', description: 'Make it work')
save_method_task.save
puts save_method_task.id

# task = Task.new(title: 'Save method', description: 'Make it work', done: true)
# task.save

# 3. Implement the UPDATE logic in the same method
task_to_update = Task.find(4)
task_to_update.done = true
task_to_update.save

# 4. Implement the READ logic to retrieve all tasks (what type of method is it?)
# ::all
tasks = Task.all
tasks.each do |task|
  puts "#{task.done ? '[X]' : '[ ]'} - #{task.title}"
end

# 5. Implement the DESTROY logic on a task
task_to_remove = Task.find(2)
task_to_remove.destroy
puts Task.find(2).nil?

# ID WILL ALWAYS INCREMENT FROM THE LAST ONE
# Databases will never reuse ID's
# It is meant to be an unique identifier for each record
# Primary Key
nice_questions = Task.new(title: 'Nice questions', description: 'After the bootcamp the web will never be the same')
nice_questions.save
