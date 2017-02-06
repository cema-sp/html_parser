require 'test_helper'

class RequestCreateListTest < ActionDispatch::IntegrationTest
  describe "create request" do
    let(:url) { 'http://integration-test-url.com' }
    let(:params) { { url: url } }

    let(:do_post) { post requests_url, params: params, as: :json }

    describe "with valid params" do
      it 'returns request id' do
        do_post
        req = JSON.parse(response.body)

        req["id"].wont_be_nil
      end

      describe "and listing requests" do
        let(:do_get) { get requests_url, as: :json }

        before { do_post }

        it 'returns the request' do
          do_get
          reqs = JSON.parse(response.body)
          req = reqs.find { |r| r["url"] == url }

          req.wont_be_nil
        end
      end
    end

    describe "with invalid params" do
      let(:params) { {} }

      it 'returns error message' do
        do_post

        response.status.wont_equal 200

        resp = JSON.parse(response.body)

        resp["url"].wont_be_nil
      end
    end
  end
end
