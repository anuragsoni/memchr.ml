# Memchr.ml

OCaml bindings for [memchr](https://en.cppreference.com/w/c/string/byte/memchr) that work for
strings, bytes and Bigarray backed "bigstrings". `memchr` finds the first
occurrence of a user provided character in the user provided string. The `find` functions in this library
can be used as an alternative to `String.index`, `String.index_from`, etc as `memchr` is generally faster
than the `index` operations in the OCaml standard library, and unlike the `index` functions in the standard
library the c bindings in this library do not allocate.
