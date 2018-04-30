# week 5
# data source https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/acs2015_county_data.csv

colors = c(
  Asian = "#50B8E3",
  Black = '#E3413F',
  Hispanic = '#A94CFA',
  Native = '#A6B256',
  Pacific = '#A1FD55',
  White = '#4A2BE3'
)

dat = readr::read_csv("week5/acs2015_county_data.csv")

library(geofacet)
library(cowplot)
library(magrittr)

p1 = dat %>% dplyr::select(State,
                      Hispanic,
                      White,
                      Black,
                      Native,
                      Asian,
                      Pacific,
                      Unemployment) %>%
  tidyr::gather(key = "Ethnicity", value = "Pop", -State, -Unemployment) %>% 
  ggplot(aes(x = Pop, y = Unemployment,color = Ethnicity)) +
  geom_point(alpha = 0.05) +
  scale_color_manual(values = colors) +
  geom_smooth(method = "lm",se = FALSE) +
  labs(x = "Percentage of the population",
       y = "Unemployment Rate") +
  facet_geo(~ State,scales = "free") +
  theme_cowplot(font_size = 8) +
  theme(axis.line = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank())

ggsave(p1,filename = "plot.png",width = 12,height = 8)


