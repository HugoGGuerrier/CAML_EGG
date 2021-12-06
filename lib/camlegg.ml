(* ========== Type and structure definitions ========== *)


(* Define the type E Class id *)
type e_class_id = int ;;

(* Define the module for the map associating E Class ids to E Class *)
module EClassIdMap = Map.Make(struct type t = e_class_id let compare = compare end) ;;

(* Define the module for the eclass id set *)
module EClassIdSet = Set.Make(struct type t = e_class_id let compare = compare end) ;;

(* Define the type E Node *)
type e_node = {
    fn: string;
    children: EClassIdSet.t;
} ;;

(* Define the type E Class *)
type e_class = {
    id: e_class_id;
    e_nodes: e_node list;
} ;;

(* Define the type E-Graph as given in the EGG specification *)
type e_graph = {
    id_cpt: e_class_id;
    m: e_class EClassIdMap.t;
} ;;


(* ========== Functions definitions ========== *)


(* Create a new e graph and return the reference of the created structure *)
let create_e_graph () : e_graph ref =
    ref {id_cpt = 0; m = EClassIdMap.empty}

(* Get an E Class by its id *)
let get_e_class (graph : e_graph ref) (id : e_class_id) : e_class =
    let real_id = UnionFind.make id in
    EClassIdMap.find (UnionFind.get (UnionFind.find real_id)) !graph.m