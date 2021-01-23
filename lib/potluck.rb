require 'active_support/inflector'

class Potluck
  attr_accessor :date,
                :dishes

  def initialize(date)
    @date = date
    @dishes = []
  end

  def add_dish(dish)
    @dishes << dish
  end
  
  def get_all_from_category(category)
    @dishes.find_all { |dish| dish.category == category }
  end

  def menu
    menu = Hash.new([])
    [:appetizers, :entrees, :desserts].each do |course|
      menu[course] = @dishes.map { |dish| dish.name if dish.category == course[0..-2].to_sym }.compact.sort
    end
    menu
  end

  def ratio(category)
    curated_menu ||= menu
    (curated_menu[category.to_s.pluralize.to_sym].size / curated_menu.values.flatten.size.to_f) * 100
  end
end