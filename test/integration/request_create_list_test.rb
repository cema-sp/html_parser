require 'test_helper'

class RequestCreateListTest < ActionDispatch::IntegrationTest
  describe "create request and get it by id" do
    let(:url) { 'http://integration-test-url.com' }
    let(:params) { { url: url } }

    let(:do_post) { post requests_url, params: params, as: :json }

    describe "and get requests list" do
      let(:do_get) { get requests_url, as: :json }

      it 'creates a new request' do
        do_get
        req_cnt_before = JSON.parse(response.body).size

        do_post

        do_get
        req_cnt_after = JSON.parse(response.body).size

        req_cnt_after.must_be :>, req_cnt_before
      end
    end

    describe "and get it by id" do
      let(:do_get) { -> (id) { get request_url(id), as: :json } }

      it 'creates a new request' do
        do_post
        new_req_id = JSON.parse(response.body)["id"]

        do_get[new_req_id]

        response.status.must_equal 200
      end
    end
  end
end
