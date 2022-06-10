#library
library(readxl)
library(tidyverse)


set.seed(12)

#load data, view, move ID to rows
notas_categ <- as.data.frame(read_excel("data/notas_categ.xlsx"))
View(notas_categ)
#               Financas    Custos    Mkt     Atuaria     Sexo
#
# Adelino       9.9         10.0      10.0    10.0        Masc
# Renata        7.7         10.0      10.0    10.0        Fem
# Giulia        6.2         10.0      10.0    10.0        Fem
# Felipe        8.7         10.0      9.0     9.0         Masc
# Cecília       9.8         10.0      7.0     10.0        Fem

##########  first analysis  ###########

#choosing the data
notas_alunos <- notas_categ %>% 
  select(Estudante, Atuaria, Mkt)

#move ID to rows
rownames(notas_alunos) <- notas_alunos[,1]
notas_alunos <- notas_alunos[,-1]

#standardize variables
notas_alunos_pad <- scale(notas_alunos)
#             Atuaria       Mkt  
#
# Adelino     1.86464588    1.53173333     
# Renata      1.86464588    1.53173333
# Giulia      1.86464588    1.53173333
# Felipe      1.46672743    1.17819425
# Cecília     1.86464588    0.47111608

#calculate the cluster | k-means
cluster.k3 <- kmeans(notas_alunos_pad, centers = 3)

#create groups
grupo_alunos_kmeans3 <- data.frame(cluster.k3$cluster)
#             cluster.k3.cluster
# Adelino     2
# Renata      2
# Giulia      2
# Felipe      2
# Cecília     2

#join table with original base
notas_alunos_fim <- cbind(notas_alunos, grupo_alunos_kmeans3)
#             Atuaria       Mkt       cluster.k3.cluster       
#
# Adelino     10.0          10.0      2     
# Renata      10.0          10.0      2
# Giulia      10.0          10.0      2
# Felipe      9.0           9.0       2
# Cecília     10.0          7.0       2

#view clusters in color
notas_alunos_fim %>% 
  ggplot() +
  geom_point(aes(x = Atuaria,
                 y = Mkt,
                 color = as.factor(cluster.k3.cluster)),
             size = 3)

#calculate the cluster | dbscan
dbscan <- fpc::dbscan(notas_alunos_pad,eps = 0.56, MinPts = 3)

#join table in original data
notas_alunos_fim$dbscan <- dbscan$cluster
#             Atuaria       Mkt       cluster.k3.cluster      dbscan       
#
# Adelino     10.0          10.0      2                       1    
# Renata      10.0          10.0      2                       1
# Giulia      10.0          10.0      2                       1
# Felipe      9.0           9.0       2                       1
# Cecília     10.0          7.0       2                       0

#view clusters in color
notas_alunos_fim %>% 
  ggplot() +
  geom_point(aes(x = Atuaria,
                 y = Mkt,
                 color = as.factor(dbscan)),
             size = 3)

##########  second analysis  ###########

#choosing the data
notas_alunos <- notas_categ %>% 
  select(Estudante, Financas, Custos)

#move ID to rows
rownames(notas_alunos) <- notas_alunos[,1]
notas_alunos <- notas_alunos[,-1]

#standardize variables
notas_alunos_pad <- scale(notas_alunos)
#             Financas        Custos 
#
# Adelino     1.30205788      2.150294630     
# Renata      0.59755041      2.150294630
# Giulia      0.11720437      2.150294630
# Felipe      0.91778111      2.150294630
# Cecília     1.27003499      2.150294630

#calculate the cluster | k-means
cluster.k3 <- kmeans(notas_alunos_pad, centers = 3)

#create groups
grupo_alunos_kmeans3 <- data.frame(cluster.k3$cluster)
#             cluster.k3.cluster
# Adelino     1
# Renata      1
# Giulia      1
# Felipe      1
# Cecília     1

#join table with original base
notas_alunos_fim <- cbind(notas_alunos, grupo_alunos_kmeans3)
#             Financas      Custos    cluster.k3.cluster       
#
# Adelino     10.0          10.0      1     
# Renata      10.0          10.0      1
# Giulia      10.0          10.0      1
# Felipe      9.0           9.0       1
# Cecília     10.0          7.0       1

#view clusters in color
notas_alunos_fim %>% 
  ggplot() +
  geom_point(aes(x = Financas,
                 y = Custos,
                 color = as.factor(cluster.k3.cluster)),
             size = 3)

#calculate the cluster | dbscan
dbscan <- fpc::dbscan(notas_alunos_pad,eps = 0.56, MinPts = 3)

#join table in original data
notas_alunos_fim$dbscan <- dbscan$cluster
#             Financas      Custos    cluster.k3.cluster      dbscan       
#
# Adelino     10.0          10.0      1                       1    
# Renata      10.0          10.0      1                       1
# Giulia      10.0          10.0      1                       1
# Felipe      9.0           9.0       1                       1
# Cecília     10.0          7.0       1                       1

#view clusters in color
notas_alunos_fim %>% 
  ggplot() +
  geom_point(aes(x = Financas,
                 y = Custos,
                 color = as.factor(dbscan)),
             size = 3)