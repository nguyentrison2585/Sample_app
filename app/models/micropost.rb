class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.max_length_post}
  validates :image, content_type: {in: Settings.valid_image_types,
                                   message: I18n.t("valid_format")},
            size: {less_than: Settings.max_size_image.megabytes,
                   message: I18n.t("less_than")}

  scope :order_by_created_at, ->{order created_at: :desc}

  def display_image
    image.variant resize_to_limit: [Settings.post_image_width_limit,
      Settings.post_image_height_limit]
  end
end
