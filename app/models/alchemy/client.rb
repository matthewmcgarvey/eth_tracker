require 'net/http'

module Alchemy
  class Client
    def initialize(api_key = ENV["ALCHEMY_API_KEY"])
      @api_key = api_key
    end

    def request(method:, params: [], id: 0)
      url = URI("https://eth-mainnet.alchemyapi.io/v2/#{@api_key}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["content-type"] = 'application/json'
      request.body = {
        id: id,
        jsonrpc: "2.0",
        method: method,
        params: params
      }.to_json

      response = http.request(request)
      raise "unexpected response from Alchemy: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

      response
    end
  end
end
