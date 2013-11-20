class Book < ActiveRecord::Base
  attr_accessor :category_name

  belongs_to :categories
  belongs_to :author
  belongs_to :user

  scope :published_between, lambda { |start_date, end_date| where(["DATE(published_at) > ? AND DATE(published_at) < ?", start_date, end_date]) }

  before_validate :set_category
  before_save :move_to_draft


  def set_category
    self.categories = Category.find_by_name(category_name) if category_name
  end

  def move_to_draft
    self.draft = published_at.blank?
  end

end