module Alchemy
  class Eth
    def initialize(client)
      @client = client
    end

    def block_number
      response = @client.request(method: "eth_blockNumber")
      JSON.parse(response.body)
    end

    def get_block_by_number(block_number)
      response = @client.request(method: "eth_getBlockByNumber", params: [block_number, true])
      JSON.parse(response.body)
    end
  end
end
