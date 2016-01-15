require 'spec_helper'

describe 'Help' do
  context 'given 2 hash with several entry in common' do
    h1 = { 'a' => 1, 'b' => 2, 'c' => 3 }
    h2 = {  'b' => 3, 'c' => 5, 'd' => 4 }
    it 'can merge the the 2 hash' do
      merged = Helper.merge_hash(h1, h2)
      expect(merged['a']).to be(1)
      expect(merged['b']).to be(5)
      expect(merged['c']).to be(8)
      expect(merged['d']).to be(4)
    end
  end

  context 'given a item, quantity hash' do
    i1 = Item.new(true, 'book', 1.01)
    i2 = Item.new(false, 'nook', 2.02)
    h = { i1 => 1, i2 => 2 }
    it 'can return the total price of the count' do
      result = Helper.cal_price_each_item(h)
      expect(SubjectFloat.which_is result[i1], close_to: 1.01).to be(true)
      expect(SubjectFloat.which_is result[i2], close_to: 4.04).to be(true)
    end
  end

  context 'given anumber' do
    f = 54.625
    it 'can round to nearest 0.05' do
      expect(Helper.round_to_005 f).to be(54.65)
    end
  end
end
