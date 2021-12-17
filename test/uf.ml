(* Create the union find implementation *)
module Test = UnionFind.Make(UnionFind.StoreMap)

(* Test the suite availablity *)
let test_creation () = 
    let store = Test.new_store () in
    let store, v1 = Test.make store 5 in
    let store, v2 = Test.make store 5 in
    Alcotest.(check int) "get equals" (snd (Test.get store v1)) (snd (Test.get store v2))

let test_set () =
    let store = Test.new_store () in
    let store, v1 = Test.make store 5 in
    let store, v2 = Test.make store 6 in
    let store = Test.set store v1 6 in
    Alcotest.(check int) "get equals" (snd (Test.get store v1)) (snd (Test.get store v2))

let test_eq () =
    let store = Test.new_store () in
    let store, v1 = Test.make store 1 in
    let store, v2 = Test.make store 2 in
    let store, v3 = Test.make store 3 in
    let store, v4 = Test.make store 4 in
    let store, v5 = Test.make store 5 in
    let store, _ = Test.eq store v1 v2 in
    let store, _ = Test.eq store v2 v3 in
    let store, _ = Test.eq store v4 v5 in
    Alcotest.(check int) "get equals" (snd (Test.get store v1)) (snd (Test.get store v2)) ;
    Alcotest.(check int) "get equals" (snd (Test.get store v1)) (snd (Test.get store v3)) ;
    Alcotest.(check int) "get equals" (snd (Test.get store v4)) (snd (Test.get store v5))

(* Function to run all tests in the file *)
let test () =
    test_creation ()