require_relative 'sales_taxes/version'
require_relative 'item.rb'
require_relative 'basic_sales_tax.rb'
require_relative 'import_sales_taxes.rb'
require_relative 'taxes_line_parser.rb'
require_relative 'helper.rb'

module SalesTaxes
  def apply_sales_taxes(lines)
    begin
      quantity = parse_item_and_quantity(lines)
    rescue StandardError => e
      return "Sorry: Somthing wrong with the input #{e.message}"
    end

    price = Helper.cal_price_each_item quantity

    taxs_to_apply = [BasicSalesTax.new, ImportSalesTax.new]
    tax = cal_taxs(taxs_to_apply, price)

    receipt = make_receipt(price, quantity, tax)
    receipt.join("\n")
  end

  private

  def parse_item_and_quantity(lines)
    line_parser = LineParser.new
    lines.map { |l| line_parser.parse l }
      .reduce({}) { |a, e| Helper.merge_hash(a, e) }
  end

  def cal_tax_each_item(taxs, item, total_price)
    tax_each_item = taxs.map { |t| t.calculate_tax item, total_price }
                    .reduce(:+)
    Helper.round_to_005 tax_each_item
  end

  def make_receipt(price, quantity, tax)
    receipt = make_items_receipt(price, quantity, tax)
    total_tax = tax.values.reduce(:+)
    receipt << "Sales Taxes: #{format('%.2f', total_tax)}"
    total_price = price.values.reduce(:+)
    receipt << "Total: #{format('%.2f', total_tax + total_price)}"
  end

  def make_items_receipt(price, quantity, tax)
    price.map { |k, v| "#{quantity[k]} #{k}: #{format('%.2f', tax[k] + v)}" }
      .reduce([]) { |a, e| a.push e }
  end

  def cal_taxs(taxs_to_apply, price)
    price.reduce({}) do |h, (k, v)|
      h[k] = cal_tax_each_item(taxs_to_apply, k, v)
      h
    end
  end
end
