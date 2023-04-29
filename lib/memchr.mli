type bigstring =
  (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t

module Optional_index : sig
  type t

  val is_none : t -> bool
  val is_some : t -> bool

  module Optional_syntax : sig
    val is_none : t -> bool
    val is_some : t -> bool
    val unsafe_value : t -> int
  end
end

module type S = sig
  type haystack

  val unsafe_find : haystack -> char -> pos:int -> len:int -> Optional_index.t
  val find : haystack -> char -> pos:int -> len:int -> int option
end

module Bigstring : S with type haystack := bigstring
module String : S with type haystack := string
