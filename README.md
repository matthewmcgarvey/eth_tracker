# Eth Tracker

This is a Ruby on Rails application that provides a live overview of Ethereum blocks as they are added to the chain.

I used a websocket client for updating on new ethereum blocks and [Turbo](https://turbo.hotwired.dev/) for automatically updating the website UI.

Ethereum prices are updated every 10 minutes or so.

It is deployed to [Fly.io](https://fly.io/).

## Points of interest

- [HomeController#index](./app/controllers/home_controller.rb:2) is the one endpoint that shows the latest block with the latest Ethereum USD price
- [EthBlock](./app/models/eth_block.rb) is the model that stores the block numbers
- [EthTransaction](./app/models/eth_transaction.rb) is where transaction data is stored
- [EthPrice](./app/models/eth_price.rb) holds ethereum prices
- [Alchemy::Client](./app/models/alchemy/client.rb) is where the integration for HTTP requests with Alchemy lives
- [CoinMarketCap::Client](./app/models/coin_market_cap/client.rb) is the CoinMarketCap HTTP integration (for ethereum prices)
- [FindOrLoadEthBlock](./app/jobs/find_or_load_eth_block.rb) loads block data from Alchemy and updates clients with the latest data
- [alchemy:listen](./lib/tasks/alchemy.rake) CLI command, has Alchemy websocket code for updating when blocks are added to the chain

## Running this application

You will need to have these installed and working/running

- Ruby 3.2.1
- Redis
- PostgreSQL

You need to have a .env file in the root of the project that looks like this but with actual API keys

```env
ALCHEMY_API_KEY=ALCHEMY_API_KEY_HERE
COIN_MARKET_CAP_API_KEY=COIN_MARKET_CAP_API_KEY_HERE
```

Then run `bundle install` to install dependencies.

Before you can run the app, you need to set up the database. Run `bin/rails db:create db:migrate`.

Now you should be able to run these two commands in two different terminals

- `bin/rails s`
- `bin/rails alchemy:listen`

With that, the app should be running and you can go to `localhost:3000` and view the latest Etherium block and transactions.
It should update automatically whenever a new ethereum block is added to the chain.
