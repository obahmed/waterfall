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

ActiveRecord::Schema.define(version: 20180118061433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "generations", force: :cascade do |t|
    t.integer  "machine_id"
    t.float    "units_generated"
    t.float    "hours_outage"
    t.date     "generation_date"
    t.string   "comment"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.float    "aux_units_generated"
    t.index ["machine_id"], name: "index_generations_on_machine_id", using: :btree
  end

  create_table "machine_statuses", force: :cascade do |t|
    t.integer  "machine_id"
    t.string   "machine_status"
    t.string   "machine_status_desc"
    t.string   "is_current"
    t.datetime "machine_status_start_dt"
    t.datetime "machine_status_end_dt"
    t.integer  "machine_status_user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "machines", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "generator_capacity"
    t.string   "generator_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "name"
    t.string   "machine_status"
    t.index ["project_id"], name: "index_machines_on_project_id", using: :btree
  end

  create_table "outages", force: :cascade do |t|
    t.date     "outage_dt"
    t.datetime "outage_start_dt"
    t.datetime "outage_end_dt"
    t.string   "outage_reason"
    t.text     "outage_comment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "machine_id"
    t.float    "outage_total_hours"
    t.string   "outage_type"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "num_engines"
    t.decimal  "total_installed_capacity"
    t.string   "location_text"
    t.string   "configuration"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "generations", "machines"
  add_foreign_key "machines", "projects"
end
