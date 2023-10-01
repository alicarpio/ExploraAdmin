class CreateCourseStage2Controller < ApplicationController
  protect_from_forgery except: [ :create, :cargar_materias_desde_archivo ]

  def create
    puts params.inspect
    params = create_course_stage_2_params
    session[:materias_seleccionadas] = params[:materias_seleccionadas]
    redirect_to admin_cursos_informacion_path
  end

  def cargar_materias_desde_archivo
    file = params[:materias_file]
    if file.present?
      xlsx = Roo::Spreadsheet.open(file.path)
      sheet = xlsx.sheet(0)

      materias = []
      header = sheet.row(1)
      materia_column = header.index('materia')

      if materia_column.nil?
        raise "No se encontró la columna 'Materia' en el archivo"
      end

      sheet.each_row_streaming(offset: 2) do |row|
        materias << row[materia_column].value
      end
      puts "Materias1223: #{materias}"
      render json: { materias: materias }
    else
      render json: { error: 'No se subió ningún archivo' }, status: 400
    end
  end

  private

  def create_course_stage_2_params
    params.permit(
      :materias,
      :materias_file,
      materias_seleccionadas: []
    )
  end
end
