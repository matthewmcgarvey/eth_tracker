require "rails_helper"

RSpec.describe Alchemy::Client do
  describe "#request" do
    it "makes request with passed method and params" do
      stub_request(:post, "https://eth-mainnet.alchemyapi.io/v2/abc123")
        .with(body: {
          id: 0,
          jsonrpc: "2.0",
          method: "foo_bar",
          params: [1]
        }).to_return(body: "RESPONSE_BODY", status: 200)
      client = Alchemy::Client.new(api_key: "abc123")

      response = client.request(method: "foo_bar", params: [1])

      expect(response.body).to eq("RESPONSE_BODY")
    end

    it "raises error if not 2xx response" do
      stub_request(:post, "https://eth-mainnet.alchemyapi.io/v2/abc123")
        .to_return(status: 400)
      client = Alchemy::Client.new(api_key: "abc123")

      expect { client.request(method: "foo_bar") }
        .to raise_error("unexpected response from Alchemy: 400")
    end
  end
end
