class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  with_options presence: true do
    validates :nickname
    validates :email,                 uniqueness: { case_sensitive: true },
                                      format: { with: /@/ }
    validates :password,              confirmation: true,
                                      format: { with: /\A[a-z\d]+\z/i }
    validates :password_confirmation
    validates :family_name
    validates :first_name
    validates :family_name_kana,      format: { with: /\A[ァ-ン]+\z/ }
    validates :first_name_kana,       format: { with: /\A[ァ-ン]+\z/ }
    validates :birthday

  end
  

end
