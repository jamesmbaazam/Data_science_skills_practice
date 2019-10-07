library(readxl)
library(dplyr)
library(ggplot2)
library(janitor)
library(ggthemes)
library(scales)
#data
facilities <- read_excel(path = 'data/public_health_facilities_ssa.xlsx', na = c('', 'na')) 
facilities <- clean_names(facilities)


#descriptives
summary(facilities)
View(head(facilities, n = 20))
facilities$ll_source <- tolower(facilities$ll_source)


percentage_sources <- facilities %>%
    count(ll_source) %>% 
    mutate(percentage = round((n / sum(n))*100, 2)) %>% 
    arrange(desc(percentage)) 

#colors for plot
bar_col <-  c(rep('black', times = nrow(percentage_sources)))
bar_col[7] <- 'red'
bar_col
percentage_sources$bar_colors <- bar_col
percentage_sources$ll_source <- forcats::fct_explicit_na(percentage_sources$ll_source)

percentage_sources

ggplot(data = percentage_sources, aes(x = reorder(ll_source, percentage), y = percentage), fill = 'variable') + 
    geom_bar(stat = 'identity') +
    labs(x = 'Source', y = 'Percent of facilities') +
    theme_economist() +
    theme(axis.title.x = element_text(size = 14), axis.title.y = element_text(size = 14), axis.text.x = element_text(angle = 90, hjust = 1)) 
