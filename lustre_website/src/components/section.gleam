import lustre/attribute.{class}
import lustre/element.{type Element, text}
import lustre/element/html.{div, h3}

pub fn section(
  id: String,
  title: String,
  sub: Element(a),
  children: Element(a),
) -> Element(a) {
  html.section([class("flex flex-col items-center gap-4")], [
    h3([class("title"), attribute.id(id)], [text(title)]),
    div([class("text-base font-medium mb-8 text-center")], [sub]),
    children,
  ])
}
