(lang dune 3.0)

(name memchr)

(generate_opam_files true)

(using mdx 0.2)

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
  (mdx :with-test)
  (core :with-test)
  (ppx_optional :with-test)
  (core_bench :with-test)
  (ppx_jane :with-test))
 (tags (memchr)))
