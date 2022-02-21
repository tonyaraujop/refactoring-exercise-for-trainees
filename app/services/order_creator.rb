class OrderCreator < ApplicationService
  def initialize(user:, first_name:, last_name:, address_1:, address_2:, city:, state:, country:, zip:)
    @user = user
    @first_name = first_name
    @last_name = last_name
    @address_1 = address_1
    @address_2 = address_2
    @city = city
    @state = state 
    @country = country
    @zip = zip
  end

  def call
    create_order
  end

  private

  def create_order
  end
end
