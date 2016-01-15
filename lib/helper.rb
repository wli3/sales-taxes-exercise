require_relative 'item.rb'
require_relative 'basic_sales_tax.rb'
require_relative 'import_sales_taxes.rb'


class Helper
  def self.merge_hash(h1, h2)
    h1.merge(h2) { |_key, oldval, newval| newval + oldval }
  end

  def self.cal_price_each_item(item_with_quantity)
    result = {}
    item_with_quantity.each do |k, v|
      result[k] = v * k.price
    end
    result
  end

  def self.round_to_005(f)
    (f * (1 / 0.05)).ceil / (1 / 0.05)
  end
end
