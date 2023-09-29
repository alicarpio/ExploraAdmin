class NavigationButtons < Arbre::Component
  builder_method :navigation_buttons

  def build(attributes = {})
    super(attributes)

    back = attributes[:back]
    forward = attributes[:forward]

    div class: "navigation-buttons" do
      if back 
        a "Atrás", href: back, class: "atras"
      end
      if forward
        # NOTE: For this to work the component needs to be used inside a form
        # with the appropriate action set.
        #
        # NOTE: You don't need to provide a path here because the path is
        # already given in the form action. You only need to provide a truthy
        # value.
        button "Siguiente", class: "siguiente"
      end
    end
  end
end
