import gleam/io
import gleam/result.{try}
import gleam/hackney
import gleam/http/request
import gleam/http/response.{type Response}
import gleeunit/should
import gleam/json
import gleam/dynamic.{field, int, list, string}
import gleam/string.{append, join, pad_right}
import gleam/int.{to_string}

const endpoint = "https://api.quotable.io"

fn fetch_endpoint(endpoint: String) -> Result(Response(String), hackney.Error) {
  let assert Ok(req) = request.to(endpoint)

  use response <- try(
    req
    |> hackney.send,
  )

  response.status
  |> should.equal(200)

  Ok(response)
}

pub type QuoteResponse {
  QuoteContent(
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

fn quote_to_json(json: String) -> Result(QuoteResponse, json.DecodeError) {
  let quote_decoder =
    dynamic.decode8(
      QuoteContent,
      field("_id", of: string),
      field("content", of: string),
      field("author", of: string),
      field("tags", of: list(string)),
      field("authorSlug", of: string),
      field("length", of: int),
      field("dateAdded", of: string),
      field("dateModified", of: string),
    )

  json.decode(from: json, using: quote_decoder)
}

fn get_quote_endpoint(id: String) -> String {
  endpoint
  |> append("/quotes/")
  |> append(id)
}

fn print_field(key: String, value: String) -> Nil {
  key
  |> append(" ")
  |> pad_right(to: 18, with: ".")
  |> append(" ")
  |> append(value)
  |> io.println
}

fn print_quote(quote: QuoteResponse) -> Nil {
  "Content"
  |> print_field(quote.content)

  "Author"
  |> print_field(quote.author)

  quote.tags
  |> join(", ")
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
  let assert Ok(res) = fetch_endpoint(endpoint <> "/random")
  let assert Ok(quote) = quote_to_json(res.body)

  print_quote(quote)
}
