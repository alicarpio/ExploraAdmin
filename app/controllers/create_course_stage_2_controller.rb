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

  def cargar_estudiantes_desde_archivo
    file = params[:estudiantes_file]
    if file.present?
      xlsx = Roo::Spreadsheet.open(file.path)

      # offset en 5 porque los datos inician en la fila 6
      xlsx.each_row_streaming(offset: 5) do |row|
        cedula = row[3..4][0]
        
        nombre_completo = row[5..8].join(' ').split(' ')
        apellidos = "#{nombre_completo[0]} #{nombre_completo[1]}"
        nombres = "#{nombre_completo[2]} #{nombre_completo[3]}"

        correo = row[9..14][0]

        if cedula.empty? || nombre_completo.empty? || correo.empty?
          next        
        else
          estudiante = Estudiante.new( 
            cedula: cedula, 
            apellidos: apellidos, 
            nombres: nombres, 
            correo: correo
          )

          estudiante.save!
        end

      end
      render json: { message: 'Estudiantes cargados exitosamente' }
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
