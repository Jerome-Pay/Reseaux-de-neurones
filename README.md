# R-seaux-de-neurones
Projet de Master 2 - Exploration de différents types de réseaux de neurones

## Introduction

Ce projet a pour but d'explorer plusieurs types de réseaux de neurones. Ces modèles existent depuis plus de 50 ans et n'ont pas toujours été utiisé pour de l'apprentissage. Il existe plusieurs architectures pour un réseau dépendemment de la problématique à résoudre. Concernant l'apprentissage avec ces réseaux, de grandes avancées ont été effectuée depuis 20 ans notamment grâce aux capacités de calcul des machines qui ont augmenté. Le Deep Learning est maintenant un champ de recherche en plein essor dans le monde de l'intelligence artificielle.  

Ce projet comporte une étude de l'histoire des réseaux de neurones jusqu'au Perceptron multi-couches pour l'apprentissage. Un étude sur les bases de l'apprentissage par renforcement.  
Il y a également 3 scripts qui concernent l'utilisation de plusieurs packages pour l'implémentation de 3 types de réseaux de neurones.

### Part2

Dans cette partie nous analysons un jeu de données comportant des données sur la taille, la forme et l'état des cellules cancéreuses avec une étiquette précisant si la cellule est bénigne ou maligne, c'est un problème de classification. Le jeu de données est petit, 450 lignes et 10  colonnes.  
Nous implémentons le réseau sur R grâce au package "neuralnet" et nous comparons les résultats avec un arbre de décision et un SVM.  

Le package permet un affichage du réseau :
![neuralnet_plot_reseau](https://github.com/user-attachments/assets/90e99319-b86c-4629-b2e1-9ead65272e16)  

Examinons l'accuracy de nos 3 modèles :
- Arbre de décision : 91.15%
- SVM : 92.92%
- PMC : 92.03%

Les résulats sont sensiblement les mêmes. La raison est sûrement dû à une faible complexité dans les données. Un simple arbre de décision donne d'excellent résultat. Un PMC n'est pas nécéssaire car il n'y a pas vraiment de relations complexes dans les données.

### Part3

Nous passons à la classification d'images. Le dataset MNIST est très connu et permet de facilement comprendre comment fonctionne un réseau de neurones convolutifs. Ci-dessous une image qui explique très bien comment est traité l'image dans le CNN (Convolutif Neural Network).  
![CNN_explication](https://github.com/user-attachments/assets/781a9167-8268-4055-a49b-10792135b2de)

Le code a été implémenté sur python avec le package Keras de Tensorflow. Nous obtenons une accuracy de 96.6%

### Part4

Dans cette dernière partie nous attaquons un type de réseau peu connu et peu utilisé, les cartes de Kohonen ou cartes autoadaptatives ou Self Organizing Map en anglais. Pour la démonstration d'une carte de Kohonen nous nous plaçons sur Rstudio et installons le package "SOMbrero", crée par des
chercheurs de l’INRAE(Institut national de recherche pour l’agriculture, l’alimentation et l’environnement)
et des enseignants-chercheurs de l’université Paris-Dauphine. Le package a commencé a être développé peu
après 2010.  

Une carte de Kohonen est un type de réseau de neurones non-supervisé
qui sert principalement à la réduction de dimensionnalité, la visualisation et le clustering (classification non-supervisée). Ces modèles permettent de projeter des données complexes de haute dimension sur une carte
2D, tout en préservant les relations topologiques entre les données similaires. Cela signifie que les objets
proches dans l’espace d’origine seront également proches sur la carte. Cela ressemble fortement à une ACP
mais on projette les données sur une grille.  

Avec encore un dataset très commun, Iris, nous entrainons notre modèle et nous avons le résulat suivant, une carte de Kohonen :
![SOM_classification](https://github.com/user-attachments/assets/e0ea8d17-78b5-44f4-ad27-a11912052483)

On aperçoit qu’un grand groupe d’observations est présent tout en haut à gauche de notre carte, cela signifie
qu’ils sont beaucoup à avoir des caractéristiques très spécifiques. En effet, ils ont très peu de voisins proches.
A contrario, les autres observations semblent avoir des caract´eristiques similaires car ils sont regroupé d’un
côté d’une diagonale.  

En affichant les différents types d'espèces on remarque que le modèle a bien séparer les différentes espèces et donc les variables explicatives utilisées lors de l'entraînement ont effectivement un rôle dans la définition de l'espèce.

