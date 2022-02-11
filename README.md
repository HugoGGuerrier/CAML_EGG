# CAML_EGG : An OCaml implementation of EGG

Author : Hugo GUERRIER \
License : MIT \
Verison : 0.4a 

## Dependencies

Binaries that are mandatory to run this project

- opam : [The ocaml package manager](https://opam.ocaml.org/)
- ocaml >= 4.13.1 : [The OCaml lang](https://ocaml.org/index.fr.html)
- dune : [The OCaml building tool](https://github.com/ocaml/dune)

There are also some ocaml dependencies

- alcotest : [The unit test lib](https://github.com/mirage/alcotest)
- unionFind [The INRIA union find ocaml lib](https://gitlab.inria.fr/fpottier/unionfind)

## Installation

This installation process is optimized for Unix systems but thanks to **opam** it should work on every system

- (1) Install **opam** on your system [Help](https://opam.ocaml.org/doc/Install.html)
- (2) Install a correct OCaml environment. You can do this manually, but the best way to do it is to run `$ opam switch create 4.13.1` (Restart your terminal)
- (3) Install **dune** on your system using **opam** `$ opam install dune`
- (4) Install ocaml dependencies with **opam** `$ opam install alcotest unionFind`

## Running tests

To perform tests on the EGG implementation simply run `$ dune runtest` on the project root.
All tests are in the `test` folder, there is :

- Test for the union-find structure
- Test for the E-Graph creation
- Test for E-Class creation and manipulation
- Test for E-Node creation and manipulation
