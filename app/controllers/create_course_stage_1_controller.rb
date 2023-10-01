class CreateCourseStage1Controller < ApplicationController
  protect_from_forgery except: [ :create ]

  def create
    params = create_course_stage_1_params
    session[:tipo_institucion] = params[:tipo_institucion]
    session[:jornada] = params[:jornada]

    redirect_to admin_create_course_s2_path
  end

  private

  def create_course_stage_1_params
    params.permit(
      :tipo_institucion,
      :jornada
    )
  end
end
