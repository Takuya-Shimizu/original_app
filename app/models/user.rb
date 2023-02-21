class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.admin_guest
    find_or_create_by!(email: 'admin_guest@example.com') do |user|
      user.name = "管理者ゲスト"
      user.password = SecureRandom.urlsafe_base64
      user.admin = true
    end
  end

  validates :name, presence: true, length: { maximum: 255 }

  has_many :posts
  has_many :favorites, dependent: :destroy
end
