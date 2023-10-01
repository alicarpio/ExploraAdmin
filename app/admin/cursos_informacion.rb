ActiveAdmin.register_page "Cursos Informacion" do
  menu false

  class ReadonlyInput < Arbre::Component
    builder_method :readonly_input

    def build(label_name, input_name, input_value, attributes = {})
      super(attributes)

      div class: "field" do
        label label_name, for: input_name
        input(
          id: input_name,
          type: "text",
          name: input_name,
          value: input_value,
          readonly: true)
      end
    end
  end

  content title: "Crear Curso" do
    h1 "Unidad Educativa #{session[:institution]}"
    tabs do
      session[:materias_seleccionadas].each do |materia|
        tab materia do
          form(
            method: "post",
            action: "/create_course",
            enctype: "multipart/form-data",
            class: "cursosinfo-form") do
            div class: "fields-section" do
              readonly_input "Materia", "materia", materia
              # TODO: ¿Esto de dónde se saca?
              readonly_input "Paralelo", "paralelo", "Noveno"
              readonly_input "Tipo Institución", "institucion", session[:tipo_institucion]
              readonly_input "Jornada", "jornada", session[:jornada]
              div class: "field" do
                label "Portada: ", for: "imagen"
                input id: "imagen", type: "file", name: "imagen"
              end
              div class: "field" do
                label "Color: ", for: "color"
                input id: "color", type: "color", name: "color"
              end
              # TODO: Esto no debería estar deshabilitado.
              readonly_input "Docente", "docente", "docente"
              div class: "field" do
                label "Estudiantes: ", for: "estudiantes"
                input id: "estudiantes", type: "file", name: "estudiantes"
              end
            end

            div class: "form-actions" do
              input(
                type: "submit",
                value: "Crear Curso(s)",
                class: "action-button"
              )
            end
          end
        end
      end
    end

    navigation_buttons back: "/admin/create_course_s2"
  end
end
