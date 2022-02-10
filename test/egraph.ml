(* Test function for the egg implementation memory manipulation *)

open Camlegg

let test_creation () =
    let {id_cpt = id ; map = m ; hc = hc} = (!(create_e_graph ())) in
    Alcotest.(check int) "Test base id" 0 id ;
    Alcotest.(check bool) "Test base map" true (EClassIdMap.is_empty m) ;
    Alcotest.(check bool) "Test base hashcons" true (Hashcons.is_empty hc)

let test_e_class_creation () =
    let g = create_e_graph () in
    let ec1 = create_e_class g in
    let ec2 = create_e_class g in
    let ec3 = create_e_class g in
    
    Alcotest.(check int) "Test e class id" 0 (UnionFind.get !ec1.id) ;
    Alcotest.(check int) "Test e class id" 1 (UnionFind.get !ec2.id) ;
    Alcotest.(check int) "Test e class id" 2 (UnionFind.get !ec3.id)

let test_e_class_id_union () =
    let g = create_e_graph () in
    let ec1 = create_e_class g in
    let ec2 = create_e_class g in
    let ec3 = create_e_class g in
    let ec4 = create_e_class g in

    let _ = e_class_union !ec1.id !ec2.id in
    let _ = e_class_union !ec3.id !ec4.id in

    Alcotest.(check int) "Test e class id" 0 (UnionFind.get (e_class_canon !ec1.id)) ;
    Alcotest.(check int) "Test e class id" 0 (UnionFind.get (e_class_canon !ec2.id)) ;
    Alcotest.(check bool) "Test e class eq" true (e_class_eq ec1 ec2) ;
    Alcotest.(check int) "Test e class id" 2 (UnionFind.get (e_class_canon !ec3.id)) ;
    Alcotest.(check int) "Test e class id" 2 (UnionFind.get (e_class_canon !ec4.id)) ;
    Alcotest.(check bool) "Test e class eq" true (e_class_eq ec4 ec3) ;
    Alcotest.(check bool) "Test e class eq" false (e_class_eq ec1 ec3) ;
    Alcotest.(check bool) "Test e class eq" false (e_class_eq ec4 ec2) ;

    let _ = e_class_union !ec1.id !ec3.id in

    Alcotest.(check int) "Test e class id" 0 (UnionFind.get (e_class_canon !ec1.id)) ;
    Alcotest.(check int) "Test e class id" 0 (UnionFind.get (e_class_canon !ec2.id)) ;
    Alcotest.(check int) "Test e class id" 0 (UnionFind.get (e_class_canon !ec3.id)) ;
    Alcotest.(check int) "Test e class id" 0 (UnionFind.get (e_class_canon !ec4.id)) ;
    Alcotest.(check bool) "Test e class eq" true (e_class_eq ec4 ec1) ;

    Alcotest.(check bool) "Test base map" false (EClassIdMap.is_empty !g.map) ;

    let test_ec = get_e_class_by_id g !ec4.id in

    Alcotest.(check int) "Test e class id" 0 (UnionFind.get !test_ec.id)

let test () =
    test_creation () ;
    test_e_class_creation () ;
    test_e_class_id_union ()