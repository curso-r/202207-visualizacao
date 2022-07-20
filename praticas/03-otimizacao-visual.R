library(tidyverse)
library(dados)

imagem <- "https://wallpaperaccess.com/full/11836.jpg"

vader <- dados_starwars |>
  mutate(vader = if_else(nome == "Darth Vader", TRUE, NA)) |>
  filter(!is.na(vader))

p <- dados_starwars |>
  # filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura) +
  geom_point(
    shape = 23,
    fill = "yellow",
    color = "yellow",
    alpha = .8,
    size = 2
  ) +
  coord_cartesian(xlim = c(0, 200)) +
  geom_point(
    data = vader,
    fill = "red",
    color = "red",
    shape = 23,
    size = 2,
    alpha = 1
  ) +
  # alternativa: annotate(), na próxima aula
  geom_label(
    data = vader,
    aes(label = tolower(nome)),
    fill = "red",
    color = "black",
    size = 2,
    alpha = 1,
    family = "Star Jedi",
    nudge_x = -5,
    nudge_y = 12
  ) +
  # scale_x_continuous(limits = c(0, 200)) # diferente de coord_cartesian!
  labs(
    x = "massa",
    y = "altura",
    title = "Star Wars",
    subtitle = "May the force be with you"
  ) +
  scale_x_continuous(
    breaks = seq(0, 200, 50),
    labels = paste(seq(0, 200, 50), "kg")
  ) +
  scale_y_continuous(
    breaks = seq(0, 250, 50),
    labels = paste(seq(0, 250, 50), "m")
  ) +
  theme(
    text = element_text(family = "Star Jedi"),
    axis.text = element_text(color = "yellow"),
    axis.title = element_text(colour = "yellow"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(color = "gray6"),
    panel.grid.minor.y = element_blank(),
    plot.title = element_text(
      colour = "yellow",
      size = 30,
      hjust = .5
    ),
    plot.subtitle = element_text(
      colour = "yellow",
      size = 12,
      hjust = .5
    ),
    plot.background = element_rect(fill = "black"),
    panel.background = element_rect(fill = "black")
  )

# +
#   ggimage::geom_image(
#     aes(image = imagem),
#     data = vader
#   )



res <- ggimage::ggbackground(
  p, imagem
)


ggsave("praticas/darth.png", res)

## No windows...
extrafont::font_import("exemplos_de_aula/fontes", prompt = FALSE)
extrafont::loadfonts("win")
