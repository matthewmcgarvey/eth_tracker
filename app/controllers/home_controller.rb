class HomeController < ApplicationController
  def index
    @eth_price = EthPrice.fetch_latest
    @eth_block = EthBlock.last
  end
end
