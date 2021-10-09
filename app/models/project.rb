class Project < ApplicationRecord
  validates :name, presence: true

  has_many :tickets, dependent: :delete_all

  def check_name
    if name.include?('black')
      self.errors.add(:name, :invalid)
    end
  end
end
