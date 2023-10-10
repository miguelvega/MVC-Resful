=begin
A toy Sinatra app to demonstrate the basic concept of MVC, RESTful Routes and CRUD.
Run ``bundle install`` to make sure you have necessary gems installed.
TO run the script, type ``ruby template.rb`` in command line.
updated: jeremy warner, original author: hezheng.yin
=end

# load libraries we need
require 'sinatra'
require 'active_record'
require 'json'

# tell active_record which database to connect to
db_options = {adapter: 'sqlite3', database: 'todos_db'}
ActiveRecord::Base.establish_connection(db_options)

# write migration class for creating Todo table in database
### how do we write migration in rails?
class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :description
    end
  end
end

# create Todo table by executing the function we just wrote
### how do apply migration in rails?
### why do we handle exception here?
begin
  CreateTodos.new.change
rescue ActiveRecord::StatementInvalid
  # it's probably OK
end

# create Todo class by inheriting from ActiveRecord::Base
### how do we write new class in Rails?
### why there's no setter and getter method (or attr_accessor)?
class Todo < ActiveRecord::Base
end

# populate the database if it is empty (avoid running this piece of code twice)
### do you still remember this cleaner and simpler hash syntax?
# old version: new_hash = {:simon => "Talek", :lorem => "Ipsum"}
if Todo.all.empty?
  Todo.create(description: "prepare for discussion section")
  Todo.create(description: "release cc 3s2")
end

# display all todos
get '/todos' do
  content_type :json
  Todo.all.to_json
end

# show a specific todo
get '/todos/:id' do
  content_type :json
  todo = Todo.find_by_id(params[:id])
  if todo
    return {description: todo.description}.to_json
  else
    return {msg: "error: specified todo not found"}.to_json
  end
end

# create a new todo
# return: if we receive non-empty description, render json with msg set to "create success"
# 			otherwise render json with msg set to "error: description can't be blank"
# hint: use method Todo's class method create
post '/todos' do
  ### TU CODIGO AQUI
end

# update a todo
# return: if todo with specified id exist and description non-empty, render json with msg set to "update success"
# 				otherwise render json with msg set to "update failure"
# hint: Todo class has instance method update_attribute
put '/todos/:id' do
  ### TU CODIGO AQUI ###
end

# delete a todo
# return: if todo with specified id exist, render json with msg set to "delete success"
# 				otherwise render json with msg set to "delete failure"
# hint: Todo class has instance method destroy
delete '/todos/:id' do
  ### TU CODIGO AQUI ###
end
