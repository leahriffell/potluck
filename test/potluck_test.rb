require 'minitest/autorun'
require 'minitest/pride'
require './lib/dish'
require './lib/potluck'

class PotluckTest <  Minitest::Test
  def setup
    @potluck = Potluck.new('7-13-18')
    @couscous_salad = Dish.new('Couscous Salad', :appetizer)
    @cocktail_meatballs = Dish.new('Cocktail Meatballs', :entree)
    @summer_pizza = Dish.new('Summer Pizza', :appetizer)
    @roast_pork = Dish.new('Roast Pork', :entree)
    @candy_salad = Dish.new('Candy Salad', :dessert)
    @bean_dip = Dish.new("Bean Dip", :appetizer)
  end

  def test_it_exists
    assert_instance_of Potluck, @potluck
  end

  def test_it_has_a_date
    assert_equal '7-13-18', @potluck.date
  end

  def test_it_has_dishes
    assert_equal [], @potluck.dishes
  end

  def test_it_can_add_dishes
    assert_equal [], @potluck.dishes

    @potluck.add_dish(@couscous_salad)
    assert_equal [@couscous_salad], @potluck.dishes

    @potluck.add_dish(@cocktail_meatballs)
    assert_equal [@couscous_salad, @cocktail_meatballs], @potluck.dishes

    assert_equal 2, @potluck.dishes.length
  end

  def test_it_can_get_dishes_from_a_category
    @potluck.add_dish(@couscous_salad)
    @potluck.add_dish(@summer_pizza)
    @potluck.add_dish(@roast_pork)
    @potluck.add_dish(@cocktail_meatballs)
    @potluck.add_dish(@candy_salad)

    assert_equal [@couscous_salad, @summer_pizza], @potluck.get_all_from_category(:appetizer)
    assert_equal @couscous_salad, @potluck.get_all_from_category(:appetizer).first
    assert_equal 'Couscous Salad', @potluck.get_all_from_category(:appetizer).first.name
  end

  def test_it_can_sort_dishes_alphabetically_by_category
    @potluck.add_dish(@couscous_salad)
    @potluck.add_dish(@summer_pizza)
    @potluck.add_dish(@roast_pork)
    @potluck.add_dish(@cocktail_meatballs)
    @potluck.add_dish(@candy_salad)
    @potluck.add_dish(@bean_dip)

    assert_equal ({ :appetizers => ['Bean Dip', 'Couscous Salad', 'Summer Pizza'], :entrees => ['Cocktail Meatballs', 'Roast Pork'], :desserts => ['Candy Salad'] }), @potluck.menu
  end

  def test_it_can_get_the_ratio_of_dishes_in_a_category
    @potluck.add_dish(@couscous_salad)
    @potluck.add_dish(@summer_pizza)
    @potluck.add_dish(@roast_pork)
    @potluck.add_dish(@cocktail_meatballs)
    @potluck.add_dish(@candy_salad)
    @potluck.add_dish(@bean_dip)

    assert_equal 50.0, @potluck.ratio(:appetizer)
    assert_equal 0, @potluck.ratio(:snack)
  end
end