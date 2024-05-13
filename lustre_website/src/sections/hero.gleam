import components/logo.{logo}
import components/ui/a.{a}
import lustre/attribute.{class, href, target}
import lustre/element.{type Element, text}
import lustre/element/html.{div, h2, p, section}

type Link {
  Link(text: String, href: String, target: String)
}

type Hero {
  Hero(title: String, sub_title: String, primary_cta: Link, secondary_cta: Link)
}

const content = Hero(
  title: "✨ Make your frontend shine ✨",
  sub_title: "A framework for building Web apps in Gleam!",
  primary_cta: Link(text: "Try Lustre", href: "#lab", target: "_self"),
  secondary_cta: Link(
    text: "Reference",
    href: "https://hexdocs.pm/lustre",
    target: "_blank",
  ),
)

pub fn hero() -> Element(a) {
  section([class("flex flex-col items-center justify-center gap-8")], [
    logo(
      container_class: "pl-4 md:pl-20 pb-4 max-w-full",
      logo_class: "h-40 w-auto",
    ),
    div([class("flex flex-col gap-4 text-center")], [
      h2([class("font-semibold text-md")], [text(content.title)]),
      p([class("text-base")], [text(content.sub_title)]),
    ]),
    div([class("flex flex-col md:flex-row gap-2 w-full md:w-auto")], [
      a(
        [href(content.primary_cta.href), target(content.primary_cta.target)],
        "primary",
        [text(content.primary_cta.text)],
      ),
      a(
        [href(content.secondary_cta.href), target(content.secondary_cta.target)],
        "secondary",
        [text(content.secondary_cta.text)],
      ),
    ]),
  ])
}
