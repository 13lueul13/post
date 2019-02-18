class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence:true, lenght: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :email_confirmation, presence: true
  validates :future_NG
  has_seccure_password
  
  def future_NG
    if date_of_birth.present? && birthday > Date.today
      errors.add(:birthday, "あなたは未来人ですか？")
    end
  end
end
