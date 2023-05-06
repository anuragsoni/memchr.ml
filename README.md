# Memchr.ml

OCaml bindings for [memchr](https://en.cppreference.com/w/c/string/byte/memchr) that work for
strings, bytes and Bigarray backed "bigstrings". `memchr` finds the first
occurrence of a user provided character in the user provided string. The `find` functions in this library
can be used as an alternative to `String.index`, `String.index_from`.

`memchr` is generally faster than the `index` operations in the OCaml standard library.
Compared to `String.index` the find in this library don't raise an exception and can be used to search
for a character in a sub-view within a string.

The library uses an `Optional_index` type as the return value as this helps
avoid allocations since it can represent an optional index without using the standard library's
optional type. This type also pairs well with [ppx_optional](https://github.com/janestreet/ppx_optional)
that allows using the `Optional_index` type with a pattern match as opposed to an if then else expression, 
similar to the standard option type in the standard library.

## Examples

You can follow along with these examples in the OCaml toplevel. [utop](https://github.com/ocaml-community/utop) or [down](https://github.com/dbuenzli/down)
are recommended to enhance your REPL experience while working through these examples as they support
autocompletion which can be useful when exploring a new library.

We will start by using topfind to load memchr and make it accessible within the toplevel.
```ocaml
# #require "memchr";;
```

Haystack is the string payload we will use for the following examples.
```ocaml
# let haystack = "this is a sentence used for testing memchr";;
val haystack : string = "this is a sentence used for testing memchr"
```

Lets try and search for the first occurrence of a character in the entire string. This is similar to using String.index.
for a character in the entire string.
```ocaml
# let index = Memchr.String.find haystack 'i' ~pos:0 ~len:(String.length haystack) in
    if Memchr.Optional_index.is_some index
    then Printf.printf "Found at index %d\n" (Memchr.Optional_index.Optional_syntax.unsafe_value index)
    else print_endline "did not find character"
  ;;
Found at index 2
- : unit = ()
```

Using if-then-else is pretty verbose and we don't benefit from the compiler performing exhaustive checks ensuring
we always handle both the scenario where an index is found and when the character is missing from the string.
We can pair `memchr` with `ppx_optional` to benefit from the nicer pattern match api that's used for option types
while still avoiding allocations.

```ocaml
# #require "ppx_optional";;

# let open Memchr.Optional_index in
  match%optional Memchr.String.find haystack 'i' ~pos:0 ~len:(String.length haystack) with
  | Some idx -> Printf.printf "Found at index %d\n" idx
  | None -> print_endline "did not find character"
  ;;
Found at index 2
- : unit = ()
```

Using ppx_optional also ensures that the compiler can warn us if we don't handle all branches of the response:

```ocaml
# let open Memchr.Optional_index in
  match%optional Memchr.String.find haystack 'i' ~pos:0 ~len:(String.length haystack) with
  | Some idx -> Printf.printf "Found at index %d\n" idx
  ;;
Lines 2-3, characters 3-56:
Warning 8 [partial-match]: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
None
Found at index 2
- : unit = ()
```

The `find` functions accept a position and length to access a sub-view within a string. This can be useful
to perform searches on a smaller view within a string without needing to perform a substring operation.

```ocaml
# let open Memchr.Optional_index in
  match%optional Memchr.String.find haystack 'i' ~pos:10 ~len:8 with
  | Some idx -> Printf.printf "Found at index %d\n" idx
  | None -> print_endline "did not find character"
  ;;
did not find character
- : unit = ()
```
