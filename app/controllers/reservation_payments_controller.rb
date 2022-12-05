# frozen_string_literal: true
class ReservationPaymentsController < ApplicationController
  def create
    raise
  end

  private
  def payments_params
    params.permit(:stripeToken, :property_id, :user_id, :checkin_date, :checkout_date,
                  :subtotal, :cleaning_fee, :service_fee, :total)
  end

  def user
    @user ||= User.find(params[:user_id])
  end

  def stripe_customer
    @stripe_customer ||=
      if user.stripe_id.blank?
        customer = Stripe::Customer.create(email: user.email)
        user.update(stripe_id = customer.id)
        customer
      else
        Stripe::Customer.retrieve(user.stripe_id)
      end
  end
end