class Item
  attr_reader :import_condition, :name, :price
  alias_method :imported?, :import_condition

  def initialize(import_condition, name, price)
    @import_condition = import_condition
    @name = name
    @price = price.to_f
  end

  def to_s
    "#{'imported ' if imported? }#{@name}"
  end


  def eql?(o)
    o.is_a?(Item) && hash == o.hash
  end
  alias_method :==, :eql?

  def hash
    @import_condition.hash ^
      @name.hash ^
      (@price * 1000).to_i.hash
  end
end
