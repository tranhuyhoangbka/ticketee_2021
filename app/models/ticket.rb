class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 10, allow_blank: true}

  has_many_attached :attachments
end
