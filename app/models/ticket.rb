class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: 'User'
  belongs_to :state, optional: true
  has_many :comments, dependent: :destroy
  has_belongs_to_many :watchers, join_table: 'ticket_watchers',
    class_name: 'User'

  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 10, allow_blank: true}

  has_many_attached :attachments

  before_create :assign_default_state

  private
  def assign_default_state
    self.state ||= State.default
  end
end
