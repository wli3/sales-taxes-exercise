require 'spec_helper'
include SalesTaxes
describe 'sales taxes' do

  context 'given an array of shopping baskets' do
    input_1 = [
      '1 book at 12.49',
      '1 music CD at 14.99',
      '1 chocolate bar at 0.85'
    ]

    input_2 = [
      '1 imported box of chocolates at 10.00',
      '1 imported bottle of perfume at 47.50'
    ]

    input_3 = [
      '1 imported bottle of perfume at 27.99',
      '1 bottle of perfume at 18.99',
      '1 packet of headache pills at 9.75',
      '1 box of imported chocolates at 11.25'
    ]

    input_du = [
               '1 book at 12.49',
               '1 music CD at 14.99',
               '1 book at 12.49',
               '1 chocolate bar at 0.85'
              ]

    it 'can return prints out the receipt details' do
      output_1 = apply_sales_taxes(input_1)
      expect(output_1).to eq(
                             "1 book: 12.49
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 29.83")

      output_2 = apply_sales_taxes(input_2)
      expect(output_2).to eq(
                             "1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15")

      output_3 = apply_sales_taxes(input_3)
      expect(output_3).to eq(
                             "1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
1 imported box of chocolates: 11.85
Sales Taxes: 6.70
Total: 74.68")

      output_du = apply_sales_taxes(input_du)
      expect(output_du).to eq(
                             "2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32")

    end
  end

  context 'given an array of wrong shopping baskets' do
    input_wrong = [
      'book at 12.49',
      '1 music CD at 14.99',
      '1 chocolate bar at'
    ]

    it 'should tell that something is wrong and stop' do
      output_wrong = apply_sales_taxes(input_wrong)
      expect(output_wrong.include? 'Sorry:').to be(true)
    end
  end
end
