class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: 'User'

  validates :text, presence: true

  scope :ordered, ->{order(created_at: :asc)}
end
