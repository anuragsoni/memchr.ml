open Core
open Core_bench

let haystack = String.init 4096 ~f:(fun _ -> Random.char ())

let string_benchmarks () =
  let needle = Random.char () in
  Bench.Test.create_group ~name:"string"
    [
      Bench.Test.create_group ~name:"memchr"
        [
          Bench.Test.create ~name:"unsafe_find" (fun () ->
              Sys.opaque_identity
                (Memchr.String.unsafe_find haystack needle ~pos:0
                   ~len:(String.length haystack)));
          Bench.Test.create ~name:"find" (fun () ->
              Sys.opaque_identity
                (Memchr.String.find haystack needle ~pos:0
                   ~len:(String.length haystack)));
        ];
      Bench.Test.create ~name:"index" (fun () ->
          Sys.opaque_identity (String.index haystack needle));
    ]

let () = Bench.make_command [ string_benchmarks () ] |> Command_unix.run
