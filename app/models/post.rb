class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
  validates :body, presence: true, length: { minimum: 50 }
  
  validate :image_type

  def image_url
    image.attached? ? image.url : nil
  end

  private

  def image_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/gif))
      errors.add(:image, 'must be a JPEG, PNG, GIF')
    end
  end
end
