require 'rails_helper'

RSpec.describe OrderBuilder, 'call' do
  context 'order exists' do
    let(:user) { create(:user) }
    it 'returns order' do
      expect(OrderBuilder.call({}, user).attributes).to include({"user_id" => user.id,
                                                                "first_name" => user.first_name,
                                                                "last_name" => user.last_name,
                                                                "address_1" => nil,
                                                                "address_2" => nil,
                                                                "city" => nil,
                                                                "country" => nil,
                                                                "state" => nil,
                                                                "zip" => nil})
    end
  end
end
