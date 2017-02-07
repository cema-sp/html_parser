require 'test_helper'

class ProcessRequestJobTest < ActiveJob::TestCase
  let(:request) { requests(:new) }

  subject { ProcessRequestJob.perform_now(request.id) }

  describe "when fetch succeedes" do
    let(:response) do
      resp = Minitest::Mock.new

      def resp.body
        "<html><body><h1>Title</h1><a href='URL'>link</a></body></html>"
      end

      resp
    end

    describe "when parsing succeedes" do
      it 'creates a new result' do
        Faraday.stub :get, response do
          assert_difference('Result.count', 1) do
            subject
          end
        end
      end

      it 'sets request state to "success"' do
        Faraday.stub :get, response do
          subject
          request.reload.state.must_equal "success"
        end
      end
    end

    describe "when parsing fails" do
      let(:html) do
        doc = Minitest::Mock.new

        def doc.xpath(*_)
          raise Nokogiri::SyntaxError
        end

        doc
      end

      it 'doesn\'t create a new result' do
        Faraday.stub :get, response do
          Nokogiri::HTML.stub :parse, html do
            assert_difference('Result.count', 0) do
              subject
            end
          end
        end
      end

      it 'sets request state to "fail"' do
        Faraday.stub :get, response do
          Nokogiri::HTML.stub :parse, html do
            subject
            request.reload.state.must_equal "fail"
          end
        end
      end
    end
  end

  describe "when fetch fails" do
    let(:response) do
      resp = Minitest::Mock.new

      def resp.body
        raise Faraday::ConnectionFailed.new('')
      end

      resp
    end

    it 'doesn\'t create a new result' do
      Faraday.stub :get, response do
        assert_difference('Result.count', 0) do
          subject
        end
      end
    end

    it 'sets request state to "fail"' do
      Faraday.stub :get, response do
        subject
        request.reload.state.must_equal "fail"
      end
    end
  end
end
