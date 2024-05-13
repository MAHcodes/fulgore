import gleam/string
import lustre/attribute.{type Attribute, class}
import lustre/element.{type Element}
import lustre/element/html.{div, span}

pub fn a(
  attrs: List(Attribute(a)),
  span_class: String,
  children: List(Element(a)),
) -> Element(a) {
  div([class("block mt-1.5 rounded-2xl bg-dark-charcoal")], [
    html.a(attrs, [span([class(string.append("btn ", span_class))], children)]),
  ])
}
