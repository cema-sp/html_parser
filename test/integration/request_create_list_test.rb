require 'test_helper'

class RequestCreateListTest < ActionDispatch::IntegrationTest
  describe "Create request" do
    let(:params) { { url: 'http://example.com' } }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    describe "with valid params" do
      it 'returns request id' do
        post '/requests', params: params, headers: headers
        assert_request :success
      end

      describe "Listing requests" do
        it 'returns the request' do
          get '/requests'
          assert_request :success
        end
      end
    end

    describe "with invalid params" do
      let(:params) { { url: 'http://example.com' } }

      it 'returns error message' do
        post '/requests', params: params, headers: headers
        assert_request :fail
      end
    end
  end
end
