ActiveAdmin.register_page "Cursos informacion" do
  menu false

  # Define la lista de materias fuera del bloque content
  materias = [
    { id: 1, name: "Ciencias" },
    { id: 2, name: "Matematica" },
    { id: 3, name: "Fisica" },
    { id: 4, name: "Historia" },
  ]
  estudiantes = [
    { cedula: "0987546474", name: "Pepe Valdez" },
    { cedula: "0987546448", name: "Danilo INtriago" },
    { cedula: "0987546452", name: "JOsselyn Marcada" },
    { cedula: "0987548622", name: "Kristell Jacome" },
  ]

  content title: "Cursos" do
    h1 "Unidad Educativa #{session[:institution]}"
    h2 "Noveno"
    
    tabs do
      # Itera sobre las materias y crea una pestaña para cada una
      materias.each do |materia|
        tab materia[:name] do
          div class: "container" do
            div class: "cursosinfo-form" do
              form method: "post", action  do
                div class: "form-content" do
                  
                  columns do
                    column do
                      div class: "fields-section" do
                        div class: "field" do
                          label "Materia: ", for: "materia"
                          input id: "materia", type: "text", name: "materia", value: materia[:name], disabled: true
                        end

                        div class: "field" do
                          label "Paralelo: ", for: "paralelo"
                          input id: "paralelo", type: "text", name: "paralelo", value: "Noveno", disabled: true
                        end

                        div class: "field" do
                          label "Tipo Institución: ", for: "institucion"
                          input id: "institucion", type: "text", name: "institucion", value: "#{session[:tipo_institucion]}", disabled: true
                        end
                        div class: "field" do
                          label "Jornada: ", for: "jornada"
                          input id: "jornada", type: "text", name: "jornada", value: "#{session[:jornada]}", disabled: true
                        end
                        div class: "field" do
                          label "Portada: ", for: "imagen"
                          input id: "imagen", type: "file", name: "imagen", placeholder: "Seleccione una imagen"
                        end
                        div class: "field" do
                          label "Color: ", for: "color"
                          input id: "color", type: "color", name: "color", placeholder: "Seleccione un color"
                        end
                        div class: "field" do
                          label "Docente: ", for: "docente"
                          input id: "docente", type: "text", name: "docente", value: "docente", disabled: true
                        end
                        div class: "field" do
                          label "Estudiantes: ", for: "file"
                          input id: "file", type: "file", name: "file", placeholder: "Subir archivo estudiantes"
                        end
                      end
                    end
                    
                  end

                  div class: "form-actions" do
                    input(
                      type: "submit",
                      value: "Guardar",
                      class: "action-button"
                    )
                  end
                  
                end
              end
            end
          end
        end
      end
    end

    # Agrega la navegación de regreso
    navigation_buttons back: "/admin/create_course_s1"
  end
end
