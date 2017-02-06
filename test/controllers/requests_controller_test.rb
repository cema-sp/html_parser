require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  describe "GET /requests" do
    subject { get requests_url, as: :json }

    it "returns 200" do
      subject
      response.status.must_equal 200
    end

    it 'returns all requests' do
      subject
      data = JSON.parse(response.body)
      cnt = Request.count

      data.size.must_equal cnt
    end

    it 'returns result within requests' do
      subject
      data = JSON.parse(response.body)
      example_req = data.find { |req| req["id"] == requests(:example).id }
      example_data = example_req["data"]

      example_data.must_equal(results(:example).data)
    end
  end

  describe "POST /requests" do
    let(:url) { 'https://angel.co' }
    let(:params) { { url: url } }

    subject { post requests_url, params: params, as: :json }

    it "returns 201" do
      subject
      response.status.must_equal 201
    end

    it "creates a request" do
      assert_difference('Request.count', 1) do
        subject
      end
    end
  end

  describe "GET /requests/:id" do
    let(:request) { requests(:example) }

    subject { get request_url(request), as: :json }

    it "returns 200" do
      subject
      response.status.must_equal 200
    end

    it 'returns result within requests' do
      subject
      example_req = JSON.parse(response.body)
      example_data = example_req["data"]

      example_data.must_equal(results(:example).data)
    end
  end
end
