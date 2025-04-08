class Article < ApplicationRecord
  # association
  has_many :comments, dependent: :destroy

  # validation
  with_options presence: true do
    validates :title
    validates :content, length: { minimum: 10 }
  end

  # method
  def comments_count
    comments.count
  end
end
