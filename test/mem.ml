open Camlegg ;;

let test_creation () =
    let {id_cpt = id; m = m} = (!(Camlegg.create_e_graph ())) in
    Alcotest.(check int) "Test base id" 0 id;
    Alcotest.(check bool) "Test base map" true (EClassIdMap.is_empty m)

let test () =
    test_creation ()