import components/section.{section}
import gleam/int
import gleam/list
import lustre/attribute.{alt, class, href, src, target}
import lustre/element.{type Element, text}
import lustre/element/html.{a, div, img, li, span, ul}

pub type User {
  User(login: String, avatar_url: String, html_url: String, contributions: Int)
}

fn contributor(user: User) -> Element(a) {
  li([class("relative group")], [
    a([href(user.html_url), target("_blank")], [
      img([
        class(
          "group-hover:outline outline-4 outline-dark-charcoal size-16 rounded-full group-hover:scale-110 transition-all duration-300",
        ),
        src(user.avatar_url),
        alt(user.login),
      ]),
    ]),
    div([class("tooltip")], [
      div([], [
        span([class("text-bright-gray text-sm")], [text("@")]),
        span([class("font-semibold")], [text(user.login)]),
      ]),
      div([], [
        span([class("font-semibold")], [text(int.to_string(user.contributions))]),
        span([class("text-bright-gray text-sm")], [
          text(get_contributions_label(user.contributions)),
        ]),
      ]),
    ]),
  ])
}

fn get_contributions_label(count: Int) -> String {
  " commit"
  <> case count {
    1 -> ""
    _ -> "s"
  }
}

pub fn contributors(users: List(User)) -> Element(a) {
  section(
    "contributors",
    "Lustre Contributors",
    text(""),
    ul(
      [class("flex flex-wrap gap-4 justify-center")],
      list.map(users, contributor),
    ),
  )
}
