# Eth Tracker

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
- `bundle exec sidekiq`

With that, the app should be running and you can go to `localhost:3000` and view the latest Etherium block and transactions.
It should update every minute or so automatically.
