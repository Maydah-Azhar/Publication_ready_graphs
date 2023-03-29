#Install packages
install.packages("ggplot2")
install.packages("ggthemes")
install.packages("multcompView")
install.packages("dplyr")

#import packages

library(ggplot2)
library(ggthemes)
library(multcompView)
library(dplyr)

#Importing dataset.
data("chickwts")

#To check the characteristics
tibble(chickwts) 

##calculating means of teatment group as the SD
mean_data <- group_by(chickwts, feed) %>% 
  summarise(weight_mean=mean(weight), sd = sd(weight)) %>% 
  # to arange in descending order
  arrange(desc(weight_mean)) 
tibble(mean_data)

#Performing analysis of varience "ANOVA"
library(stats)
#aov() is builtin function for ANOVA
anova <- aov(weight ~ feed, data = chickwts) 

#Multiple mean comparisons
tukey <- TukeyHSD(anova)
tukey 

# Multiple comparison letters using *multcomp* package
group_letters <- multcompLetters4(anova, tukey)
group_letters

#extracting group letters
group_letters <- as.data.frame.list(group_letters$feed)
group_letters 

#adding to the mean_data
mean_data$group_letters <- group_letters$Letters
tibble(mean_data)

#Ploting the *publication ready barplot* in ggplot2
p <- ggplot(mean_data, aes(x = feed, y = weight_mean))+
  geom_bar(stat = "identity", aes(fill = feed), show.legend = FALSE, width = 0.6) +# barplot
  geom_errorbar( 
    aes(ymin = weight_mean-sd, ymax = weight_mean+sd),
    width = 0.1
  )+
  geom_text(aes(label = group_letters, y = weight_mean + sd), vjust = -0.4) + #add letters
  scale_fill_brewer(palette = "BrBG", direction = 1) +
  
  # Adding labels
   labs( 
    x = "Feed type",
    y = "chicken weight (g)",
    title = "Publication  Barplot",
    subtitle = "Made by Husnain_ali",
    fill = "Feed type"
  ) + 
  ylim(0, 410) + 
  ggthemes::theme_par()
p

## Saving upto 4k barplots in r
tiff ("Barplot.tiff", units = "in", width = 10, height = 6, res = 300, compression = "lzw")
p
dev.off()
