open! Core

let%test_unit "Memchr.String.find behaves similar to String.index" =
  let generator =
    Quickcheck.Generator.tuple2 String.gen_nonempty Char.quickcheck_generator
  in
  Quickcheck.test generator ~f:(fun (haystack, needle) ->
      let stdlib_response = String.index haystack needle in
      let memchr_response =
        Memchr.String.find haystack needle ~pos:0 ~len:(String.length haystack)
      in
      [%test_result: int option] ~expect:stdlib_response
        (Memchr.Optional_index.to_int memchr_response))
