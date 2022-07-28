library(tidyverse)
library(dados)
library(ggtext)

dados_starwars |>
  ggplot(aes(massa, altura)) +
  geom_point() +
  labs(
    x = "Massa **kg**",
    y = "Altura <b>aaaaa</b>"
  ) +
  theme(
    axis.title.x = element_markdown(),
    axis.title.y = element_markdown()
  )

base <- ggplot(data.frame(x = c(-5, 5)), aes(x)) +
  stat_function(fun = ~ .x*.x)

base +
  labs(
    x = "independent variable *x*",
    y = "dependent variable *y* = *x*<sup>2</sup>"
  ) +
  theme(
    axis.title.x = element_markdown(),
    axis.title.y = element_markdown()
  )

library(tidyverse)
library(dados)

# vamos fazer um bd de pokemons
pokemons <- c("pikachu", "bulbasaur", "squirtle", "charmander")
infos_pokemon <- function(pokemon) {
  u <- paste0("https://pokeapi.co/api/v2/pokemon/", pokemon)
  r <- httr::GET(u)
  j <- httr::content(r)
  tibble::tibble(
    pokemon = pokemon,
    attack = j$stats[[1]]$base_stat,
    img = j$sprites$front_default
  )
}

da_pokemon <- purrr::map_dfr(pokemons, infos_pokemon) |>
  mutate(pokemon = fct_reorder(pokemon, attack)) |>
  arrange(pokemon)

gg_base <- da_pokemon |>
  ggplot() +
  geom_segment(
    aes(x = 0, xend = attack, y = pokemon, yend = pokemon)
  ) +
  geom_point(
    aes(x = attack, y = pokemon, colour = pokemon),
    size = 7,
    show.legend = FALSE
  ) +
  scale_colour_manual(
    values = rev(c("darkgreen", "royalblue", "red", "gold"))
  ) +
  theme_minimal(16)

gg_base

## No windows...
extrafont::font_import("exemplos_de_aula/fontes", prompt = FALSE)
extrafont::loadfonts("win")


gg_base +
  labs(
    title = "Pokémon!!",
    x = "Poder de ataque"
  ) +
  scale_y_discrete(
    name = NULL,
    labels = glue::glue("<img src='{da_pokemon$img}'>")
  ) +
  theme(
    plot.title = element_text(family = "Pokemon Hollow", size = 50),
    axis.title = element_text(family = "Pokemon Hollow", size = 20),
    axis.text.y = ggtext::element_markdown()
  )
