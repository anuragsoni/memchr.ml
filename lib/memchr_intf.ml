module type S = sig
  type haystack

  val unsafe_find : haystack -> char -> pos:int -> len:int -> int
  val find : haystack -> char -> pos:int -> len:int -> int option
end
