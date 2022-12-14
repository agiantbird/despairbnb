class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # associations
  has_one :profile, dependent: :destroy
  has_one_attached :picture
  has_many :favorites, dependent: :destroy
  has_many :favorited_properties, through: :favorites, source: :property
  has_many :reservations, dependent: :destroy
  has_many :payments, through: :reservations
  has_many :reserved_properties, through: :reservations, source: :property
  has_many :reviews, dependent: :destroy

  # callbacks
  after_create :create_profile

  def create_profile
    self.profile = Profile.new
    save!
  end

  delegate :full_name, to: :profile
end
