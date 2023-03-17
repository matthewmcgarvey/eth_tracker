require 'net/http'
require 'net/http'

module CoinMarketCap
  class Client
    def initialize(api_key: ENV["COIN_MARKET_CAP_API_KEY"])
      @api_key = api_key
    end

    def latest_quote(id:)
      url = URI("https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest")
      url.query = URI.encode_www_form(id: id)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = "application/json"
      request["X-CMC_PRO_API_KEY"] = @api_key

      response = http.request(request)
      raise "unexpected response from CoinMarketCap: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

      response
    end
  end
end
