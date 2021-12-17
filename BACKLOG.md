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