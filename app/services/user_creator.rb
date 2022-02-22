class UserCreator < ApplicationService
  def initialize(purchase_params, cart)
    @purchase_params = purchase_params
    @cart = cart
  end

  def call
    create_user
  end

  private

  def create_user
    user = if @cart.user.nil?
      user_params = @purchase_params[:user] ? @purchase_params[:user] : {}
      User.create(**user_params.merge(guest: true))
    else
      @cart.user
    end
  end
end
