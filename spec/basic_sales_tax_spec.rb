require 'spec_helper'

describe 'basic sales tax' do
  basic_sales_tax = BasicSalesTax.new
  context 'normal item and the total price' do
    item = Item.new(true, 'bottle of perfume', 12.2)
    total_price = 24.4
    it 'can calcuate the tax of basic sales' do
      result = basic_sales_tax.calculate_tax(item, total_price)
      expect(SubjectFloat.which_is result, close_to: 2.44).to be(true)
    end
  end

  context 'book, food, medical item and the total price' do
    book = Item.new(true, 'awesome book', 12.2)
    total_price0 = 24.4
    chocolate = Item.new(true, 'awesome chocolate', 12.2)
    total_price1 = 24.4
    pills = Item.new(true, 'awesome headache pills', 12.2)
    total_price2 = 24.4
    it 'will not apply tax, which is give a 0' do
      result0 = basic_sales_tax.calculate_tax(book, total_price0)
      expect(SubjectFloat.which_is result0, close_to: 0.0).to be(true)

      result1 = basic_sales_tax.calculate_tax(chocolate, total_price1)
      expect(SubjectFloat.which_is result1,
                                   close_to: 0.0).to be(true)

      result2 = basic_sales_tax.calculate_tax(pills, total_price2)
      expect(SubjectFloat.which_is result2, close_to: 0.0).to be(true)
    end
  end
end
