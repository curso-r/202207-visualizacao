library(tidyverse)
library(dados)


# temas -------------------------------------------------------------------

# theme_set(theme_minimal())

# mapeando variavel qualitativa nas cores

p1 <- dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa, y = altura, color = sexo_biologico) +
  geom_point(size = 3) +
  theme_minimal()

p1

# mapeando variavel quantitativa nas cores

p2 <- dados_starwars |>
  filter(massa < 1000) |>
  ggplot() +
  aes(x = massa, y = altura, color = log10(ano_nascimento)) +
  geom_point(size = 3) +
  theme_minimal()

p2


# cores -------------------------------------------------------------------

# brewer: variaveis discretas
# distiller: continuas
# fermenter: continuas -> discretas

# variaveis discretas

p1 +
  scale_color_brewer(
    palette = "Pastel2",
    na.value = "#000000"
  )

# viridis

p1 +
  scale_color_viridis_d(
    option = "D",
    na.value = "#000000",
    begin = .7,
    end = .8
  )

# manual

p1 +
  scale_color_manual(
    values = c("#ff0000", "blue", "green"),
    na.value = "yellow"
  )

# rainbow()
# hcl.colors()

p1 +
  scale_color_manual(
    values = rainbow(3, alpha = 0.5),
    na.value = "yellow"
  )

p1 +
  scale_color_manual(
    values = hcl.colors(3),
    na.value = "yellow"
  )


# variaveis continuas:

# distiller

p2 +
  scale_color_distiller(
    palette = "Oranges",
    direction = 1
  )

# fermenter

p2 +
  scale_color_fermenter(
    palette = "Oranges",
    direction = 1
  )

# viridis

p2 +
  scale_color_viridis_c(
    option = "D",
    begin = .2,
    end = .8
  )

p2 +
  scale_color_viridis_b(
    option = "D",
    begin = .2,
    end = .8,
    direction = -1
  )

p2 +
  scale_color_gradient(
    low = "#ff0000",
    high = "black",
    na.value = "yellow"
  )


# mais um pouco sobre os temas --------------------------------------------

# install.packages("ggthemes")
# install.packages("tvthemes")

p1 +
  ggthemes::theme_solarized() +
  ggthemes::scale_color_solarized()

p1 +
  tvthemes::theme_simpsons() +
  tvthemes::scale_color_simpsons()


# pacote tvthemes ---------------------------------------------------------

p1 +
  tvthemes::scale_colour_spongeBob() +
  tvthemes::theme_spongeBob(title.size = 40, text.font = "Some Time Later") +
  labs(title = "Duas horas depois...")


p1 +
  tvthemes::scale_colour_brooklyn99() +
  tvthemes::theme_brooklyn99(
    title.size = 40,
    text.font = "Roboto Condensed"
  ) +
  labs(title = "Cool, cool, cool, cool, cool...")

# FONTES

## No windows...
extrafont::font_import("exemplos_de_aula/fontes", prompt = FALSE)
extrafont::loadfonts("win")

## No Mac/Linux basta instalar as fontes e reiniciar a sessão


# pacote ghibli -----------------------------------------------------------

p1 +
  ghibli::scale_color_ghibli_d(
    "LaputaMedium",
    direction = -1,
    na.value = "#000000"
  )

# monte o seu e jogue aqui:
# https://docs.google.com/document/d/12TOFqX1Ci-Yn8xPY9y5XT-GQYAju6ObzN-Fy55BbEYE/edit#
