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

ActiveRecord::Schema[7.2].define(version: 2024_11_17_184347) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.string "address", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_buildings_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_field_configurations", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "field_name", null: false
    t.integer "field_type", null: false, comment: "0: number, 1: freeform, 2: enum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_custom_field_configurations_on_client_id"
  end

  create_table "custom_field_values", force: :cascade do |t|
    t.bigint "building_id", null: false
    t.bigint "custom_field_configuration_id", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_custom_field_values_on_building_id"
    t.index ["custom_field_configuration_id"], name: "index_custom_field_values_on_custom_field_configuration_id"
  end

  add_foreign_key "buildings", "clients"
  add_foreign_key "custom_field_configurations", "clients"
  add_foreign_key "custom_field_values", "buildings"
  add_foreign_key "custom_field_values", "custom_field_configurations"
end
