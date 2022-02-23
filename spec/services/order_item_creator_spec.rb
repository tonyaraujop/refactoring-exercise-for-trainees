require 'rails_helper'

RSpec.describe OrderItemCreator, 'call' do
  context 'order item exists' do
    let(:cart) { create(:cart) }
    let(:order) { create(:order, user: cart.user) }
    it 'add items to order' do
      expect(OrderItemCreator.call(cart, order)).to be_valid
    end
  end
end
