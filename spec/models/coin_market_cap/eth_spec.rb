require "rails_helper"

RSpec.describe CoinMarketCap::Eth do
  describe "#latest_price" do
    it "gets latest quote and pulls out price" do
      client = instance_double(CoinMarketCap::Client)
      response = instance_double(Net::HTTPResponse)
      allow(client)
        .to receive(:latest_quote)
        .with(id: CoinMarketCap::Eth::CMC_ETH_ID)
        .and_return(response)
      allow(response).to receive(:body).and_return(quote_response(price: 123))
      eth = CoinMarketCap::Eth.new(client)

      result = eth.latest_price

      expect(result).to eq(123)
    end

    def quote_response(price:)
      {
        data: {
          CoinMarketCap::Eth::CMC_ETH_ID => {
            quote: {
              USD: {
                price: price
              }
            }
          }
        }
      }.to_json
    end
  end
end
