class PurchasesController < ApplicationController
  def create
    return render json: { errors: [{ message: 'Gateway not supported!' }] },
      status: :unprocessable_entity unless gateway_valid?

    @cart = Cart.find_by(id: purchase_params[:cart_id])
    return render json: { errors: [{ message: 'Cart not found!' }] },
      status: :unprocessable_entity unless @cart

    @user = AssignUserToCart.call(purchase_params, @cart)
    return render json: { errors: @user.errors.map(&:full_message).map { |message| { message: message } } },
      status: :unprocessable_entity unless @user.valid?

    @order = OrderBuilder.call(address_params, @user)
    
    OrderItemCreator.call(@cart, @order)
    @order.save

    return render json: { errors: @order.errors.map(&:full_message).map { |message| { message: message } } },
      status: :unprocessable_entity unless @order.valid?
    return render json: { status: :success, order: { id: @order.id } }, status: :ok
  end

  private

  def purchase_params
    params.permit(
      :cart_id,
      user: %i[email first_name last_name],
      address: %i[address_1 address_2 city state country zip]
    )
  end

  def address_params
    purchase_params[:address] || {}
  end

  def gateway_params 
    params.permit(:gateway)
  end

  def gateway_valid?
    allowed_gateways = ['paypal', 'stripe']
    allowed_gateways.include?(gateway_params[:gateway])
  end
end
