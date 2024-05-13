import components/section.{section}
import lustre/attribute.{class}
import lustre/element.{type Element, text}
import lustre/element/html.{div, textarea}

pub fn lab() -> Element(a) {
  section(
    "lab",
    "Lustre Lab",
    text("Try  and Experiment with Lustre Online"),
    div([class("grid grid-cols-1 lg:grid-cols-2 gap-4 w-full")], [
      div([class("editor")], [
        textarea(
          [class("size-full resize-none focus:outline-none p-4")],
          "lustre code",
        ),
      ]),
      div([class("browser")], [
        div([class("p-2 border-b border-b-bright-gray")], [
          div(
            [
              class(
                "bg-bright-gray text-dim-gray text-center rounded-full p-2 text-sm",
              ),
            ],
            [text("http://localhost:3000/index.html")],
          ),
        ]),
      ]),
    ]),
  )
}
