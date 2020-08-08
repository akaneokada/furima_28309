class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :family_name, :first_name, :birthday, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true }, format: { with: /@/}
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, format: { with: /\A[a-z\d]+\z/i }
  validates :password_confirmation, presence: true
  validates :family_name_kana, :first_name_kana, format: { with: /\A[ァ-ン]+\z/ }
end