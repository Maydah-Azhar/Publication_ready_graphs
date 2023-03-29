install.packages("ggpubr")
library(tidyverse)
library(ggpubr)
df<- ToothGrowth
#Plot
p <- ggboxplot(df,x = 'dose', y = 'len',
          color = 'dose', add = 'jitter',
          xlab = 'Dose',ylab = 'Length',
          legend.title = 'Dosage',
          palette = c('red','green','blue')
          );m

#Comparison
all_comparisons <- list(c('0.5','1'),
                        c('0.5','2'),
                        c('1','2'))
p + stat_compare_means(comparisons = all_comparisons,
                       label = 'p.signif')+
stat_compare_means(label.y = 50)+ ylim(0,60)


pp <- ggboxplot(ToothGrowth,x = 'supp', y = 'len',
               color = 'supp', add = 'jitter',palette = 'npg',
               facet.by = 'dose',
               short.panel.labs = FALSE);pp
pp<- pp + stat_compare_means(
  aes(label=paste0("p = ", ..p.formats..)));pp
                         
                     
               
