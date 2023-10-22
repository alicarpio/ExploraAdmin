class ModifyEstudiantes < ActiveRecord::Migration[7.0]
  def change
    remove_column :estudiantes, :apellido
    add_column :estudiantes, :nombres, :string
    add_column :estudiantes, :apellidos, :string
    add_column :estudiantes, :correo, :string
  end
end
