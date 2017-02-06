class Request < ApplicationRecord
  STATES = %w(pending success fail)

  has_one :result

  validates :url, presence: true
  validates :state, presence: true
end
