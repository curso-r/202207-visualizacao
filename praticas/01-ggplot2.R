


# revisão ggplot2 ---------------------------------------------------------

library(tidyverse)
library(dados)


# starwars ----------------------------------------------------------------

dados_starwars
glimpse(dados_starwars)

## primeiro passo: a base

## tapetinho cinza
ggplot()

dados_starwars |>
  ggplot()


## segundo passo: mapeamento estético

dados_starwars |>
  ggplot(aes(x = massa))

dados_starwars |>
  ggplot() +
  aes(x = massa)

dados_starwars |>
  ggplot() +
  aes(x = massa, y = altura)

dados_starwars |>
  ggplot() +
  aes(massa, altura)

dados_starwars |>
  ggplot(aes(massa, altura))

ggplot(dados_starwars, aes(massa, altura))

# outros mapeamentos
dados_starwars |>
  ggplot() +
  aes(massa, altura, colour = sexo_biologico)

## terceiro passo: formas geométricas

## temos muitos geom_* disponíveis. Uma forma de agrupar é
## geoms "individuais" (representa uma linha da base)
## geoms "agrupados" (representam um resumo ou conjunto de linhas)

### geom_point

dados_starwars |>
  ggplot() +
  aes(massa, altura, colour = genero) +
  geom_point()

## obs: não é de bom tom usar azul para masculino
## e vermelho para vermelho

# certo
dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura) +
  geom_point(colour = "royalblue")


# errado
dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura) +
  geom_point(colour = genero)


# errado
dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(massa, altura, colour = "royalblue") +
  geom_point()

## aes() dentro da geom vs aes() global

base_complementar <- dados_starwars |>
  filter(altura < 150) |>
  rename(
    altura2 = altura,
    massa2 = massa
  )

dados_filtrados <- dados_starwars |>
  filter(massa < 1000)

ggplot() +
  geom_point(
    aes(massa, altura, colour = genero),
    size = 4,
    data = dados_filtrados
  ) +
  geom_point(
    aes(massa2, altura2),
    data = base_complementar
  )

# scale_x_continuous()
# scale_y_continuous(sec.axis = )

## geom_bar e geom_col

# geom_bar : faz conta

dados_starwars |>
  ggplot() +
  aes(x = genero) +
  geom_bar()

# geom_col : NAO faz conta
dados_starwars |>
  count(genero) |>
  ggplot() +
  aes(x = genero, y = n) +
  geom_col()

### geom_line

voos |>
  count(mes, companhia_aerea) |>
  ggplot() +
  aes(x = mes, y = n, colour = companhia_aerea) +
  geom_line()

# e se mes não for numerico?

# as.factor(c("1", "4", "10", "2"))
# as_factor(c("1", "4", "10", "2"))

voos |>
  arrange(mes) |>
  mutate(mes = as_factor(mes)) |>
  count(mes, companhia_aerea) |>
  ggplot() +
  aes(x = mes, y = n,
      colour = companhia_aerea,
      group = companhia_aerea) +
  geom_line()

## geom_histogram e geom_density

dados_starwars |>
  ggplot() +
  aes(x = altura) +
  geom_histogram(bins = 10)

dados_starwars |>
  ggplot() +
  aes(x = altura) +
  geom_density()

dados_starwars |>
  ggplot() +
  aes(x = altura, y = ..density..) +
  geom_histogram(binwidth = 10) +
  geom_density()


dados_starwars |>
  ggplot() +
  aes(x = altura, y = ..density..) +
  geom_histogram(bins = 10) +
  geom_density(
    fill = "royalblue",
    alpha = .6
  ) +
  scale_x_continuous(
    labels = function(x) paste0(x, "m")
  ) +
  theme_minimal(16)


dados_starwars |>
  count

dados_starwars |>
  ggplot() +
  aes(x = altura, y = ..density..) +
  geom_histogram(bins = 10) +
  geom_density(
    fill = "royalblue",
    alpha = .6
  ) +
  scale_x_continuous(
    labels = scales::label_math(mu[.x])
  ) +
  theme_minimal(16)

## mais alguma coisa?

dados_starwars |>
  drop_na(massa, altura) |>
  esquisse::esquisser()

drop_na(dados_starwars, massa, altura) %>%
  filter(massa >= 15L & massa <= 823L) %>%
  ggplot() +
  aes(x = massa, y = altura) +
  geom_point(
    shape = "circle",
    size = 3.25,
    colour = "#112446"
  ) +
  geom_smooth(span = 1L) +
  theme_minimal()

## facets
## coords
