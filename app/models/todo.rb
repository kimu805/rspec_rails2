class Todo < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :description, length: { minimum: 10, allow_blank: true }
  end
end
