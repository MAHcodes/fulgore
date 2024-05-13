import components/logo.{logo}
import components/nav.{nav}
import components/socials.{socials}
import lustre/attribute.{class, href, id}
import lustre/element.{type Element}
import lustre/element/html.{a, div}

pub fn header() -> Element(a) {
  html.header([id("header"), class("transparent")], [
    div([class("container")], [
      a([href("#top"), class("logo")], [
        logo(
          container_class: "pb-3 pt-1",
          logo_class: "h-10 w-auto object-contain",
        ),
      ]),
      nav(),
      socials(),
    ]),
  ])
}
