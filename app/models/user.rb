class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true do
    validates :nickname
    validates :birthday
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角（漢字、カタカナ、ひらがな）を使用してください'} do
    validates :family_name
    validates :first_name
  end

  with_options presence: true, format: {with: /\A[ァ-ン]+\z/, message: '全角カタカナを使用してください'} do
    validates :family_kana
    validates :first_kana
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 

  has_many :items
  has_many :purchases
end
