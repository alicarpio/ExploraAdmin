class CreateCourseStage1Controller < ApplicationController
  protect_from_forgery except: [ :create ]


  def create
    params = create_course_stage_1_params
    session[:tipo_institucion] = params[:tipo_institucion]
    session[:jornada] = params[:jornada]

    session[:materias] = subjects_by_institution_type(params[:tipo_institucion])
    session[:materias_seleccionadas] = session[:materias]

    session[:niveles] = course_levels_by_institution_type(params[:tipo_institucion])

    puts "Tipo de institucion: #{session[:tipo_institucion]}"
    puts "Jornada: #{session[:jornada]}"
    puts "Cursos: #{session[:materias]}"
    puts "Niveles: #{session[:niveles]}"

    redirect_to admin_create_course_s2_path
  end

  private

  def create_course_stage_1_params
    params.permit(
      :tipo_institucion,
      :jornada
    )
  end

  def course_levels_by_institution_type(institution_type)
    case institution_type.to_s.downcase
    when "escuela"
      [
        "1° Básico",
        "2° Básico",
        "3° Básico",
        "4° Básico",
        "5° Básico",
        "6° Básico",
        "7° Básico",
      ]
    when "colegio"
      [
        "8° Curso",
        "9° Curso",
        "10° Curso",
        "1° Bachillerato",
        "2° Bachillerato",
        "3° Bachillerato",
      ]
    end
  end

  def subjects_by_institution_type(institution_type)
    case institution_type.to_s.downcase
    when "escuela"
      [
        "Matemáticas",
        "Ciencias",
        "Lenguaje",
        "Inglés",
        "Artes",
        "Educación Física",
      ]
    when "colegio"
      [
        "Matemáticas",
        "Contabilidad",
        "Ciencias",
        "Literatura",
        "Historia",
        "Inglés",
        "Artes",
        "Educación Física",
      ]
    end
  end
end
