#PART 4
library(ggplot2)
library(SOMbrero)
library(hexbin)

# On récupère les données Iris
data("iris")

# Description des variables
df <- iris
str(df)
summary(df)
# standardisation des donneés
df[,1:4] <- scale(df[, 1:4])

set.seed(255)
# Modèle
iris.som <- trainSOM(x.data = df[,1:4], dimension = c(5,5), verbose = TRUE,
                     nb.save = 5, topo = "hexagonal")
iris.som

#fonction d'énergie
plot(iris.som, what="energy")

#affichage du clustering
iris.som$clustering
table(iris.som$clustering)

# carte heatmap du clsutering
plot(iris.som, what="obs", type="hitmap")

#erreur topographique dans le summary
summary(iris.som)

# comparaison avec les labels
plot(iris.som, what="add", type="pie", variable=iris$Species)

# prédiction de clustering pour une donnée
predict(iris.som, df[1,1:4]+0.2)

#affichage des caractéristiques moyennes pour chaque variable pour chaque neurones
par(mfrow = c(2,2))
plot(iris.som, what = "obs", type = "color", variable = 1)
plot(iris.som, what = "obs", type = "color", variable = 2)
plot(iris.som, what = "obs", type = "color", variable = 3)
plot(iris.som, what = "obs", type = "color", variable = 4)

# affichage des valeurs des poids des neurones
plot(iris.som, what = "prototypes", type = "lines", show.names = TRUE) + 
  theme(axis.text.x = element_blank())
plot(iris.som, what = "prototypes", type = "barplot", show.names = TRUE) + 
  theme(axis.text.x = element_blank())

# Et plein d'autres graphiques disponible
plot(iris.som, what = "obs", type = "boxplot", show.names = TRUE)
plot(iris.som, what = "obs", type = "lines", show.names = TRUE)
plot(iris.som, what = "obs", type = "names", show.names = TRUE)

par(mfrow=c(2,2))
plot(iris.som, what = "prototypes", type = "3d", variable = 1)
plot(iris.som, what = "prototypes", type = "3d", variable = 2)
plot(iris.som, what = "prototypes", type = "3d", variable = 3)
plot(iris.som, what = "prototypes", type = "3d", variable = 4)

plot(iris.som, what = "prototypes", type = "poly.dist", show.names = FALSE)

plot(iris.som, what = "prototypes", type = "umatrix")
plot(iris.som, what = "prototypes", type = "smooth.dist")
plot(iris.som, what = "prototypes", type = "mds")
plot(iris.som, what = "prototypes", type = "grid.dist")



#Avec une table de contingence
data(presidentielles2002)
#résultats par candidat
apply(presidentielles2002, 2, sum)

#Modèle
presi.som <- trainSOM(x.data=presidentielles2002, type="korresp", scaling="chi2", dimension=c(8,8),
                      nb.save = 10, topo="hexagonal", maxit=500)

plot(presi.som, what = "energy")
# clustering resultat
presi.som$clustering
#Heatmap du clustering
plot(presi.som, what="obs",type="hitmap")
# résultats de Jean-marie Le Pen
plot(presi.som, what = "prototypes", type = "color", variable = "LE_PEN")
# affichage des poids
plot(presi.som, what="prototypes", type="barplot", view="c")
# affichage des poids et des observations
plot(presi.som, what="prototypes", type="barplot", view="r") +    
  guides(fill=guide_legend(keyheight=0.6, ncol=2, label.theme=element_text(size=6))) + 
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())

# clustering hierarchique possible
## compute 3 super clusters
presi.sc <- superClass(presi.som, k=3)
## plot its 3 dimensional dendrogram
plot(presi.sc, type="grid")
