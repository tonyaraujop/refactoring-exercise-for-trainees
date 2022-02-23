require 'rails_helper'

RSpec.describe CartFinder, 'call' do
  context 'cart exists' do
    let(:cart) { create(:cart) }
    it 'return cart' do
      expect(CartFinder.call(cart_id: cart.id)).to eq(cart)
    end
  end

  context 'cart does not exist' do
    it 'return nil' do
      expect(CartFinder.call(cart_id: -1)).to eq(nil)
    end
  end
end
