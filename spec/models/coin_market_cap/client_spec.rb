require "rails_helper"

RSpec.describe CoinMarketCap::Client do
  describe "#latest_quote" do
    it "makes expected request" do
      stub_request(:get, "https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest")
        .with(query: {id: 123}, headers: {"X-CMC_PRO_API_KEY" => "abc123"})
        .to_return(body: "RESPONSE_BODY", status: 200)
      client = CoinMarketCap::Client.new(api_key: "abc123")

      response = client.latest_quote(id: 123)

      expect(response.body).to eq("RESPONSE_BODY")
    end

    it "raises error if not 2xx response" do
      stub_request(:get, "https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest")
        .with(query: {id: 123})
        .to_return(status: 400)
      client = CoinMarketCap::Client.new(api_key: "abc123")

      expect { client.latest_quote(id: 123) }
        .to raise_error("unexpected response from CoinMarketCap: 400")
    end
  end
end
