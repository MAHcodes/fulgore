import gleam/list
import lustre/attribute.{class, href, target}
import lustre/element.{type Element, text}
import lustre/element/html.{a, li, ul}

pub type NavItem {
  NavItem(text: String, href: String, target: String)
}

const content: List(NavItem) = [
  NavItem(text: "Features", href: "#features", target: "_self"),
  NavItem(text: "Support", href: "#support", target: "_self"),
  NavItem(text: "Try Lustre", href: "#lab", target: "_self"),
]

pub fn nav_item(item: NavItem) -> Element(a) {
  li([], [
    a(
      [
        href(item.href),
        target(item.target),
        class("hover:underline underline-offset-4"),
      ],
      [text(item.text)],
    ),
  ])
}

pub fn nav() -> Element(a) {
  html.nav([class("nav")], [
    ul(
      [class("flex gap-4 justify-between md:justify-center")],
      list.map(content, nav_item),
    ),
  ])
}
