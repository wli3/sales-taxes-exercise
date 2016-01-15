require 'spec_helper'

describe 'items' do
  context 'have different name, price, import condition' do
    item0 = Item.new(true, 'book', 12.00)
    item1 = Item.new(true, 'book', 11.00)
    item2 = Item.new(true, 'nook', 11.00)
    item3 = Item.new(false, 'nook', 11.00)
    it 'do not considered same' do
      expect(item0).not_to eq(item1)
      expect(item1).not_to eq(item2)
      expect(item0).not_to eq(item2)
      expect(item2).not_to eq(item3)
    end
  end

  context 'have same name, same price' do
    item0 = Item.new(true, 'book', 12.00)
    item1 = Item.new(true, 'book', 12.00)
    it 'considered same' do
      expect(item0).to eq(item1)
      h = {}
      h[item0] = 1
      h[item1] = 1
      expect(h.length).to eq(1)
    end
  end

  context 'with correct object' do
    item0 = Item.new(false, 'book', 12.00)
    item1 = Item.new(true, 'book', 12.00)
    it 'can give proper print format' do
      expect(item0.to_s).to eq('book')
      expect(item1.to_s).to eq('imported book')
    end
  end

end
