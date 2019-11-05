class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  scope :select_followed_ids, ->(id){select(:followed_id).where follower_id: id}
end
