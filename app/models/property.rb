class Property < ApplicationRecord
  # Validations
  validates :name, presence: true
  validates :headline, presence: true
  validates :description, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true

  # Geocoder
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.latitude.blank? && obj.longitude.blank? }

  def address
    [state, country].compact.join(', ')
  end
end
