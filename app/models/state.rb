class State < ApplicationRecord
  def to_s
    name
  end

  def self.default
    find_by(default: true)
  end
end
