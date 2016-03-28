class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :content, length: {
    minimum: 2,
    maximum: 500,
    too_short: 'sorry, your comment is too short',
    too_long: 'sorry, your comment is too long'
  }

end
