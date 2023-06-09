module Optional_index = struct
  type t = int

  let none = -1
  let is_none t = t < 0
  let is_some t = t >= 0
  let to_int t = if is_none t then None else Some t
  let of_int t = t

  module Optional_syntax = struct
    let is_none t = is_none t
    let is_some t = is_some t
    let unsafe_value (t : int) = t
  end
end

let validate_pos_len ~pos ~len ~total_length =
  if pos < 0 then invalid_arg "Negative pos";
  if len < 0 then invalid_arg "Negative len";
  if pos > total_length - len then
    invalid_arg "pos + len is greater than total_length"

module Bigstring = struct
  external unsafe_find :
    (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t ->
    char ->
    pos:int ->
    len:int ->
    int = "bigstring_memchr"
    [@@noalloc]

  let find t ch ~pos ~len =
    validate_pos_len ~pos ~len ~total_length:(Bigarray.Array1.dim t);
    unsafe_find t ch ~pos ~len
end

module String = struct
  external unsafe_find : string -> char -> pos:int -> len:int -> int
    = "string_memchr"
    [@@noalloc]

  let find t ch ~pos ~len =
    validate_pos_len ~pos ~len ~total_length:(String.length t);
    unsafe_find t ch ~pos ~len
end

module Bytes = struct
  external unsafe_find : bytes -> char -> pos:int -> len:int -> int
    = "bytes_memchr"
    [@@noalloc]

  let find t ch ~pos ~len =
    validate_pos_len ~pos ~len ~total_length:(Bytes.length t);
    unsafe_find t ch ~pos ~len
end
