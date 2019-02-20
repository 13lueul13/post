class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, confirmation: true, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :email_confirmation, presence: true
  validate :future_NG
  has_secure_password
  
  has_many :posts
  
  def future_NG
    if date_of_birth.present? && birthday > Date.today
      errors.add(:birthday, "あなたは未来人ですか？")
    end
  end
end
