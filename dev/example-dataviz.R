#===============================================================================
# 2023-12-06 -- top100altmetric
# Example datavis
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

source("dev/prep-session.R")

library(showtext)
sysfonts::font_add_google("Atkinson Hyperlegible", "ah")
showtext_auto()

# set ggplot2 theme
devtools::source_gist("653e1040a07364ae82b1bb312501a184")
theme_set(theme_ik())

options(scipen = 999)

library(top100altmetric)

top100altmetric %>%
    arrange(altmetric_attention_score) %>%
    ggplot(
        aes(
            twitter_mentions, news_mentions,
            color = year %>% factor,
            size = altmetric_attention_score
        )
    )+
    geom_point()+
    scale_x_log10(position = "top")+
    scale_y_log10(position = "right")+
    scale_color_viridis_d(end = .95)+
    scale_size_area(guide = "none")+
    labs(
        color = NULL,
        subtitle = "Top 100 noticed papers of the year according to Altmetric",
        caption = "Data: https://www.altmetric.com/top100 // Ilya Kashnitsky @ikashnitsky.phd",
        x = "Mentions on Twitter",
        y = "Mentions in news atricles"
    )+
    theme(
        legend.position = c(.1, .3),
        legend.background = element_rect(fill = NA, color = NA),
        plot.subtitle = element_text(face = 2),
        plot.caption = element_text(size = 8)
    )+
    annotate(
        "text",
        label = "Dots are scaled to represent\ntotal Altmetric attention score",
        x = 1, y = 2000,
        size = 4, hjust = 0, color = "#00444499",
        family = "ah", fontface = 2, lineheight = .9
    )

ggsave("out/attention-score.pdf", width = 5, height = 5)
