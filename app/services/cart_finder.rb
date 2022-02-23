class CartFinder < ApplicationService
  def initialize(purchase_params)
    @purchase_params = purchase_params
  end

  def call
    create_cart
  end

  private

  def create_cart
    Cart.find_by(id: @purchase_params[:cart_id])
  end
end
