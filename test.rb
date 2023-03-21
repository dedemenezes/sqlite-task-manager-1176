require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# TODO - Create some tasks
# task = Task.find(1)
# puts "#{task.title} - #{task.description}"
# #=> 'Complete Livecode	- Implement CRUD on Task'
# task = Task.find(10)
# puts "#{task.title} - #{task.description}"


# task = Task.new(title: 'Save method', description: 'Make it work')
# # task = Task.new(title: 'Save method', description: 'Make it work', done: true)
# task.save

# puts task.id

# UPDATE

# task = Task.find(4)
# task.done = true
# task.save

# READ ALL

# tasks = Task.all
# tasks.each do |task|
#   puts "#{task.done ? '[X]' : '[ ]'} - #{task.title}"
# end

# task = Task.find(2)
# task.destroy

# puts Task.find(2).nil?
task = Task.new(title: 'Nice questions', description: 'After the bootcamp the web will never be the same')
task.save
