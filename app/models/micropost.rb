class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  delegate :name, to: :user, prefix: :user

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.max_length_post}
  validates :image, content_type: {in: Settings.valid_image_types,
                                   message: I18n.t("valid_format")},
            size: {less_than: Settings.max_size_image.megabytes,
                   message: I18n.t("less_than")}

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :me_and_following, (lambda do |id|
    where(user_id: Relationship.select_followed_ids(id))
    .or(where user_id: id)
  end)

  def display_image
    image.variant resize_to_limit: Settings.post_image_size
  end
end
