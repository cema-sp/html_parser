require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  let(:request) { requests(:example) }

  it 'should be created' do
    result = Result.new(request_id: request.id, data: { h1: [ 'h', 'h2' ] })

    result.must_be :valid?
  end
end
