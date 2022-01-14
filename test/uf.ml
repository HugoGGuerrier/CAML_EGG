(* Test the suite availablity *)
let test_creation () = 
    let v1 = UnionFind.make 5 in
    let v2 = UnionFind.make 5 in
    Alcotest.(check int) "get equals" (UnionFind.get v1) (UnionFind.get v2)

let test_set () =
    let v1 = UnionFind.make 5 in
    let v2 = UnionFind.make 6 in
    UnionFind.set v2 5 ;
    Alcotest.(check int) "get equals" (UnionFind.get v1) (UnionFind.get v2)

let test_eq () =
    let v1 = UnionFind.make 1 in
    let v2 = UnionFind.make 2 in
    let v3 = UnionFind.make 3 in
    let v4 = UnionFind.make 4 in
    let v5 = UnionFind.make 5 in
    let v6 = UnionFind.make 6 in
    let v12 = UnionFind.union v1 v2 in
    let v34 = UnionFind.union v3 v4 in
    let v56 = UnionFind.union v5 v6 in
    Alcotest.(check int) "get equals" (UnionFind.get v1) (UnionFind.get v2) ;
    Alcotest.(check int) "get equals" 1 (UnionFind.get v2) ;
    Alcotest.(check int) "get equals" (UnionFind.get v3) (UnionFind.get v4) ;
    Alcotest.(check int) "get equals" 3 (UnionFind.get v4) ;
    Alcotest.(check int) "get equals" (UnionFind.get v5) (UnionFind.get v6) ;
    Alcotest.(check int) "get equals" 5 (UnionFind.get v6) ;
    Alcotest.(check int) "get equals" (UnionFind.get v12) (UnionFind.get v1) ;
    Alcotest.(check int) "get equals" (UnionFind.get v34) (UnionFind.get v3) ;
    Alcotest.(check int) "get equals" (UnionFind.get v56) (UnionFind.get v5) 

(* Function to run all tests in the file *)
let test () =
    test_creation () ;
    test_set () ;
    test_eq ()