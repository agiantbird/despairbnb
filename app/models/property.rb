class Property < ApplicationRecord
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
end
