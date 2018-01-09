class Pantry
  attr_reader :stock,
              :shopping_list,
              :cookbook

  def initialize
    @stock         = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook      = Array.new
  end

  def stock_check(ingredient)
    stock[ingredient]
  end

  def restock(ingredient, amount)
    stock[ingredient] += amount
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |ingredient, amount|
      shopping_list[ingredient] += amount
    end
  end

  def print_shopping_list
    shopping_list.reduce("") do |result, (ingredient, amount)|
      result += "* " + ingredient + ": " + amount.to_s + "\n"
    end
  end

  def add_to_cookbook(recipe)
    cookbook << recipe
  end

  def ingredient_amounts(ingredients)
    ingredients.all? do |ingredient|
      stock_check(ingredient[0]) >= ingredient[1]
    end
  end

  def what_can_i_make
    

  end
end
