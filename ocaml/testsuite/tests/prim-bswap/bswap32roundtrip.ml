(* TEST
*)
type buf = bytes

external create_buf : int -> buf = "caml_create_bytes"
external unsafe_get32 : buf -> int -> int32 = "%caml_bytes_get32u"
external unsafe_set32 : buf -> int -> int32 -> unit = "%caml_bytes_set32u"
external bswap32 : int32 -> int32 = "%bswap_int32"

let buf = create_buf 32
let read buf ~pos = unsafe_get32 buf pos |> bswap32 |> Stdlib.Int32.to_int
let write buf ~pos n = unsafe_set32 buf pos (n |> Stdlib.Int32.of_int |> bswap32)

let numbers =
    [ 0x11223344l |> Stdlib.Int32.to_int
    ; 0xf0f0f0f0l |> Stdlib.Int32.to_int
    ; 0l |> Stdlib.Int32.to_int
    ; -1l |> Stdlib.Int32.to_int
    ; Stdlib.Int32.max_int |> Stdlib.Int32.to_int
    ; Stdlib.Int32.min_int |> Stdlib.Int32.to_int
    ]
  ;;

let test n =
  write buf ~pos:0 n;
  let n' = read buf ~pos:0 in
  assert (Int.equal n n')

let () =
  List.iter test numbers
