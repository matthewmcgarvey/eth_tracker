require "rails_helper"

RSpec.describe FetchLatestEthBlock do
  describe "#perform" do
    it "returns early if latest block number is already stored" do
      alchemy_eth = instance_double(Alchemy::Eth)
      allow(Alchemy).to receive(:eth).and_return(alchemy_eth)
      allow(alchemy_eth).to receive(:block_number).and_return({'result' => 'abc123'})
      expect(alchemy_eth).not_to receive(:get_block_by_number)
      EthBlock.create!(number: "abc123")

      FetchLatestEthBlock.new.perform
    end

    it "fetchs block data, stores it, and broadcasts websocket notification" do
      EthPrice.create!(usd_value: 123)
      alchemy_eth = instance_double(Alchemy::Eth)
      allow(Alchemy).to receive(:eth).and_return(alchemy_eth)
      allow(alchemy_eth).to receive(:block_number).and_return({'result' => 'abc123'})
      allow(alchemy_eth)
        .to receive(:get_block_by_number)
        .and_return({
          "result" => {
            "transactions" => [
              {
                "from" => "FROM",
                "to" => "TO",
                "value" => "0x09184e72a000"
              }
            ]
          }
        })
      expect_any_instance_of(EthBlock).to receive(:broadcast_replace_to)

      FetchLatestEthBlock.new.perform 

      eth_block = EthBlock.find_by!(number: "abc123")
      expect(eth_block.eth_transactions.size).to eq(1)
      expect(eth_block.eth_transactions.first).to have_attributes(
        from: "FROM",
        to: "TO",
        value: 0.00001
      )
    end
  end
end
