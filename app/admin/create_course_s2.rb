ActiveAdmin.register_page "Create course S2" do
  menu false

  class CargarMaterias < Arbre::Component
    builder_method :cargar_materias

    def build(attributes = {})
      super(attributes)

      h2 "Cargar archivo de materias", class: "mb-1"
      div class: "flex justify-center items-end gap-1 mb-1 w-100" do
        div class: "w-16" do
          label "Seleccionar un archivo", for: "materias_file"
          br
          input(
            type: "file", 
            id: "materias_file", 
            name: "materias_file", 
            class: "border rounded p-1 uniform-input w-100 text-md"
          )
        end
        div class: "form-actions" do
            button(
              "Cargar Materias",
              id: "btn_cargar_materias",
              type: "button",
              class: "action-button"
            )
        end
      end
    end
  end

  class AgregarMateria < Arbre::Component
    builder_method :nueva_materia

    def build(attributes = {})
      super(attributes)

      h2 "Agregar una nueva materia", class: "mb-1"
      div class: "flex justify-center items-end gap-1 mb-1 w-100" do
        div class: "w-16" do
          label "Ingrese el nombre de la materia", for: "nueva_materia"
          input(
            id: "nueva_materia", 
            class: "border rounded p-1 uniform-input w-100 text-md"
          )
        end
        div class: "form-actions" do
          button( 
            "Agregar Materia", 
            id: "btn_agregar_materia", 
            type: "button", 
            class: "action-button" 
          )
        end
      end
    end
  end

  content title: "Asignar Materias" do
    form(
      id: "course-S2",
      method: "post",
      action: "/create_course_stage_2",
      enctype: "multipart/form-data") do

      columns do
        column do
          cargar_materias
          input type: "hidden", id: "materias", name: "materias"
          nueva_materia
        end
        column do
          div class: "mt-2" do
            div id: "materias_checkboxes", class: "p-2" do
              h2 "Escoja las materias", class: "mt-1 ml-1"
              (session[:materias_seleccionadas] || []).each_with_index do |materia, i|
                div class: "checkbox-option" do
                  checkbox_id = "#{materia}#{i}" 
                  input(
                    type: "checkbox",
                    id: checkbox_id,
                    name: "materias_seleccionadas[]",
                    value: materia)
                  label materia, for: checkbox_id
                end
              end
            end
          end
        end
      end

      navigation_buttons(
        back: "/admin/create_course_s1",
        forward:  "/create_course_stage_2"
      )

      script do
        raw("
          $(document).ready(function() {
            $('#btn_cargar_materias').click(function() {
              const formData = new FormData();
              formData.append('materias_file', $('#materias_file')[0].files[0]);
              $.ajax({
                url: '/cargar_materias_desde_archivo',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                  if (data.materias) {
                    $('#materias').val(data.materias.join(','));
                    $('#materias_checkboxes').empty();
                    const titulo = $('<h2>Escoja las materias</h2>');
                    $('#materias_checkboxes').append(titulo);
                    data.materias.forEach(function(materia, index) {
                      var checkbox_id = 'materia' + (index + 1);
                      var checkbox_option = $(`
                        <div class=checkbox-option>
                          <input type=checkbox
                                 id=${checkbox_id}
                                 name=\"materias_seleccionadas[]\"
                                 value=${materia} />
                          <label for=${checkbox_id}>${materia}</label>
                        </div>`);
                      checkbox_option.find('input').prop('checked', true);
                      $('#materias_checkboxes').append(checkbox_option);
                    });
                  } else {
                    alert('No se subió ningún archivo');
                  }
                },
                error: function() {
                  alert('Hubo un error al cargar las materias');
                }
              });   
            });

            $('#btn_agregar_materia').click(function() {
              const nueva_materia = $('#nueva_materia').val();
              if (nueva_materia) {
                const checkbox_id = 'materia' + ($('#materias_checkboxes.checkbox-option').length + 1);
                const checkbox_option = $(`
                  <div class=\"checkbox-option\">
                    <input type=checkbox id=${checkbox_id}
                           name=\"materias_seleccionadas[]\" 
                           value=${nueva_materia} />
                    <label for=${checkbox_id}>${nueva_materia}</label>
                  </div>`);
                checkbox_option.find('input').prop('checked', true);
                $('#materias_checkboxes').append(checkbox_option);
                $('#nueva_materia').val('');
              }
            });
          });
        ")
      end
    end
  end
end
