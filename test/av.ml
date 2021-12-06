(* Test the suite availablity *)
let test_available () = 
    Alcotest.(check bool) "available" true true

(* Function to run all tests in the file *)
let test () =
    test_available ()