library(neuralnet)
library(mlbench)
library(e1071)
library(rpart)        
library(rpart.plot)    


# Charger les donnees "BreastCancer"

data("BreastCancer")
df <- BreastCancer

# Exploration initiale des donnees

str(df)
summary(df)

#Preprocessing

#suppression de la colonne Id et suppresion des lignes avec na
df = subset(df, select = -c(Id) )
rows_with_na <- df[apply(df, 1, function(x) any(is.na(x))), ]
df <- na.omit(df)
#suppresion des doublons
df <- unique(df)
#transformation en valeurs numériques
df[,-10][] <- lapply(df, function(x) {
  if (is.factor(x)) {
    as.numeric(as.character(x))  # Convertir les facteurs en numérique
  } else if (is.character(x)) {
    as.numeric(x)  # Convertir les caractères en numérique
  }
})

# Convertir la variable de classe en binaire (0 ou 1)
df$Class <- ifelse(df$Class == "malignant", 1, 0)
set.seed(42)
# Diviser les donnees en jeu d'entrainement et de test
index <- sample(1:nrow(df), size = 0.75 * nrow(df))
train_data <- df[index, ]
test_data <- df[-index, ]

# Normaliser les donnees
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

train_data[, 1:4] <- as.data.frame(lapply(train_data[, 1:4], normalize))
test_data[, 1:4] <- as.data.frame(lapply(test_data[, 1:4], normalize))



#Entrainement du PMC


nn = neuralnet(
  Class~Cl.thickness+Cell.size+Cell.shape+Marg.adhesion+Epith.c.size+Bare.nuclei+Bl.cromatin+Normal.nucleoli+Mitoses,
  data=train_data,
  hidden= c(4,2),
  algorithm = "rprop+",
  learningrate=0.5, 
  err.fct = "sse", #fonction de perte quadratique
  act.fct = "logistic", #sigmoid
  linear.output = FALSE, #couche de sortie avec sigmoid
)
# Visualiser le reseau de neurones
plot(nn)
# Predire sur les donnees de test
pred <- predict(nn, test_data)
# Convertir les probabilites en classes binaires
predicted_class <- ifelse(pred > 0.5, 1, 0)
# Evaluer la performance du modele
accuracy <- sum(predicted_class == test_data$Class) / nrow(test_data)
cat("Precision du modele:", accuracy * 100, "%\n")


#SVM
svm_model <- svm(
  Class ~ .,  # Modèle SVM avec toutes les variables explicatives
  data = train_data,
  type = "C-classification",  # Classification binaire
  kernel = "linear",          # Utilisation d'un kernel radial de base
  cost = 1,                   # Pénalité de régularisation
)

# Faire des prédictions sur le jeu de test
svm_predictions <- predict(svm_model, test_data)
# Évaluer la précision du modèle
accuracy <- sum(svm_predictions == test_data$Class) / nrow(test_data)
cat("Précision du modèle SVM :", accuracy * 100, "%\n")


#Arbre de décision
tree_model <- rpart(
  Class ~ .,               # Utilisation de toutes les variables comme prédicteurs
  data = train_data,
  method = "class",        # Modèle de classification
  control = rpart.control(cp = 0.01)  # Pruning de l'arbre
)


# Faire des prédictions sur le jeu de test
tree_predictions <- predict(tree_model, test_data, type = "class")
# Évaluer la précision du modèle
accuracy <- sum(tree_predictions == test_data$Class) / nrow(test_data)
cat("Précision du modèle d'arbre de décision :", accuracy * 100, "%\n")

# Visualiser l'arbre
rpart.plot(tree_model, type = 3, fallen.leaves = TRUE, cex = 0.7)