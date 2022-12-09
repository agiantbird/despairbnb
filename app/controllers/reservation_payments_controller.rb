# frozen_string_literal: true
class ReservationPaymentsController < ApplicationController
  def create
    charge = Stripe::Charge.create(
      amount: Money.from_amount(BigDecimal(payment_params[:total])).cents,
      currency: "usd",
      source: payment_params[:stripeToken],
      customer: stripe_customer.id
    )

    reservation = Reservation.create(
      property: property,
      user: user,
      checkin_date: checkin_date,
      checkout_date: checkout_date
    )

    payment = Payment.create(
      reservation: reservation,
      subtotal: Money.from_amount(BigDecimal(payment_params[:subtotal])),
      cleaning_fee: Money.from_amount(BigDecimal(payment_params[:cleaning_fee])),
      service_fee: Money.from_amount(BigDecimal(payment_params[:service_fee])),
      total: Money.from_amount(BigDecimal(payment_params[:total])),

    )
  end

  private
  def payment_params
    params.permit(:stripeToken, :property_id, :user_id, :checkin_date, :checkout_date,
                  :subtotal, :cleaning_fee, :service_fee, :total)
  end

  def property
    @property ||= Property.find(payment_params[:property_id])
  end

  def checkin_date
    checkin_date ||= Date.strptime(payment_params[:checkin_date].to_s)
  end

  def checkout_date
    checkout_date ||= Date.strptime(payment_params[:checkout_date].to_s)
  end

  def user
    @user ||= User.find(payment_params[:user_id])
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