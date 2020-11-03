class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角文字を使用してください'} do
    validates :family_name
    validates :first_name
  end
  with_options presence: true, format: {with: /\A[ァ-ン]+\z/, message: 'カタカナを使用してください'} do
    validates :family_kana
    validates :first_kana
  end
  validates :birthday, presence: true

end
