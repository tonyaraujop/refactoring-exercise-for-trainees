require 'rails_helper'

RSpec.describe OrderItemCreator, 'call' do
  context 'order item exists' do
    let(:cart) { create(:cart) }
    let(:order) { create(:order, user: cart.user) }
    it 'save order' do
      expect(OrderItemCreator.call(cart, order)).to eq(true)
    end
  end
end
