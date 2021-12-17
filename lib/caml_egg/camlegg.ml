(* ========== Type and structure definitions ========== *)


(* Define the module for the union find structure *)
module EClassIdUnionFind = UnionFind.Make(UnionFind.StoreMap)

(* Define the module for the map associating E Class ids to E Class *)
module EClassIdMap = Map.Make(struct type t = int let compare = compare end)

(* Define the type E Class id *)
type e_class_id = int EClassIdUnionFind.rref

(* Define the type E Node *)
type e_node = {
    fn: string;
    children: e_class_id list;
}

(* Define the type E Class *)
type e_class = {
    id: e_class_id;
    e_nodes: (e_node ref) list;
}

(* Define the type E-Graph as given in the EGG specification *)
type e_graph = {
    id_cpt: int;
    store: int EClassIdUnionFind.store;
    map: (e_class ref) EClassIdMap.t;
}


(* ========== Functions definitions ========== *)


(* --- Utils functions *)

(* --- E-Graph functions *)

(* Create a new E-Graph and return the reference of the created structure *)
let create_e_graph () : e_graph ref =
    let s = EClassIdUnionFind.new_store () in
    ref {id_cpt = 0; store = s; map = EClassIdMap.empty}

(* Get the int representation of an E-Class id *)
let ec_id_get (g : e_graph ref) (id : e_class_id) : int =
    let store, res = EClassIdUnionFind.get !g.store id in
    g := {id_cpt = !g.id_cpt; store = store; map = !g.map} ;
    res

(* Get the E-Class id parent of the wanted E-Class id in the union find structure *)
let ec_id_find (g : e_graph ref) (id : e_class_id) : e_class_id =
    let store, x = EClassIdUnionFind.get !g.store id in
    let res = EClassIdMap.find x !g.map in
    g := {id_cpt = !g.id_cpt; store = store; map = !g.map} ;
    !res.id

(* Create an union between two E-Class ids *)
let ec_id_union (g : e_graph ref) (id1 : e_class_id) (id2 : e_class_id) : unit =
    let store, _ = EClassIdUnionFind.eq !g.store id1 id2 in
    g := {id_cpt = !g.id_cpt; store = store; map = !g.map} ;
    ()

(* --- E-Class functions *)

(* Create a new E-Class in a specific E-Graph and return the reference of the new E-Class *)
let create_e_class (g : e_graph ref) : e_class ref =
    let {id_cpt = cpt; store = store; map = map} = !g in
    let store, id = EClassIdUnionFind.make store cpt in
    let nec = ref {id = id; e_nodes = []} in
    g := {id_cpt = (cpt + 1); store = store; map = (EClassIdMap.add cpt nec map)} ;
    nec


(* --- E-Node functions *)