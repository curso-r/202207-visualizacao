library(dados)
library(ggplot2)
library(dplyr)

# patchwork :)

# tenho gráficos diferentes e quero juntá-los

theme_set(theme_classic())

p1 <- dados_starwars |>
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point()

p2 <- dados_starwars |>
  ggplot() +
  aes(x = massa) +
  geom_histogram()

p3 <- dados_starwars |>
  ggplot() +
  aes(x = altura) +
  geom_histogram()

p4 <- dados_starwars |>
  count(genero) |>
  ggplot() +
  aes(x = genero, y = n) +
  geom_col()

p1 + p2

library(patchwork)

# operadores "+", "|" e "/"

p1 + p2
p1 + p2 + p3
p1 + p2 + p3 + p4

p1 | p2 | p3 | p4

p1 / p2

teste <- ((p1 / p2) | p3)

teste + theme_dark()

# avançado:

# plot_spacer

(p1 + plot_spacer() + p2) / p3

# plot_layout

## ncol

p1 + p2 + p3 + p4 + plot_layout(ncol = 4)

p1 + p2 + p3 + p4 + plot_annotation(tag_prefix = "figura",
                                    tag_levels = "1")



## widths

((p1 / p2) | p3) + plot_layout(widths = c(1, 5))



## design (layout)

layout <- "
##BBBB
AACCDD
##CCDD
##CCDD
##CCDD
"

p1 + p2 + p3 + p4 + plot_layout(design = layout)


# inset_element

p1 + inset_element(p2, left = .6,
                   right = 1,
                   bottom = .6,
                   top = 1)

p1 + inset_element(p2, left = 0,
                   right = 1,
                   bottom = 0,
                   top = 1,
                   align_to = "full")





