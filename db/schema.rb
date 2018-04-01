# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180227010802) do

  create_table "contests", force: :cascade do |t|
    t.string   "name"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "url"
    t.date     "startDate"
    t.date     "endDate"
    t.decimal  "value"
    t.text     "script"
    t.text     "recomendations"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "nombre"
    t.string   "apellido"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "voices", force: :cascade do |t|
    t.integer  "contest_id"
    t.string   "email"
    t.string   "name"
    t.string   "surname"
    t.date     "upload_date"
    t.integer  "status_id"
    t.string   "original_file_file_name"
    t.string   "original_file_content_type"
    t.integer  "original_file_file_size"
    t.datetime "original_file_updated_at"
    t.string   "converted_file_file_name"
    t.string   "converted_file_content_type"
    t.integer  "converted_file_file_size"
    t.datetime "converted_file_updated_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "estado"
  end

end
