class Post < ActiveRecord::Base
  validates :image, presence: true
  validates :user_id, presence: true
  belongs_to :user

  has_attached_file :image, styles: { medium: "640px" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  has_many :comments, dependent: :destroy
end
