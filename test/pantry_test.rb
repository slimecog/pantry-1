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

  def test_recipe_can_be_added_to_shopping_list
    pn = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    pn.add_to_shopping_list(r)

    assert_equal ({"Cheese" => 20, "Flour" => 20}), pn.shopping_list
  end
end
