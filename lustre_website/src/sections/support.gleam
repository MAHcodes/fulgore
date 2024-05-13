import components/section.{section}
import gleam/int
import lustre/attribute.{class, href, src, target}
import lustre/element.{type Element, text}
import lustre/element/html.{a, div, img, p, span}

pub fn support(stargazers_count: Int) -> Element(a) {
  section(
    "support",
    "Support Lustre",
    p([class("max-w-[80ch]")], [
      span([], [text("Lustre is proudly open source under the permissive ")]),
      a(
        [
          class("underline underline-offset-2"),
          href("https://github.com/lustre-labs/lustre/blob/main/LICENSE"),
        ],
        [text("MIT license")],
      ),
      span([], [text(", with its source code freely available on ")]),
      a(
        [
          class("underline underline-offset-2"),
          href("https://github.com/lustre-labs/lustre"),
        ],
        [text("GitHub")],
      ),
      span([], [
        text(
          " for anyone to contribute or improve.  If you find Lustre useful, consider sponsoring us on ",
        ),
      ]),
      a(
        [
          class("underline underline-offset-2"),
          href("https://github.com/sponsors/hayleigh-dot-dev"),
        ],
        [text("GitHub!")],
      ),
      span([], [
        text(
          " Bug reports, feature suggestions, and pull requests are also most welcome.",
        ),
      ]),
    ]),
    a(
      [
        class("flex gap-4 items-center justify-center"),
        href("https://github.com/lustre-labs/lustre"),
        target("_blank"),
      ],
      [
        div([class("repo-github")], [
          img([class("size-8 invert brightness-0"), src("/github.svg")]),
          span([], [text("Stars")]),
        ]),
        div([class("repo-stars")], [
          span([], [text(int.to_string(stargazers_count))]),
        ]),
      ],
    ),
  )
}
