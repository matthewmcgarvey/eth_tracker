require "faye/websocket"
require "eventmachine"

MY_ALCHEMY_ID = 1896

desc "live ethereum block updates"
task "alchemy:listen" => :environment do
  EM.run do
    api_key = ENV["ALCHEMY_API_KEY"]
    ws = Faye::WebSocket::Client.new("wss://eth-mainnet.alchemyapi.io/v2/#{api_key}", [], {})
    subscription_id = nil

    ws.on :message do |event|
      json = JSON.parse(event.data)
      # first message should be the subscription id
      # check subscription id after that to only handle my messages
      if subscription_id.nil? && json["id"] == MY_ALCHEMY_ID
        subscription_id = json["result"]
      elsif json.dig("params", "subscription") == subscription_id
        block_number = json.dig("params", "result", "number")
        FindOrLoadEthBlock.new.perform(block_number) if block_number
      end
    end

    ws.on :close do |event|
      puts [:close, event.code, event.reason]
      ws = nil
    end

    ws.on :error do |event|
      puts [:error, event.code, event.reason]
      ws = nil
    end

    ws.send({
      jsonrpc: "2.0",
      id: MY_ALCHEMY_ID,
      method: "eth_subscribe",
      params: ["newHeads"]
    }.to_json)
  end
end
