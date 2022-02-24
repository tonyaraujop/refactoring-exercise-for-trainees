class OrderBuilder < ApplicationService
  def initialize(address_params, user)
    @address_params = address_params
    @user = user
  end

  def call
    build_order
  end

  private

  def build_order 
    Order.new(
      user: @user,
      first_name: @user.first_name,
      last_name: @user.last_name,
      address_1: @address_params[:address_1],
      address_2: @address_params[:address_2],
      city: @address_params[:city],
      state: @address_params[:state],
      country: @address_params[:country],
      zip: @address_params[:zip],
    )
  end
end
