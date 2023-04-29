type bigstring =
  (char, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t

module Bigstring : Memchr_intf.S with type haystack := bigstring
module String : Memchr_intf.S with type haystack := string
