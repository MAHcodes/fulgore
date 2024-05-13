import components/section.{section}
import gleam/list
import lustre/attribute.{class, src}
import lustre/element.{type Element, text}
import lustre/element/html.{h3, img, li, p, ul}

type Feature {
  Feature(icon_src: String, title: String, description: String)
}

const content: List(Feature) = [
  Feature(
    icon_src: "/sparkles.svg",
    title: "Declarative, Functional API",
    description: "A declarative, functional API for constructing HTML. No templates, no macros, just Gleam.",
  ),
  Feature(
    icon_src: "/compass.svg",
    title: "Erlang and Elm-Inspired Architecture",
    description: "An Erlang and Elm-inspired architecture for managing state.",
  ),
  Feature(
    icon_src: "/test-tube.svg",
    title: "Managed Side Effects",
    description: "Managed side effects for predictable, testable code.",
  ),
  Feature(
    icon_src: "/globe.svg",
    title: "Universal Components",
    description: "Universal components. Write once, run anywhere. Elm meets Phoenix LiveView.",
  ),
  Feature(
    icon_src: "/magic-wand.svg",
    title: "Batteries-Included CLI",
    description: "A batteries-included CLI that makes scaffolding and building apps a breeze.",
  ),
  Feature(
    icon_src: "/high-voltage.svg",
    title: "Server-Side Rendering",
    description: "Server-side rendering for static HTML templating.",
  ),
]

fn feature(feat: Feature) -> Element(a) {
  li(
    [
      class(
        "flex flex-col items-center text-center gap-3 bg-white rounded-2xl px-6 py-12",
      ),
    ],
    [
      img([src(feat.icon_src), class("size-16 mb-4")]),
      h3([class("text-base font-semibold")], [text(feat.title)]),
      p([class("text-dim-gray text-sm max-w-[75%]")], [text(feat.description)]),
    ],
  )
}

pub fn features() -> Element(a) {
  section(
    "features",
    "Features",
    text("Frontend development has never been so Gleamy ✨"),
    ul(
      [class("grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4")],
      list.map(content, feature),
    ),
  )
}
