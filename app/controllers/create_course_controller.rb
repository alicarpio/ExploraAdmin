class CreateCourseController < ApplicationController
  protect_from_forgery except: [:create]

  def create
    logger.debug "Create course params: #{params}"
    # TODO: Parsear los archivos subidos.
    # TODO: Persistir la data a la base de datos.
    redirect_to admin_cursos_informacion_path
  end
end
