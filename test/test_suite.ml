open Alcotest ;;

let () = 
    Alcotest.run "EGG OCaml implementation" [
        "tests-available", [ test_case "Test suite is available" `Quick Av.test ];
        "tests-memory-manipulation", [ test_case "Memory manipulation is valid" `Quick Mem.test ];
    ]