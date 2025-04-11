class Todo < ApplicationRecord
  with_option presence: true do
    validates :title
    validates :description, length: { minimum: 10 }
  end
end
