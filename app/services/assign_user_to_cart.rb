class AssignUserToCart < ApplicationService
  def initialize(purchase_params, cart)
    @purchase_params = purchase_params
    @cart = cart
  end

  def call
    assign_user_to_cart
  end

  private

  def assign_user_to_cart
    user = if @cart.user.nil?
      user_params = @purchase_params[:user] ? @purchase_params[:user] : {}
      User.create(**user_params.merge(guest: true))
    else
      @cart.user
    end
  end
end
