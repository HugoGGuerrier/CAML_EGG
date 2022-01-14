(* ========== Type and structure definitions ========== *)


(* Define the type E Class id *)
type e_class_id = int UnionFind.elem

(* Define the module for the map associating E Class ids to E Class *)
module EClassIdMap = Map.Make(struct type t = e_class_id let compare = compare end)

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
    map: (e_class ref) EClassIdMap.t;
}


(* ========== Functions definitions ========== *)


(* --- Utils functions *)


(* --- E-Graph functions *)

(* Create a new E-Graph and return the reference of the created structure *)
let create_e_graph () : e_graph ref =
    ref {id_cpt = 0 ; map = EClassIdMap.empty}


(* --- E-Class functions *)

(* Create a new E-Class in a specific E-Graph and return the reference of the new E-Class *)
let create_e_class (g : e_graph ref) : e_class ref =
    let {id_cpt = cpt ; map = map} = !g in
    let id = UnionFind.make cpt in
    let nec = ref {id = id; e_nodes = []} in
    g := {id_cpt = (cpt + 1) ; map = (EClassIdMap.add id nec map)} ;
    nec

(* Create an union between two E-Class ID *)
let e_class_union (id1 : e_class_id) (id2 : e_class_id) : e_class_id =
    UnionFind.union id1 id2

(* Get the canonical form of an E-Class ID *)
let e_class_canon (id : e_class_id) : e_class_id =
    UnionFind.find id

(* Get an E-Class canonical form by its ID *)
let get_e_class_by_id (g : e_graph ref) (id : e_class_id) : e_class ref =
    EClassIdMap.find (e_class_canon id) !g.map

(* --- E-Node functions *)

let create_e_node (fn : string) : e_node ref =
    ref {fn = fn ; children = []}