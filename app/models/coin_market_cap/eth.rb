module CoinMarketCap
  class Eth
    CMC_ETH_ID = 1027

    def initialize(client)
      @client = client
    end

    def latest_price
      response = @client.latest_quote(id: CMC_ETH_ID)
      json = JSON.parse(response.body)
      json.dig("data", CMC_ETH_ID.to_s, "quote", "USD", "price")
    end
  end
end
