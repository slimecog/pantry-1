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

  # def what_can_i_make
  #   stock.map do |ingredients|
  #     cookbook.each do |recipe|
  #       if recipe.ingredients.keys == ingredients[0] && recipe.ingredients.values >= ingredients[1]
  #         return recipe.name
  #       end
  #     end
  #   end
  # end

  def stocked
    stock.map { |pair| pair }
  end

  # def needed
  #   cookbook.map { |recipe| recipe[recipe.name] = recipe.ingredients }
  # end

  def what_can_i_make
    cookbook.map do |recipe|
      recipe.ingredients.each do |pair|
        # require "pry"; binding.pry
        if stock_check(pair[0]) >= pair[1]
          return recipe.name
        end
      end
    end
  end


end
