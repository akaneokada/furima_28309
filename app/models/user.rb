class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :buyers

  with_options presence: true do
    validates :nickname
    validates :email,                 uniqueness: { case_sensitive: true },
                                      format: { with: /@/ }
    validates :password,              confirmation: true,
                                      format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i,
                                                message: 'Include both letters and numbers' }
    validates :password_confirmation
    validates :family_name,           format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'Full-width characters.' }
    validates :first_name,            format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'Full-width characters.' }
    validates :family_name_kana,      format: { with: /\A[ァ-ン]+\z/, message: 'Full-width katakana characters' }
    validates :first_name_kana,       format: { with: /\A[ァ-ン]+\z/, message: 'Full-width katakana characters' }
    validates :birthday
  end
end
