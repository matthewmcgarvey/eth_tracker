require "rails_helper"

RSpec.describe Alchemy::Eth do
  describe "#block_number" do
    it "sends expected request and returns parsed JSON" do
      client = instance_double(Alchemy::Client)
      response = instance_double(Net::HTTPResponse)
      allow(client)
        .to receive(:request)
        .with(method: "eth_blockNumber")
        .and_return(response)
      allow(response).to receive(:body).and_return({foo: "bar"}.to_json)
      eth = Alchemy::Eth.new(client)

      result = eth.block_number

      expect(result).to eq({"foo" => "bar"})
    end
  end

  describe "#get_block_by_number" do
    it "sends expected request and returns parsed JSON" do
      client = instance_double(Alchemy::Client)
      response = instance_double(Net::HTTPResponse)
      allow(client)
        .to receive(:request)
        .with(method: "eth_getBlockByNumber", params: ["123", true])
        .and_return(response)
      allow(response).to receive(:body).and_return({foo: "bar"}.to_json)
      eth = Alchemy::Eth.new(client)

      result = eth.get_block_by_number("123")

      expect(result).to eq({"foo" => "bar"})
    end
  end
end
