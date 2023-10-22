class Curso < ApplicationRecord
  belongs_to :periodo
  belongs_to :docente
  has_and_belongs_to_many :estudiante
end
