# frozen_string_literal: true
class Property < ApplicationRecord
  CLEANING_FEE = 5_000.freeze
  CLEANING_FEE_MONEY = Money.new(CLEANING_FEE)
  SERVICE_FEE_PERCENTAGE = (0.08).freeze
  # Validations
  validates :name, presence: true
  validates :headline, presence: true
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true

  # money-rails
  monetize :price_cents, allow_nil: true

  # Geocoder
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.latitude.blank? && obj.longitude.blank? }

  has_many_attached :images, dependent: :destroy
  has_many :reviews, as: :reviewable
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :reservations, dependent: :destroy
  has_many :payments, through: :reservations
  has_many :reserved_users, through: :reservations, source: :user

  def address
    [state, country].compact.join(', ')
  end

  def default_image
    images.first
  end

  def favorited_by?(user = nil)
    return if user.nil?

    favorited_users.include?(user)
  end

  def available_dates
    next_reservation = reservations.future_reservations.order(checkout_date: :desc).first
    date_format = "%b %e"

    return Date.tomorrow.strftime(date_format)..Date.today.end_of_year.strftime(date_format) if next_reservation.nil?

    next_reservation.checkout_date.strftime(date_format)..Date.today.end_of_year.strftime(date_format)
  end
end
