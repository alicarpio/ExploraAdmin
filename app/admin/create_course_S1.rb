ActiveAdmin.register_page "Create course S1" do
  menu false

  content title: "Crear curso" do
    tipo_institucion = session[:tipo_institucion]
    jornada = session[:jornada]

    def should_check(session_value, to_be_checked)
      return true if session_value.nil?

      session_value == to_be_checked
    end

    form id: "course-S1", method: "post", action: "/create_course_stage_1" do
      div id: "tipo-institucion" do
        h2 "Escoja el tipo de institución"
        div class: "radio-option" do
          input(
            type: "radio",
            id: "escuela",
            name: "tipo_institucion",
            value: "Escuela",
            checked: should_check(tipo_institucion, "Escuela")
          )
          label "Escuela", for: "escuela"
        end
        div class: "radio-option" do 
          input(
            type: "radio",
            id: "colegio",
            name: "tipo_institucion",
            value: "Colegio",
            checked: should_check(tipo_institucion, "Colegio")
          )
          label "Colegio", for: "colegio"
        end
      end
      div id: "tipo-jornada" do
        h2 "Escoja la jornada"
        div class: "radio-option" do
          input(
            type: "radio", 
            id: "matutino",
            name: "jornada",
            value: "Matutino",
            checked: should_check(jornada, "Matutino")
          )
          label "Matutino" , for: "matutino"
        end
        div class: "radio-option" do
          input(
            type: "radio",
            id: "vespertino",
            name: "jornada",
            value: "Vespertino",
            checked: should_check(jornada, "Vespertino")
          )
          label "Vespertino" , for: "vespertino"
        end
      end

      navigation_buttons(
        back: "/admin/periodos",
        forward:  "/admin/cursos_informacion"
      )
    end
  end
end
