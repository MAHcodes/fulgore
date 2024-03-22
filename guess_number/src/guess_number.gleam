import gleam/io
import gleam/int
import gleam/string
import gleam/result
import gleam/order
import gleam/erlang.{get_line}

fn play(number: Int, message: String) -> String {
  case
    message
    |> string.pad_right(33, " ")
    |> get_line()
    |> result.unwrap("")
    |> string.trim()
    |> int.parse()
    |> result.unwrap(0)
    |> int.compare(number)
  {
    order.Lt -> play(number, "Too Low, Try Again: ")
    order.Gt -> play(number, "Too High, Try Again: ")
    order.Eq -> "Congrats!"
  }
}

pub fn main() {
  int.random(9) + 1
  |> play("Enter a number between 1 and 10: ")
  |> io.println()
}
