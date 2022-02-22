class PurchasesController < ApplicationController

  before_action :create_cart

  def create
    return render json: { errors: [{ message: 'Gateway not supported!' }] },
      status: :unprocessable_entity unless gateway_valid?

    return render json: { errors: [{ message: 'Cart not found!' }] },
      status: :unprocessable_entity unless @cart

    user = create_user
    
    return render json: { errors: user.errors.map(&:full_message).map { |message| { message: message } } },
      status: :unprocessable_entity unless user.valid?

    @order = create_order
    
    create_order_items

    return render json: { errors: @order.errors.map(&:full_message).map { |message| { message: message } } },
      status: :unprocessable_entity unless @order.valid?
    return render json: { status: :success, order: { id: @order.id } }, status: :ok
  end

  private

  def purchase_params
    params.permit(
      :gateway,
      :cart_id,
      user: %i[email first_name last_name],
      address: %i[address_1 address_2 city state country zip]
    )
  end

  def address_params
    purchase_params[:address] || {}
  end

  def shipping_costs
    100
  end

  def gateway_params 
    params.permit(:gateway)
  end

  def gateway_valid?
    allowed_gateways = ['paypal', 'stripe']
    allowed_gateways.include?(gateway_params[:gateway])
  end

  def create_cart
    @cart = Cart.find_by(id: purchase_params[:cart_id])
  end

  def create_user
    @user = if @cart.user.nil?
      user_params = purchase_params[:user] ? purchase_params[:user] : {}
      User.create(**user_params.merge(guest: true))
    else
      @cart.user
    end
  end

  def create_order 
    Order.new(
      user: @user,
      first_name: @user.first_name,
      last_name: @user.last_name,
      address_1: address_params[:address_1],
      address_2: address_params[:address_2],
      city: address_params[:city],
      state: address_params[:state],
      country: address_params[:country],
      zip: address_params[:zip],
    )
  end

  def create_order_items 
    @cart.items.each do |item|
      item.quantity.times do
        @order.items << OrderLineItem.new(
          order: @order,
          sale: item.sale,
          unit_price_cents: item.sale.unit_price_cents,
          shipping_costs_cents: shipping_costs,
          paid_price_cents: item.sale.unit_price_cents + shipping_costs
        )
      end
    end
    @order.save
  end
end
