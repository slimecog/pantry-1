require 'minitest/autorun'
require 'minitest/pride'
require './lib/pantry'
require './lib/recipe'

class PantryTest < Minitest::Test

  def test_it_exists
    pn = Pantry.new

    assert_instance_of Pantry, pn
  end

  def test_it_is_created_with_empty_stock_hash
    pn = Pantry.new

    assert_equal Hash.new(0), pn.stock
  end

  def test_stock_of_ingredient_can_be_ckeck_to_return_amount_owned
    pn = Pantry.new

    assert_equal 0, pn.stock_check("Cheese")
  end

  def test_ingredients_can_be_restocked
    pn = Pantry.new

    pn.restock("Cheese", 10)

    assert_equal 10, pn.stock_check("Cheese")

    pn.restock("Cheese", 20)

    assert_equal 30, pn.stock_check("Cheese")
  end

  def test_recipe_can_be_created_with_empty_ingredients_hash_and_ingredients_can_be_added_to_it
    pn = Pantry.new
    r = Recipe.new("Cheese Pizza")

    assert_equal ({}), r.ingredients

    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    assert_equal ({"Cheese" => 20, "Flour" => 20}), r.ingredients
  end

  def test_pantry_is_created_with_empty_shopping_list_hash
    pn = Pantry.new

    assert_equal Hash.new(0), pn.shopping_list
  end

  def test_recipes_can_be_added_to_shopping_list
    pn = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pn.add_to_shopping_list(r)

    assert_equal ({"Cheese" => 20, "Flour" => 20}), pn.shopping_list

    r2 = Recipe.new("Spaghetti")
    r2.add_ingredient("Spaghetti Noodles", 10)
    r2.add_ingredient("Marinara Sauce", 10)
    r2.add_ingredient("Cheese", 5)
    pn.add_to_shopping_list(r2)

    assert_equal ({"Cheese"=>25, "Flour"=>20, "Spaghetti Noodles"=>10, "Marinara Sauce"=>10}), pn.shopping_list
  end

  def test_shopping_list_can_be_printed
    pn = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pn.add_to_shopping_list(r)
    r2 = Recipe.new("Spaghetti")
    r2.add_ingredient("Spaghetti Noodles", 10)
    r2.add_ingredient("Marinara Sauce", 10)
    r2.add_ingredient("Cheese", 5)
    pn.add_to_shopping_list(r2)

    assert_equal "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10\n", pn.print_shopping_list
  end

  def test_recipes_can_be_added_to_cookbook
    pn = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pn.add_to_cookbook(r1)
    pn.add_to_cookbook(r2)
    pn.add_to_cookbook(r3)

    assert_equal [r1, r2, r3], pn.cookbook
  end

  def test_ingredient_amounts_returns_boolean_based_on_whether_recipe_can_be_made
    pn = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    pn.restock("Cheese", 10)
    pn.restock("Flour", 20)
    pn.restock("Brine", 40)
    pn.restock("Cucumbers", 120)
    pn.restock("Raw nuts", 20)
    pn.restock("Salt", 20)
    pn.add_to_cookbook(r1)
    pn.add_to_cookbook(r2)
    pn.add_to_cookbook(r3)

    refute pn.ingredient_amounts(pn.cookbook.first.ingredients)
    assert pn.ingredient_amounts(pn.cookbook[1].ingredients)
    assert pn.ingredient_amounts(pn.cookbook.last.ingredients)
  end

  def test_what_can_i_make_returns_recipes_based_on_ingredients_in_stock
    pn = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    pn.restock("Cheese", 10)
    pn.restock("Flour", 20)
    pn.restock("Brine", 40)
    pn.restock("Cucumbers", 120)
    pn.restock("Raw nuts", 20)
    pn.restock("Salt", 20)
    pn.add_to_cookbook(r1)
    pn.add_to_cookbook(r2)
    pn.add_to_cookbook(r3)

    # assert_equal ["Pickles", "Peanuts"], pn.what_can_i_make
  end
end
