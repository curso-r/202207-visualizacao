# highcharter -------------------------------------------------------------

library(dados)
library(tidyverse)
library(highcharter)

# dispersao

dados_starwars |>
  filter(massa < 1000) |>
  hchart("scatter",
         hcaes(
           x = massa,
           y = altura,
           group = genero
         ))

# barras

dados_starwars |>
  count(sexo_biologico) |>
  hchart(
    "bar",
    hcaes(
      x = sexo_biologico,
      y = n
    )
  )


# grafico 1

p1 <- dados_starwars |>
  count(genero) |>
  ggplot() +
  aes(x = genero, y = n, fill = genero) +
  geom_col() +
  theme_minimal()

# com o highcharter:

dados_starwars |>
  count(genero) |>
  hchart("column",
         hcaes(
           x = genero,
           y = n,
           group = genero
         ))

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

# com o highcharter:

voos |>
  arrange(mes) |>
  mutate(mes = as_factor(mes)) |>
  count(mes, companhia_aerea) |>
  hchart(
    "line",
    hcaes(
      x = mes,
      y = n,
      group = companhia_aerea
    )
  )



