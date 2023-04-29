type bigstring =
  (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t

module type T = sig
  type t

  val unsafe_find : t -> char -> pos:int -> len:int -> int
end

module Make (T : T) : Memchr_intf.S with type haystack := T.t = struct
  let unsafe_find = T.unsafe_find

  let find t ch ~pos ~len =
    let idx = unsafe_find t ch ~pos ~len in
    if idx < 0 then None else Some idx
end

module Bigstring = Make (struct
  type t = bigstring

  external unsafe_find : t -> char -> pos:int -> len:int -> int
    = "bigstring_memchr"
    [@@noalloc]
end)

module String = Make (struct
  type t = string

  external unsafe_find : t -> char -> pos:int -> len:int -> int
    = "string_memchr"
    [@@noalloc]
end)
