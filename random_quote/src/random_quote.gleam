import gleam/dynamic.{type Dynamic, field, int, list, string}
import gleam/http/request
import gleam/httpc
import gleam/int.{to_string}
import gleam/io
import gleam/json
import gleam/result
import gleam/string

const endpoint = "https://api.quotable.io"

pub type FetchError {
  FailedToCreateRequest
  FailedToSendRequest(Dynamic)
  FailedToParse(json.DecodeError)
  FailedToFetch
}

fn fetch_quote() {
  let quote_decoder =
    dynamic.decode8(
      Quote,
      field("_id", of: string),
      field("content", of: string),
      field("author", of: string),
      field("tags", of: list(string)),
      field("authorSlug", of: string),
      field("length", of: int),
      field("dateAdded", of: string),
      field("dateModified", of: string),
    )

  use req <- result.try(result.replace_error(
    request.to(endpoint <> "/random"),
    FailedToCreateRequest,
  ))

  use res <- result.try(result.map_error(httpc.send(req), FailedToSendRequest))

  use quote <- result.try(result.map_error(
    json.decode(from: res.body, using: quote_decoder),
    FailedToParse,
  ))

  Ok(quote)
}

pub type Quote {
  Quote(
    id: String,
    content: String,
    author: String,
    tags: List(String),
    author_slug: String,
    length: Int,
    date_added: String,
    date_modified: String,
  )
}

fn get_quote_endpoint(id: String) -> String {
  endpoint
  |> string.append("/quotes/")
  |> string.append(id)
}

fn print_field(key: String, value: String) -> Nil {
  key
  |> string.append(" ")
  |> string.pad_right(to: 18, with: ".")
  |> string.append(" ")
  |> string.append(value)
  |> io.println
}

fn print_quote(quote: Quote) -> Nil {
  "Content"
  |> print_field(quote.content)

  "Author"
  |> print_field(quote.author)

  quote.tags
  |> string.join(", ")
  |> print_field("Tags", _)

  quote.id
  |> get_quote_endpoint()
  |> print_field("URL", _)

  quote.length
  |> to_string()
  |> print_field("Length", _)

  "Date Added"
  |> print_field(quote.date_added)

  "Date Modified"
  |> print_field(quote.date_modified)
}

pub fn main() {
  let assert Ok(quote) = fetch_quote()
  print_quote(quote)
}
