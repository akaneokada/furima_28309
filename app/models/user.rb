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
                                                message: 'は半角英数字混合にしてください' }
    validates :password_confirmation
    validates :family_name,           format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角で入力してください' }
    validates :first_name,            format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角で入力してください' }
    validates :family_name_kana,      format: { with: /\A[ァ-ン]+\z/, message: 'は全角カナで入力してください' }
    validates :first_name_kana,       format: { with: /\A[ァ-ン]+\z/, message: 'は全角カナで入力してください' }
    validates :birthday
  end
end
