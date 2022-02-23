require 'rails_helper'

RSpec.describe UserCreator, 'call' do
  context 'cart user exist' do
    let(:cart) { create(:cart) }
    it 'returns cart user' do
      expect(UserCreator.call({}, cart).guest).to eq(false)
    end
  end

  context 'cart user does not exit' do
    let(:cart_with_no_user) { create(:cart, user: nil) }
    it 'create guest user' do
      expect(UserCreator.call({}, cart_with_no_user).guest).to eq(true)
    end
  end
end
