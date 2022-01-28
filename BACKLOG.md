# Rapport hebdomadaire du développement de CAML_EGG

## Semaine du 06 Déc 2021

Les tâches suivantes ont été effectuées

* Création de l'infrastructure du projet
* Recherche de la méthode de développement la plus optimisé
* Début de l'écriture de structures de données
* Choix de l'implémentation des maps immutables pour représenter les relations
* Utilisation de la lib unionFind (https://gitlab.inria.fr/fpottier/unionfind)
* Début de l'écriture de tests unitaire avec Alcotest pour assurer le fonctionnement du projet

Etant donné que je dois réaliser un rapport et une présentation du projet ayant un objectif pédagogique, je dois essayer de rendre mon code le plus clair possible et éviter les constructions trop farfelues. De plus, je dois commencer à réfléchir à comment la présentation pourrait se dérouler.

## Semaine du 13 Déc 2021

Les tâches suivantes ont été effectués

* Apprentissage et lecture de la documentation de la lib unionFind
* Implémentation avec un STORE et tests unitaires sur cette librairie pour s'assurer de son fonctionnement
* Révision de la structure des e-graphs pour simplifier la manipulation de la structure (ex : changement de `type e_class_id = int` en `type e_class_id = int EClassIdUnionFind.rref`)
* Creation de fonction pour manipuler plus facilement la structure union find des identifiants d'e class
* Ajout d'une fonction pour créer une nouvelle e class
* Changement des structure de données pour rendre tout ça un peu plus mutable

L'avancement sur l'implémentation des algorithmes n'est pas significative cette semaine, mais j'ai pris le temps de réfléchir sur la meilleure manière d'implémenter les e-graph pour que ce soit à la fois simple à comprendre et relire et simple à utiliser.
De plus, j'ai passé pas mal de temps à envisager et revoir la mutabilité des structures que j'ai créé pour que ce soit plus simple à manipuler

## Semaine du 03 Jav 2022

Découverte d'un problème sur la manipulation des E-Gaph lors de vacances de Noël. La description du problème est comme suit :

- La structure union-find au sein de la structure `e_graph` (dans le fichier `camlegg.ml`) sert à maintenir les équivalences entre les identifiants d'E-Class
- Dans le fichier de test `uf.ml`, on test que cette structure union-find se comporte de la manière souhaité, et les test passent sans souci
- Cependant, dans le fichier de test `egraph.ml` où l'on test l'implémentation des E-Graph, la création d'équivalence ne fonctionne plus 
- Le problème survient dans la méthode `test_e_class_id_union` si on décommente les lignes 43 et 44
- Comme vous pouvez le voir, ce test fait appel au fonctions `ec_id_union` et `ec_id_get` étant définies dans le fichier `camlegg.ml`
- Ces fonctions sont censées modifier le store à l'interieur de E-Graph, mais pour une raison inconnu, elle n'y arrivent pas
- Avec des affichages de débug, c'est visiblement la fonction `ec_id_union` qui n'arrive pas a créer l'union entre les deux identifiant passé en paramètre

La solution au problème a été trouvé, il suffit de chager d'implémentation de UnionFind. Je ne passe plus par le foncteur désomais car celui-ci ne semble pas posséder d'implementation complète pour l'instant

## Semaine du 10 Jav 2022

Réimplémentation des E Class ID pour faire fonction la structure Union Find + Ecriture de nombreux tests et de nouvelles fonctions utilitaires pour tester tout cela
Découverte d'un nouveau bug sur la map censée stocker la relation entre E-Class ID et E-Class...
Je vais essayer de le corriger dans le week-end, mais cela me semble compromis, étant donné que je n'arrive même pas à afficher une map...

## Semaine du 17 Jav 2022

Correction du problème dans la map du E-Graph grâce à un retour à la représentation des identifiants de E-Class comme des entiers. Tous les tests passent maintenant.

Le travaille qui a été effectué cette semaine : 
- Ajout des fonctions de canonnisation pour les E-Class et les E-Node
- Ajout des fonctions de comparaisons entres les E-Class et les E-Node, ces fonctions permettront de simplifier les tests lors de l'implémentation de CAML_EGG
- Ajout de tests unitiares pour chaquue nouvelle fonction crée

Besoin d'explicitation pour la notion de congruence

## Semaine du 24 Jav 2022

Recherches pour le problème de Hashcons dans les outils déjà développé pour OCaml [ocaml-hashcons](https://github.com/backtracking/ocaml-hashcons)
Problème lors de l'installation de cette bibliothèque à l'aide d'Opam ; Pour reproduire l'erreur : `opam install hashcons` cela donne un échec de compilation du module `conf-autoconf 0.1`
