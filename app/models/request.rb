class Request < ApplicationRecord
  STATES = %w(pending success fail)

  has_many :results

  def result
    results.last
  end
end
