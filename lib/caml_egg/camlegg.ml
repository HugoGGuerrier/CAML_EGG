(* ========== Type and structure definitions ========== *)


(* Define the type E Class id *)
type e_class_id = int UnionFind.elem

(* Define the module for the map associating E Class ids to E Class *)
module EClassIdMap = Map.Make(struct type t = int let compare = compare end)

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
    g := {id_cpt = (cpt + 1) ; map = (EClassIdMap.add cpt nec map)} ;
    nec

(* Create an union between two E-Class ID *)
let e_class_union (id1 : e_class_id) (id2 : e_class_id) : e_class_id =
    UnionFind.union id1 id2

(* Get the canonical form of an E-Class ID *)
let e_class_canon (id : e_class_id) : e_class_id =
    UnionFind.find id

(* Get an E-Class canonical form by its ID *)
let get_e_class_by_id (g : e_graph ref) (id : e_class_id) : e_class ref =
    EClassIdMap.find (UnionFind.get (e_class_canon id)) !g.map

let e_class_eq (ec1 : e_class ref) (ec2 : e_class ref) : bool =
    (UnionFind.get (e_class_canon !ec1.id)) = (UnionFind.get (e_class_canon !ec2.id))

(* --- E-Node functions *)

(* Create a new reference to an E-Node *)
let create_e_node (fn : string) : e_node ref =
    ref {fn = fn ; children = []}

(* Return the cononical form of the given E-Node *)
let e_node_canon (en : e_node ref) : e_node =
    {fn = !en.fn ; children = (List.map e_class_canon !en.children)}

let e_node_eq (g : e_graph ref) (en1 : e_node ref) (en2 : e_node ref) : bool =
    let finder _ v : bool =
        (List.mem en1 !v.e_nodes) && (List.mem en2 !v.e_nodes)
    in
    EClassIdMap.exists finder !g.map
    