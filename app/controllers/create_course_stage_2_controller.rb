class CreateCourseStage2Controller < ApplicationController
  protect_from_forgery except: [ :create, :cargar_materias_desde_archivo ]

  def create
    params = create_course_stage_2_params
    logger.debug "Got materias: #{params}"
    session[:materias_seleccionadas] = params[:materias_seleccionadas]
    redirect_to admin_cursos_informacion_path
  end

  def cargar_materias_desde_archivo
    file = params[:materias_file]
    if file.present?
      xlsx   = Roo::Spreadsheet.open(file.path)
      sheet  = xlsx.sheet(0)
      header = sheet.row(1)

      materia_column = header.index('materia')
      render json: {materias: []} if materia_column.nil?

      materias = sheet.each_row_streaming(offset: 1)
        .collect { |row| row[materia_column].value }
        .reduce([]) { |materias, materia| materias << materia }

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
