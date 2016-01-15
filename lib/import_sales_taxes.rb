require_relative 'item.rb'
class ImportSalesTax
  def initialize(tax_rate = 5)
    @tax_rate = tax_rate
  end

  def calculate_tax(item, total_price)
    if item.imported?
      total_price *  @tax_rate / 100
    else
      0
    end
  end
end
