# ggplot2
# ggalt
# ggrepel
# gghighlight

library(tidyverse)
library(dados)

jabba <- dados_starwars |>
  filter(massa > 1000)


dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  # geom_label(
  #   aes(label = nome),
  #   data = jabba
  # )
  ## annotate
  annotate(
    "label",
    x = jabba$massa,
    y = jabba$altura,
    label = jabba$nome,
    hjust = 1,
    vjust = -1
  )

## fazer uma seta (arrow)

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  annotate(
    "label",
    x = jabba$massa - 300,
    y = jabba$altura - 30,
    label = jabba$nome,
    hjust = 1,
    vjust = -1
  ) +
  annotate(
    "curve",
    x = jabba$massa - 300,
    xend = jabba$massa-5,
    y = jabba$altura - 30,
    yend = jabba$altura-4,
    arrow = arrow(
      type = "closed",
      length = unit(.4, "cm")
    ),
    colour = "red",
    curvature = -.4
  )

# https://e7.pngegg.com/pngimages/244/781/png-clipart-jabba-the-hutt-r2-d2-c-3po-leia-organa-yoda-bb8-film-carving.png

# anotar imagem

img <- httr::content(httr::GET("https://e7.pngegg.com/pngimages/244/781/png-clipart-jabba-the-hutt-r2-d2-c-3po-leia-organa-yoda-bb8-film-carving.png"))

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  annotate(
    "curve",
    x = jabba$massa - 300,
    xend = jabba$massa-5,
    y = jabba$altura - 30,
    yend = jabba$altura-4,
    arrow = arrow(
      type = "closed",
      length = unit(.4, "cm")
    ),
    colour = "red",
    curvature = .4
  ) +
  annotation_raster(
    img,
    xmin = jabba$massa-400,
    xmax = jabba$massa-5,
    ymin = jabba$altura-80,
    ymax = jabba$altura-2
  )

## ggimage, ggimg


# destaque ----------------------------------------------------------------

## gghighlight

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point(size = 4) +
  gghighlight::gghighlight(
    massa > 1000,
    label_key = nome
  )

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point(size = 4) +
  gghighlight::gghighlight(
    altura < 120,
    label_key = nome
  )

## ggalt

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  ggalt::geom_encircle(
    data = jabba,
    color = "red",
    s_shape = 0,
    expand = 0,
    spread = .02,
    size = 2
  )

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  ggalt::geom_encircle(
    data = filter(dados_starwars, altura > 220),
    color = "red",
    s_shape = 0,
    expand = 0.02,
    spread = .1,
    size = 2
  )

## ggrepel

p1 <- dados_starwars |>
  filter(massa < 1000) |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  ggrepel::geom_label_repel(aes(label = nome))

p2 <- dados_starwars |>
  filter(massa < 1000) |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  ggrepel::geom_text_repel(aes(label = nome))

library(patchwork)
p1+p2 + plot_layout()

p1 +
  patchwork::inset_element(p2, .6, .6, 1,1) +
  patchwork::inset_element(p2, .8, .8, 1,1)



p1 + inset_element(grid::circleGrob(), 0.4, 0.4, 0.6, 0.6)
