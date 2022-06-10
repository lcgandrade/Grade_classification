#library
library(readxl)
library(tidyverse)


set.seed(12)

#load data, view
notas_categ <- as.data.frame(read_excel("data/notas_categ.xlsx"))
View(notas_categ)
# Estudante     Financas    Custos    Mkt     Atuaria     Sexo
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

#view in plan
notas_alunos %>% 
  ggplot() +
  geom_point(aes(x = Atuaria,
                 y = Mkt),
             size = 3)

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

#calculate the distances of the matrix using the Euclidean distance
distancia <- dist(notas_alunos_pad, method = "euclidean")

#hierarchical method | nearest neighbor
cluster.hierarquico <- hclust(distancia, method = "single" )

#dendrogram
plot(cluster.hierarquico, cex = 0.6, hang = -1)

#create groups
grupo_alunos_hierarquico <- cutree(cluster.hierarquico, k = 3)
table(grupo_alunos_hierarquico)
# 1   2   3
#
# 84  1   15

#convert to data frame at cluster output
grupo_alunos_hierarquico <- data.frame(grupo_alunos_hierarquico)
#             grupo_alunos_hierarquico
# Adelino     1
# Renata      1
# Giulia      1
# Felipe      1
# Cecília     2

#generated table join with original base
notas_alunos_fim <- cbind(notas_alunos, grupo_alunos_hierarquico)
#             Atuaria       Mkt           grupo_alunos_hierarquico
#
# Adelino     10.0          10.0          1
# Renata      10.0          10.0          1
# Giulia      10.0          10.0          1
# Felipe      9.0           9.0           1
# Cecília     10.0          7.0           2

#view clusters in color
notas_alunos_fim %>% 
  ggplot() +
  geom_point(aes(x = Atuaria,
                 y = Mkt,
                 color = as.factor(grupo_alunos_hierarquico)),
             size = 3)

##########  second analysis  ###########

#choosing the data
notas_alunos <- notas_categ %>% 
  select(Estudante, Financas, Custos)

#view in plan
notas_alunos %>% 
  ggplot() +
  geom_point(aes(x = Financas,
                 y = Custos),
             size = 3)

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

#calculate the distances of the matrix using the Euclidean distance
distancia <- dist(notas_alunos_pad, method = "euclidean")

#hierarchical method | nearest neighbor
cluster.hierarquico <- hclust(distancia, method = "single" )

#dendrogram
plot(cluster.hierarquico, cex = 0.6, hang = -1)

#create groups
grupo_alunos_hierarquico <- cutree(cluster.hierarquico, k = 3)
table(grupo_alunos_hierarquico)
# 1   2   3
#
# 98  1   1

#convert to data frame at cluster output
grupo_alunos_hierarquico <- data.frame(grupo_alunos_hierarquico)
#             grupo_alunos_hierarquico
# Adelino     1
# Renata      1
# Giulia      2
# Felipe      1
# Cecília     1

#generated table join with original base
notas_alunos_fim <- cbind(notas_alunos, grupo_alunos_hierarquico)
#             Financas      Custos        grupo_alunos_hierarquico
#
# Adelino     10.0          10.0          1
# Renata      10.0          10.0          1
# Giulia      10.0          10.0          2
# Felipe      9.0           9.0           1
# Cecília     10.0          7.0           1

#view clusters in color
notas_alunos_fim %>% 
  ggplot() +
  geom_point(aes(x = Financas,
                 y = Custos,
                 color = as.factor(grupo_alunos_hierarquico)),
             size = 3)