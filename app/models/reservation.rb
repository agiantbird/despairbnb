class Reservation < ApplicationRecord
  belongs_to :property
  belongs_to :user
  has_one :payment, dependent: :destroy

  validates :checkin_date, presence: true
  validates :checkout_date, presence: true

  # validates :reservation_date, presence: true

  # scope :future_reservations, -> { where("reservation_date > ?", Date.today).order(:reservation_date) }
end
