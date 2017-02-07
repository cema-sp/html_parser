class ProcessRequestJob < ApplicationJob
  queue_as :default

  def perform(request_id)
    ActiveRecord::Base.connection_pool.with_connection do
      begin
        request = Request.find(request_id)
        response = Faraday.get request.url
        html = Nokogiri::HTML.parse(response.body)

        data = find_tags(html)

        ActiveRecord::Base.transaction do
          request.create_result!(data: data)
          request.update(state: "success")
        end

      rescue Faraday::ClientError, Nokogiri::SyntaxError
        request.update(state: "fail")
      end
    end
  end

  private

  def find_tags(html)
    h1 = html.xpath('//h1').map(&:inner_text)
    h2 = html.xpath('//h2').map(&:inner_text)
    h3 = html.xpath('//h3').map(&:inner_text)

    urls = html.xpath('//a/@href').map(&:value)

    {
      h1: h1,
      h2: h2,
      h3: h3,
      urls: urls
    }
  end
end
