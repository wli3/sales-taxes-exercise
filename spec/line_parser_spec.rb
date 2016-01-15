require 'spec_helper'

describe 'Line Parser' do
  line_parser = LineParser.new

  context 'given a line of shopping baskets begin with number and price' do
    nonimported_item = '1 book at 12.49'
    imported_item = '2 imported bottle of perfume at 27.99'
    imported_number_in_name = '3 imported 13.1 inches smart phone at 27.99'

    it 'can parse the quantity' do
      result0 = line_parser.send(:parse_quantity, nonimported_item)
      expect(result0).to eq(1)

      result1 = line_parser.send(:parse_quantity, imported_item)
      expect(result1).to eq(2)

      result2 = line_parser.send(:parse_quantity, imported_number_in_name)
      expect(result2).to eq(3)
    end

    it 'can parse the import condition' do
      result0 = line_parser.send(:parse_import_condition, nonimported_item)
      expect(result0).to eq(false)

      result1 = line_parser.send(:parse_import_condition, imported_item)
      expect(result1).to eq(true)

      result2 = line_parser.send(:parse_import_condition,
                                 imported_number_in_name)
      expect(result2).to eq(true)
    end

    it 'can parse the name of the item' do
      result0 = line_parser.send(:parse_name, nonimported_item)
      expect(result0).to eq('book')

      result1 = line_parser.send(:parse_name, imported_item)
      expect(result1).to eq('bottle of perfume')

      result2 = line_parser.send(:parse_name, imported_number_in_name)
      expect(result2).to eq('13.1 inches smart phone')
    end

    it 'can parse the price of the item' do
      result0 = line_parser.send(:parse_price, nonimported_item)
      expect(SubjectFloat.which_is result0, close_to: 12.49).to be(true)

      result1 = line_parser.send(:parse_price, imported_item)
      expect(SubjectFloat.which_is result1, close_to: 13.995).to be(true)

      result2 = line_parser.send(:parse_price, imported_number_in_name)
      expect(SubjectFloat.which_is result2, close_to: 9.33).to be(true)


    end
    it 'can return the item with quantity' do
      expected_item0 = Item.new(false, 'book', 12.49)
      result0 = line_parser.parse(nonimported_item)
      expect(result0.keys.first).to eq(expected_item0)
      expect(result0[result0.keys.first]).to eq(1)

      expected_item1 = Item.new(true, 'bottle of perfume', 13.995)
      result1 = line_parser.parse(imported_item)
      expect(result1.keys.first).to eq(expected_item1)
      expect(result1[result1.keys.first]).to eq(2)

      expected_item2 = Item.new(true,
                                '13.1 inches smart phone',
                                9.33)
      result2 = line_parser.parse(imported_number_in_name)
      expect(result2.keys.first).to eq(expected_item2)
      expect(result2[result2.keys.first]).to eq(3)
    end
  end

  context 'given a line of shopping baskets without a money' do
    item_without_money = '1 bottle of perfume'
    it 'should raise an excpetion' do
      expect { line_parser.parse(item_without_money) }.to raise_error
    end
  end

  context 'given a line of shopping baskets without a quantity' do
    item_without_quantity = 'bottle of perfume 1.23'
    it 'should raise an excpetion' do
      expect { line_parser.parse(item_without_quantity) }.to raise_error
    end
  end

  context 'given a line a shopping baskets with wrong format money' do
    item_without_wrong_money = '1 bottle of perfume 321.123'
    it 'should raise an excpetion' do
      expect { line_parser.parse(item_without_wrong_money) }.to raise_error
    end
  end

  context 'given a too long line' do
    long_line = ' i am a long line, probably input a wrong file, lalalalalalala \
i am a long line, probably input a wrong file, lalalalalalala\
i am a long line, probably input a wrong file, lalalalalalala\
i am a long line, probably input a wrong file, lalalalalalala\
i am a long line, probably input a wrong file, lalalalalalala\
i am a long line, probably input a wrong file, lalalalalalala'
    it 'should raise an excpetion' do
      expect { TaxesLineParser.parse(item_without_wrong_money) }.to raise_error
    end
  end
end
