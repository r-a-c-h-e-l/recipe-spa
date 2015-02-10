require 'pry'
require 'httparty'
require 'json'

puts "what would you like to do? (C)reate, (R)ead, (U)pdate, or (D)estroy?"
response = gets.chomp.downcase

error1 = "you must enter information"

#CREATE
if response == "c"
  puts "enter your recipe's name"
  name = gets.chomp.capitalize
  puts "enter your recipe ingredients"
  ingredients = gets.chomp
  puts "enter your recipe instructions"
  instructions = gets.chomp

  new_recipe = {body:{recipe:{ name: name, ingredients: ingredients, instructions: instructions }}}

  created_recipe = HTTParty.post('http://localhost:3000/recipes', new_recipe)
  id = created_recipe["id"]
  puts HTTParty.get("http://localhost:3000/recipes/#{id}.json")
end

if response == "r"
  puts HTTParty.get('http://localhost:3000/recipes.json')
end

if response == "u"
  puts HTTParty.get('http://localhost:3000/recipes.json')
  puts "enter the id of the recipe you would like to update"
  id = gets.chomp

  recipe = HTTParty.get("http://localhost:3000/recipes/#{id}.json")

  puts "what would you like to update? (N)ame, (Ing)redients, (Ins)tructions"
  update = gets.chomp.downcase
  if update == "n"
    puts "enter the updated recipe name"
    new_name = gets.chomp.capitalize
    recipe["name"] = new_name
    updated_recipe = {body: {recipe: recipe}}
    puts HTTParty.put("http://localhost:3000/recipes/#{id}.json", updated_recipe)
  elsif update == "ing"
    puts "enter the updated ingredients"
    new_ing = gets.chomp
    recipe["ingredients"] = new_ing
    updated_recipe = {body: {recipe: recipe}}
    puts HTTParty.put("http://localhost:3000/recipes/#{id}.json", updated_recipe)
  elsif update == "ins"
    puts "enter the updated instructions"
    new_ins = gets.chomp
    recipe["instructions"] = new_ins
    updated_recipe = {body: {recipe: recipe}}
    puts HTTParty.put("http://localhost:3000/recipes/#{id}.json", updated_recipe)
  end
end

if response == "d"
  puts HTTParty.get('http://localhost:3000/recipes.json')
  puts "enter the id of the recipe you would like to destroy"
  id = gets.chomp

  confirm = HTTParty.delete("http://localhost:3000/recipes/#{id}.json")
  puts confirm["body"]
end
