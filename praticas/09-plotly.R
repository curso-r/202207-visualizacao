# plotly ------------------------------------------------------------------

library(dados)
library(plotly)
library(tidyverse)

# pelo ggplot2

p <- dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa,
      y = altura,
      colour = genero,

      # editando a 'legenda'
      text = paste("Massa:", massa)) +
  geom_point(size = 2) +
  theme_minimal()

ggplotly(p, tooltip = "text")


# veja que customização não funciona muito bem


p <- dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa, y = altura, colour = genero) +
  geom_point(size = 2) +
  theme_minimal() +
  theme(
    legend.position = "bottom"
  )

ggplotly(p)

# tem que usar sintexe do plotly pra
# arrumar isso

ggplotly(p) |>
  plotly::layout(
  legend = list(orientation = "h")
)


# pela função plot_ly

dados_starwars |>
  filter(massa < 1000) |>
  plot_ly(
    x = ~massa,
    y = ~altura,
    color = ~genero,
    colors = hcl.colors(2)
  )

# grafico 1

p1 <- dados_starwars |>
  count(genero) |>
  ggplot() +
  aes(x = genero, y = n, fill = genero) +
  geom_col() +
  theme_minimal()

# com o plotly:

ggplotly(p1)

# grafico 2

p2 <- voos |>
  arrange(mes) |>
  mutate(mes = as_factor(mes)) |>
  count(mes, companhia_aerea) |>
  ggplot() +
  aes(x = mes, y = n,
      colour = companhia_aerea,
      group = companhia_aerea) +
  geom_line() +
  theme_minimal()

# com o plotly:

ggplotly(p2)



