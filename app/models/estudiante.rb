class Estudiante < ApplicationRecord
  validates :nombres, presence: true
  validates :apellidos, presence: true
  validates :cedula, presence: true
  validates :correo, presence: true
  
  has_and_belongs_to_many :cursos
end