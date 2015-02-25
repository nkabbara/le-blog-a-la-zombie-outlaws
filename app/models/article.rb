class Article < ActiveRecord::Base
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }

  #We need to use lambda in to delay execution until the call takes place.
  scope :todays, -> { where(["created_at > ?", Date.today.at_beginning_of_day]) }
end
