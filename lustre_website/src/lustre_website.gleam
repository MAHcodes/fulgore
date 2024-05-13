import components/announcement_bar.{announcement_bar}
import components/footer.{footer}
import components/header.{header}
import gleam/dynamic
import gleam/option.{type Option, None, Some}
import gleam/string
import lustre
import lustre/attribute.{class}
import lustre/effect.{type Effect}
import lustre/element/html.{div}
import lustre_http.{type HttpError}
import sections/contributors.{type User, User, contributors}
import sections/features.{features}
import sections/hero.{hero}
import sections/lab.{lab}
import sections/support.{support}

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)
}

type Model {
  Model(repo: Option(Repo), contributors: Option(List(User)))
}

type Repo {
  Repo(stargazers_count: Int)
}

fn init(_) -> #(Model, Effect(Msg)) {
  #(
    Model(repo: None, contributors: None),
    effect.batch([
      get_contributors("lustre-labs", "lustre"),
      get_stargazers_count("lustre-labs", "lustre"),
    ]),
  )
}

pub opaque type Msg {
  ApiUpdatedRepo(Result(Repo, HttpError))
  ApiUpdatedContributors(Result(List(User), HttpError))
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    ApiUpdatedRepo(Ok(repo)) -> #(
      Model(..model, repo: Some(repo)),
      effect.none(),
    )
    ApiUpdatedRepo(Error(_)) -> #(model, effect.none())
    ApiUpdatedContributors(Ok(contributors)) -> #(
      Model(..model, contributors: Some(contributors)),
      effect.none(),
    )
    ApiUpdatedContributors(Error(_)) -> #(model, effect.none())
  }
}

fn get_stargazers_count(owner: String, repo: String) -> Effect(Msg) {
  let url =
    "https://api.github.com/repos/"
    |> string.append(owner)
    |> string.append("/")
    |> string.append(repo)

  let decoder =
    dynamic.decode1(Repo, dynamic.field("stargazers_count", dynamic.int))

  lustre_http.get(url, lustre_http.expect_json(decoder, ApiUpdatedRepo))
}

fn get_contributors(owner: String, repo: String) -> Effect(Msg) {
  let url =
    "https://api.github.com/repos/"
    |> string.append(owner)
    |> string.append("/")
    |> string.append(repo)
    |> string.append("/contributors")

  let decoder =
    dynamic.list(dynamic.decode4(
      User,
      dynamic.field("login", dynamic.string),
      dynamic.field("avatar_url", dynamic.string),
      dynamic.field("html_url", dynamic.string),
      dynamic.field("contributions", dynamic.int),
    ))

  lustre_http.get(url, lustre_http.expect_json(decoder, ApiUpdatedContributors))
}

fn view(model: Model) {
  html.main([], [
    announcement_bar(),
    header(),
    div([class("container")], [
      hero(),
      features(),
      support(
        option.unwrap(model.repo, Repo(stargazers_count: 0)).stargazers_count,
      ),
      lab(),
      contributors(option.unwrap(model.contributors, [])),
    ]),
    footer(),
  ])
}
