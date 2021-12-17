(* Test function for the egg implementation memory manipulation *)

open Camlegg

let test_creation () =
    let {id_cpt = id ; store = _; map = m} = (!(create_e_graph ())) in
    Alcotest.(check int) "Test base id" 0 id ;
    Alcotest.(check bool) "Test base map" true (EClassIdMap.is_empty m)

let test_e_class_creation () =
    let g = create_e_graph () in
    let ec = create_e_class g in
    let ec2 = create_e_class g in
    let ec3 = create_e_class g in
    Alcotest.(check int) "Test counter" 3 !g.id_cpt ;
    Alcotest.(check bool) "Test map" false (EClassIdMap.is_empty !g.map) ;

    Alcotest.(check int) "Test new e class id" 0 (ec_id_get g !ec.id) ;
    Alcotest.(check bool) "Test the idempotence" true ((ec_id_find g !ec.id) = !ec.id) ;

    Alcotest.(check int) "Test new e class id" 1 (ec_id_get g !ec2.id) ;
    Alcotest.(check bool) "Test the idempotence" true ((ec_id_find g !ec2.id) = !ec2.id) ;

    Alcotest.(check int) "Test new e class id" 2 (ec_id_get g !ec3.id) ;
    Alcotest.(check bool) "Test the idempotence" true ((ec_id_find g !ec3.id) = !ec3.id)

let test () =
    test_creation () ;
    test_e_class_creation ()