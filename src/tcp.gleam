import gleam/list
import gleam/string
import gleam/bit_string

pub type Socket

pub type TCPResult {
  Ok
}

type TCPOption {
  Binary
  Active(Bool)
}

pub fn connect(host: String, port: Int) {
  tcp_connect(
    host
    |> string.to_graphemes
    |> list.map(fn(char) {
      let <<code>> = bit_string.from_string(char)
      code
    }),
    port,
    [Binary, Active(False)],
  )
}

pub fn send(socket, data) {
  tcp_send(socket, data)
}

pub fn receive(socket) {
  tcp_receive(socket, 0)
}

@external(erlang, "gen_tcp", "connect")
fn tcp_connect(host: List(Int), port: Int, ops: List(TCPOption)) -> Result(
  Socket,
  Nil,
)

@external(erlang, "gen_tcp", "send")
fn tcp_send(socket: Socket, data: BitString) -> TCPResult

@external(erlang, "gen_tcp", "recv")
fn tcp_receive(socket: Socket, length: Int) -> Result(BitString, Nil)
