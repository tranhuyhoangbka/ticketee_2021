class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: 'User'
  belongs_to :state, optional: true
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :watchers, join_table: 'ticket_watchers',
    class_name: 'User'
  has_and_belongs_to_many :tags

  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 10, allow_blank: true}

  has_many_attached :attachments

  searcher do
    label :tag, from: :tags, field: "name"
  end

  before_create :assign_default_state
  after_create :subscribe_author_to_ticket

  private
  def assign_default_state
    self.state ||= State.default
  end

  def subscribe_author_to_ticket
    self.watchers << author
  end
end
