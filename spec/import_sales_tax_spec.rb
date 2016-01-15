require 'spec_helper'

describe 'import sales tax' do
  import_sales_tax = ImportSalesTax.new
  context 'given imported item and the total price' do
    item = Item.new(true, 'bottle of perfume', 12.2)
    total_price = 24.4
    it 'can give the tax which is 5% of total' do
      result = import_sales_tax.calculate_tax(item, total_price)
      expect(SubjectFloat.which_is result, close_to: 1.22).to be(true)
    end
  end

  context 'given non imported item and the total price' do
    item = Item.new(false, 'bottle of perfume', 12.2)
    total_price = 24.4
    it 'do not apply which is 0' do
      result = import_sales_tax.calculate_tax(item, total_price)
      expect(SubjectFloat.which_is result, close_to: 0.0).to be(true)
    end
  end
end
