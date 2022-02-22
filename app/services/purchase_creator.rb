class PurchaseCreator < ApplicationService
  def initialize(address_params, purchase_params)
    @address_params = address_params
    @purchase_params = purchase_params
  end

  def call
    create_purchase
  end

  private

  def create_purchase
  end
end
