require 'rails_helper'

RSpec.describe OrderItemCreator, 'call' do
  context 'order item exists' do
    let(:sale) { create(:sale) }
    let(:item) { create(:cart_item, sale: sale, quantity: 2) }
    let(:order) { create(:order, user: item.cart.user) }
    it 'add items to order' do
      expect { OrderItemCreator.call(item.cart, order) }.to change(OrderLineItem, :count).by(item.quantity)
    end
  end
end
