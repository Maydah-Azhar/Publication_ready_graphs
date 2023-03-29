# installl packages

install.packages("ggthemes")
install.packages("dplyr")
install.packages("multcompview")
install.packages("ggplot2")
install.packages("stats")

#importing packages
library(ggthemes)
library(dplyr)
library(multcompView)
library(ggplot2)
library(stats)

# Import data set
data2 <- ToothGrowth
data2$dose = as.factor(data2$dose)

#Two Way ANOVA
anova <- aov(len ~ supp*dose, data = data2)
summary(anova)

#Multiple mean comparison analysis 
tukey <- TukeyHSD(anova)
tukey

#Extract lettering 
group_lettering <- multcompLetters4(anova,tukey)
group_lettering

group_lettering2 <- data.frame(group_lettering$`supp:dose`$Letters)
group_lettering2

##Calculate and add mean, sd and letting columns to the datset.
mean_data2 <- data2 %>%
  group_by(supp, dose) %>%
  summarise(len_mean = mean(len), sd = sd(len)) %>%
  arrange(desc(len_mean))
summarise()
tibble(mean_data2)

mean_data2$group_lettering <- group_lettering2$group_lettering..supp.dose..Letters
mean_data2

## Ploting publication ready Barplot with TWO-WAY ANOVA
ggplot(mean_data2, aes(x = dose, y = len_mean, group = supp, fill = supp)) +
  geom_bar(position = position_dodge(width = 0.9), stat = "identity", show.legend = TRUE)

# show the error bars
ggplot(mean_data2,aes(x = dose , y = len_mean,group=supp))+
  geom_bar(position = position_dodge(0.9),stat = "identity",
           aes(fill = supp), show.legend = TRUE)+
  geom_errorbar(aes(ymin = len_mean-sd, ymax = len_mean+sd),
                width = 0.1, position = position_dodge(0.9))
## add lettering to error bars
ggplot(mean_data2,aes(x = dose , y = len_mean,group=supp))+
  geom_bar(position = position_dodge(0.9),stat = "identity",
           aes(fill = supp), show.legend = TRUE) +
  geom_errorbar(aes(ymin = len_mean-sd, ymax = len_mean+sd),
                width = 0.1, position = position_dodge(0.9))+
  geom_text(aes(label = group_lettering, y = len_mean + sd),
            #add letters
            vjust =-0.4, position = position_dodge(0.9))
# final barplot with TWO-WAy ANOVA(type-1)
p <- ggplot(mean_data2,aes(x = dose , y = len_mean,group=supp))+
  geom_bar(position = position_dodge(0.9),stat = "identity",
           aes(fill = supp), show.legend = TRUE)+ #barplot
  geom_errorbar(aes(ymin = len_mean-sd, ymax = len_mean+sd),
                width = 0.1, position = position_dodge(0.9))+
  geom_text(aes(label = group_lettering, y = len_mean + sd), 
            vjust =-0.4, position = position_dodge(0.9)) +
  scale_fill_brewer(palette = "BrBG", direction = 1) + 
  labs(
    x = "Dose",
    y = "length (cm)",
    title = "Group Barplot",
    subtitle = "made by HUSNAIN ALI",
    fill = "Dose"
  )+
  ylim(0,35)+
  ggthemes::theme_par()
p
#using facet_wrap 
p1 <- ggplot(mean_data2,aes(x = dose , y = len_mean,group=supp))+
  geom_bar(position = position_dodge(0.9),stat = "identity",
           aes(fill = supp), show.legend = TRUE)+ #barplot
  geom_errorbar(aes(ymin = len_mean-sd, ymax = len_mean+sd),
                width = 0.1, position = position_dodge(0.9))+
  geom_text(aes(label = group_lettering, y = len_mean + sd),
            vjust =-0.4, position = position_dodge(0.9))+
  scale_fill_brewer(palette = "BrBG", direction = 1) + 
  labs(
    x = "Dose",
    y = "length (cm)",
    title = "Group Barplot",
    subtitle = "made by HUSNAIN ALI",
    fill = "Dose"
  )+
  facet_wrap(~supp)
ylim(0,35)+
  ggthemes::theme_par()
p1

## saving graph

tiff("barplot_G1.tiff", units = "in", height = 6, res = 300,compression = "lzw")
p
dev.off()
##Second graph
tiff("barplot_G2.tiff", units = "in", height = 7, res = 200,compression = "lzw")
p1
dev.off()