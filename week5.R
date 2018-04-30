# week 5
# data source
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/acs2015_county_data.csv


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
  tidyr::gather(key = "Community", value = "Pop", -State, -Unemployment) %>% 
  ggplot(aes(x = Pop, y = Unemployment,color = Community)) +
  geom_point(alpha = 0.05) +
  scale_color_brewer(palette = "Spectral") +
  geom_smooth(method = "lm",se = FALSE) +
  labs(x = "Percentage of the population",
       y = "Unemployment Rate",
       Title = "Unployment vs Community Percentage",
       caption = "By @davidmasp , data from Kaggle") +
  facet_geo(~ State,scales = "free") +
  theme_cowplot(font_size = 8) +
  theme(axis.line = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank())

ggsave(p1,filename = "week5.png",width = 12,height = 8)





