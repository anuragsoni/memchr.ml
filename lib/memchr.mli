(** OCaml bindings for
    {{:https://en.cppreference.com/w/c/string/byte/memchr} memchr} that can
    operate on strings, bytes and bigarray backed bigstrings. [Memchr] scans the
    sub-view within a string (represented by pos and len) and returns the
    position of the first occurrence of the user provided character. *)

(** [Optional_index] is used to represent an optional integer index without any
    allocations. This module can be paired with ppx_optional to safely access
    the result of a find operation. *)
module Optional_index : sig
  type t

  val none : t
  val is_none : t -> bool
  val is_some : t -> bool
  val to_int : t -> int option
  val of_int : int -> t

  module Optional_syntax : sig
    val is_none : t -> bool
    val is_some : t -> bool
    val unsafe_value : t -> int
  end
end

module Bigstring : sig
  external unsafe_find :
    (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t ->
    char ->
    pos:int ->
    len:int ->
    Optional_index.t = "bigstring_memchr"
    [@@noalloc]

  (** [unsafe_find] searches for a byte using [memchr]. This function does not
      perform bounds checking before calling memchr. *)

  val find :
    (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t ->
    char ->
    pos:int ->
    len:int ->
    Optional_index.t
  (** [find] searches for a byte using [memchr]. This function performs bounds
      checking before calling memchr. *)
end

module String : sig
  external unsafe_find :
    string -> char -> pos:int -> len:int -> Optional_index.t = "string_memchr"
    [@@noalloc]
  (** [unsafe_find] searches for a byte using [memchr]. This function does not
      perform bounds checking before calling memchr. *)

  val find : string -> char -> pos:int -> len:int -> Optional_index.t
  (** [find] searches for a byte using [memchr]. This function performs bounds
      checking before calling memchr. *)
end

module Bytes : sig
  external unsafe_find : bytes -> char -> pos:int -> len:int -> Optional_index.t
    = "bytes_memchr"
    [@@noalloc]
  (** [unsafe_find] searches for a byte using [memchr]. This function does not
      perform bounds checking before calling memchr. *)

  val find : bytes -> char -> pos:int -> len:int -> Optional_index.t
  (** [find] searches for a byte using [memchr]. This function performs bounds
      checking before calling memchr. *)
end
