class Book < ActiveRecord::Base
  belongs_to :categories
  belongs_to :authors

  scope :published_between, lambda { |start_date, end_date| where(["DATE(published_at) > ? AND DATE(published_at) < ?", start_date, end_date]) }

end