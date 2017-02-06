require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  it 'could be created' do
    request = Request.new(url: 'http://example.com')

    request.must_be :valid?
  end
end
