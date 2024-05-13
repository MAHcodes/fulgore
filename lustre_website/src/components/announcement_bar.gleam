import lustre/attribute.{class, href, id}
import lustre/element.{type Element, text}
import lustre/element/html.{a, div, p}

type Link {
  Link(text: String, url: String)
}

type Announcement {
  Announcement(content: String, link: Link)
}

const content = Announcement(
  content: "Lustre v4.0.0 released! 🎉",
  link: Link(text: "What's new?", url: "https://github.com/lustre-labs/lustre"),
)

pub fn announcement_bar() -> Element(a) {
  div(
    [
      id("announcement_bar"),
      class(
        "bg-white flex items-center gap-2 py-2 px-4 justify-center text-sm font-semibold",
      ),
    ],
    [
      p([class("text-sm")], [text(content.content)]),
      a([class("underline underline-offset-2"), href(content.link.url)], [
        text(content.link.text),
      ]),
    ],
  )
}
