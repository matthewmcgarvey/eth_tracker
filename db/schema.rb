# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_17_161132) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "eth_blocks", force: :cascade do |t|
    t.string "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eth_prices", force: :cascade do |t|
    t.decimal "usd_value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eth_transactions", force: :cascade do |t|
    t.string "from", null: false
    t.string "to"
    t.decimal "value", null: false
    t.integer "eth_block_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eth_block_id"], name: "index_eth_transactions_on_eth_block_id"
  end

end
