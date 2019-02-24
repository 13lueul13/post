class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, confirmation: true, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validate :future_NG
  has_secure_password
  
  has_many :posts, dependent: :destroy
  has_many :relations, dependent: :destroy
  has_many :followings, through: :relations, source: :follow, dependent: :destroy
  has_many :reverses_of_relation, class_name: "Relation", foreign_key: "follow_id", dependent: :destroy
  has_many :followers, through: :reverses_of_relation, source: :user, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post, dependent: :destroy
  
  def future_NG
    if date_of_birth.present? && date_of_birth > Date.today
    end
  end
  
  def follow(other_user)
    unless self == other_user
      self.relations.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relation = self.relations.find_by(follow_id: other_user.id)
    relation.destroy if relation
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_posts
    Post.where(user_id: self.following_ids + [self.id])
  end
  
  def fav(post)
    self.likes.find_or_create_by(post_id: post.id)
  end
  
  def unfav(post)
    like = self.likes.find_by(post_id: post.id)
    like.destroy if like
  end
  
  def faving?(post)
    self.like_posts.include?(post)
  end
end
