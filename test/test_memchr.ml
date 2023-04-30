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

let%test_unit "Memchr.Bytes.find behaves similar to Bytes.index" =
  let generator =
    Quickcheck.Generator.tuple2 String.gen_nonempty Char.quickcheck_generator
  in
  Quickcheck.test generator ~f:(fun (haystack, needle) ->
      let haystack = Bytes.of_string haystack in
      let stdlib_response = Caml.Bytes.index_opt haystack needle in
      let memchr_response =
        Memchr.Bytes.find haystack needle ~pos:0 ~len:(Bytes.length haystack)
      in
      [%test_result: int option] ~expect:stdlib_response
        (Memchr.Optional_index.to_int memchr_response))

let%test_unit "Memchr.Bigstring.find behaves similar to Bigstring.find" =
  let generator =
    Quickcheck.Generator.tuple2 String.gen_nonempty Char.quickcheck_generator
  in
  Quickcheck.test generator ~f:(fun (haystack, needle) ->
      let haystack = Bigstring.of_string haystack in
      let stdlib_response = Bigstring.find needle haystack in
      let memchr_response =
        Memchr.Bigstring.find haystack needle ~pos:0
          ~len:(Bigstring.length haystack)
      in
      [%test_result: int option] ~expect:stdlib_response
        (Memchr.Optional_index.to_int memchr_response))
