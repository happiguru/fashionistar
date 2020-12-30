class Post < ApplicationRecord
  validates :postcontent, presence: true, length: { maximum: 500,
                                                    too_long: '500 characters in post is the maximum allowed.' }
  belongs_to :user, foreign_key: :user_id
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
end
