import gleam/list
import lustre/attribute.{class, href, src, target}
import lustre/element.{type Element}
import lustre/element/html.{a, img, li, ul}

type Social {
  Social(src: String, href: String)
}

const socials_list: List(Social) = [
  Social(src: "/discord.svg", href: "https://discord.gg/Fm8Pwmy"),
  Social(src: "/github.svg", href: "https://github.com/lustre-labs/lustre"),
]

fn social(s: Social) -> Element(a) {
  li([], [
    a([href(s.href), class("group"), target("_blank")], [
      img([
        class("size-8 group-hover:scale-110 transition-transform"),
        src(s.src),
      ]),
    ]),
  ])
}

pub fn socials() {
  ul([class("flex gap-4 socials")], list.map(socials_list, social))
}
