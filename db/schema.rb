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

ActiveRecord::Schema[7.0].define(version: 2023_09_28_181302) do
  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "Alexander", null: false
    t.string "last_name", default: "Goussas", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "cursos", force: :cascade do |t|
    t.integer "periodo_id", null: false
    t.integer "docente_id"
    t.string "tipo_institucion"
    t.string "jornada"
    t.string "paralelo"
    t.string "portada"
    t.string "color"
    t.string "materia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["docente_id"], name: "index_cursos_on_docente_id"
    t.index ["periodo_id"], name: "index_cursos_on_periodo_id"
  end

  create_table "cursos_estudiantes", id: false, force: :cascade do |t|
    t.integer "estudiante_id", null: false
    t.integer "curso_id", null: false
  end

  create_table "docentes", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "apellido", null: false
    t.string "cedula"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estudiantes", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "apellido", null: false
    t.string "cedula"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periodos", force: :cascade do |t|
    t.datetime "fecha_inicio", null: false
    t.datetime "fecha_fin", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.integer "canvas_term_id"
  end

  add_foreign_key "cursos", "docentes"
  add_foreign_key "cursos", "periodos"
end
