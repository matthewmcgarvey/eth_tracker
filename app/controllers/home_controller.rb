class HomeController < ApplicationController
  def index
    @eth_block = EthBlock.find(1)
  end
end
