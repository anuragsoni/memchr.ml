(lang dune 3.7)

(name memchr)

(generate_opam_files true)

(source
 (github anuragsoni/memchr.ml))

(authors "Anurag Soni")

(maintainers "Anurag Soni <anurag@sonianurag.com>")

(license BSD-3-clause)

(package
 (name memchr)
 (synopsis "OCaml bindings to c standard library's memchr")
 (depends
  (ocaml
   (>= 4.11.0))
  (core :with-test)
  (core_bench :with-test)
  (ppx_jane :with-test))
 (tags (memchr)))
