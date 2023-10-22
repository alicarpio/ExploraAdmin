class RemoveNombreFromEstudiantes < ActiveRecord::Migration[7.0]
  def change
    remove_column :estudiantes, :nombre
  end
end
