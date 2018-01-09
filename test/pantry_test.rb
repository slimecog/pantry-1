require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

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
end
