#installing the packages

install.packages("readxl")
install.packages("tidyverse")
install.packages("devtools")
devtools::install_github("JLSteenwyk/ggpubfigs")
install.packages("esquisse")
install.packages("hrbrthemes")

#importing packages

library(readxl)
library(tidyverse)
library(devtools)
library(ggpubfigs)

#importing datasets

data("midwest") 
data("iris")
data("mtcars") 
data("PlantGrowth")


ggplot(PlantGrowth) +
  aes(x = group, y = weight, fill = group, colour = group) +
  geom_col() +
  scale_fill_manual(
    values = c(ctrl = "#470457", trt1 = "#22908B", trt2 = "#FDE725")
  ) + scale_color_manual(
    values = c(ctrl = "#470457", trt1 = "#22908B", trt2 = "#FDE725")
  ) +
  labs(
    x = "Treatmetns", y = "palnt Weight(g)", subtitle = "barplot.Autoplot"
  ) +
  theme_classic()


#Heatmap for midwest dataset.

ggplot(midwest) + aes(x = state, y = category, fill = area) +
  geom_tile() + scale_fill_gradient() +
  theme_minimal() + facet_wrap(vars(inmetro))

