(* ========== Type and structure definitions ========== *)


(* Define the type E Class id *)
type e_class_id = int UnionFind.elem

(* Define the module for the map associating E Class ids to E Class *)
module EClassIdMap = Map.Make(struct type t = int let compare = compare end)

(* Define the module for the hashmap for the e_node *)
module Hashcons = Map.Make(struct type t = int let compare = compare end)

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
    hc: (e_class ref) Hashcons.t;
}


(* ========== Functions definitions ========== *)


(* --- Utils functions *)


(* --- E-Graph functions *)


(* Create a new E-Graph and return the reference of the created structure *)
let create_e_graph () : e_graph ref =
    ref {id_cpt = 0 ; map = EClassIdMap.empty ; hc = Hashcons.empty}


(* --- E-Class functions *)


(* Create a new E-Class in a specific E-Graph and return the reference of the new E-Class *)
let create_e_class (g : e_graph ref) : e_class ref =

    (*  Create the new E-Class *)
    let {id_cpt = cpt ; map = map ; hc = hc} = !g in
    let id = UnionFind.make cpt in
    let nec = ref {id = id; e_nodes = []} in

    (* Update the E-Graph structure *)
    g := {id_cpt = (cpt + 1) ; map = (EClassIdMap.add cpt nec map) ; hc = hc} ;

    (* Return the new E-Class *)
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

(* Verify if two E-Class are equals *)
let e_class_eq (ec1 : e_class ref) (ec2 : e_class ref) : bool =
    (UnionFind.get (e_class_canon !ec1.id)) = (UnionFind.get (e_class_canon !ec2.id))


(* --- E-Node functions *)


(* Hash an E-Node *)
let hash_e_node (en : e_node) : int =
    let res = Hashtbl.hash en.fn in
    List.fold_left (fun r id -> (r + UnionFind.get id)) res en.children

(* Create a new reference to an E-Node *)
let create_e_node (g : e_graph ref) (ec : e_class ref) (fn : string) : e_node ref =

    (* Create the new E-Node and its hash *)
    let nen = ref {fn = fn ; children = []} in
    let hash = hash_e_node !nen in

    (* Update the E-Class *)
    ec := {id = !ec.id ; e_nodes = (nen :: !ec.e_nodes)} ;

    (* Update the E-Graph *)
    g := {id_cpt = !g.id_cpt ; map = !g.map ; hc = (Hashcons.add hash ec !g.hc)} ;

    (* Return the new E-Node *)
    nen

(* Add a child to an E-Node *)
let e_node_add_child (g : e_graph ref) (en : e_node ref) (ec : e_class ref) : unit =
    en := {fn = !en.fn ; children = (!ec.id) :: !en.children} ;

    (* Update the hashcons *)
    let hash = hash_e_node !en in
    g := {id_cpt = !g.id_cpt ; map = !g.map ; hc = (Hashcons.add hash ec !g.hc)}

(* Return the canonical form of the given E-Node *)
let e_node_canon (en : e_node ref) : e_node =
    {fn = !en.fn ; children = (List.map e_class_canon !en.children)}

(* Test if two E-Nodes are equals *)
let e_node_eq (g : e_graph ref) (en1 : e_node ref) (en2 : e_node ref) : bool =
    (!(Hashcons.find (hash_e_node !en1) !g.hc).id) = (!(Hashcons.find (hash_e_node !en2) !g.hc).id)
