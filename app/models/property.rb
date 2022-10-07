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

  def address
    [state, country].compact.join(', ')
  end

  def default_image
    images.first
  end
end
