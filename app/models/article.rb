class Article < ApplicationRecord
  # validation
  with_options presence: true do
    validates :title
    validates :content, length: { minimum: 10 }
  end
end
