# Memchr.ml

OCaml bindings for [memchr](https://en.cppreference.com/w/c/string/byte/memchr) that work for
strings, bytes and Bigarray backed "bigstrings". `memchr` finds the first
occurrence of a user provided character in the user provided string. The `find` functions in this library
can be used as an alternative to `String.index`, `String.index_from`, etc as `memchr` is generally faster
than the `index` operations in the OCaml standard library. Compared to `String.index` the find in this library
don't raise an exception, and compared to `index_opt` the `find` functions in this library don't allocate an option.
