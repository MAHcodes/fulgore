import gleam/int
import lustre
import lustre/element.{text}
import lustre/element/html.{button, div, p}
import lustre/event.{on_click}

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

fn init(_) {
  0
}

type Msg {
  Incr
  Decr
  Reset
}

fn update(model, msg) {
  case msg {
    Incr -> model + 1
    Decr -> model - 1
    Reset -> 0
  }
}

fn view(model) {
  let count = int.to_string(model)

  div([], [
    button([on_click(Incr)], [text(" + ")]),
    button([on_click(Decr)], [text(" - ")]),
    button([on_click(Reset)], [text(" reset ")]),
    p([], [text(count)]),
  ])
}

