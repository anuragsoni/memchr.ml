type bigstring =
  (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t

module Optional_index = struct
  type t = int

  let is_none t = t < 0
  let is_some t = t >= 0
  let to_int t = if is_none t then None else Some t

  module Optional_syntax = struct
    let is_none t = is_none t
    let is_some t = is_some t
    let unsafe_value (t : int) = t
  end
end

module type S = sig
  type haystack

  val unsafe_find : haystack -> char -> pos:int -> len:int -> Optional_index.t
  val find : haystack -> char -> pos:int -> len:int -> Optional_index.t
end

module type T = sig
  type t

  val unsafe_find : t -> char -> pos:int -> len:int -> int
  val total_length : t -> int
end

module Make (T : T) : S with type haystack := T.t = struct
  let unsafe_find = T.unsafe_find

  let find t ch ~pos ~len =
    if pos < 0 then invalid_arg "Negative pos";
    if len < 0 then invalid_arg "Negative len";
    if pos > T.total_length t - len then
      invalid_arg "pos + len is greater than total_length";
    unsafe_find t ch ~pos ~len
end

module Bigstring = Make (struct
  type t = bigstring

  let total_length t = Bigarray.Array1.dim t

  external unsafe_find : t -> char -> pos:int -> len:int -> int
    = "bigstring_memchr"
    [@@noalloc]
end)

module String = Make (struct
  type t = string

  let total_length t = String.length t

  external unsafe_find : t -> char -> pos:int -> len:int -> int
    = "string_memchr"
    [@@noalloc]
end)
