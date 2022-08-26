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

ActiveRecord::Schema[7.0].define(version: 2022_08_25_051107) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "auctions", force: :cascade do |t|
    t.bigint "shoe_id", null: false
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status", default: "Close"
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shoe_id"], name: "index_auctions_on_shoe_id"
  end

  create_table "bids", force: :cascade do |t|
    t.bigint "auction_id", null: false
    t.bigint "user_id", null: false
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auction_id"], name: "index_bids_on_auction_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "shoes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "size"
    t.text "condition"
    t.string "color"
    t.string "model"
    t.string "brand"
    t.float "starting_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shoes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "contact_number"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "auctions", "shoes"
  add_foreign_key "bids", "auctions"
  add_foreign_key "bids", "users"
  add_foreign_key "shoes", "users"
end
