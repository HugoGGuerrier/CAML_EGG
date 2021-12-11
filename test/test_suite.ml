open Alcotest ;;

let () = 
    Alcotest.run "EGG OCaml implementation" [
        "tests-available", [ test_case "Test suite is available" `Quick Av.test ];
        "tests-e-graph-manipulation", [ test_case "E Graph manipulation is valid" `Quick Egraph.test ];
    ]