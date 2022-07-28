library(tidyverse)
library(dados)
library(gganimate)
## instale esses tambem
# av
# gifski

# hans rosling
anim <- dados_gapminder |>
  ggplot() +
  aes(
    x = expectativa_de_vida,
    y = log10(pib_per_capita),
    size = log10(populacao)
  ) +
  geom_point() +
  facet_wrap(~continente) +
  theme_minimal(15) +
  labs(
    x = "Expectativa de vida",
    y = "log10(Pib per capita)",
    title = "Ano: {frame_time}"
  ) +
  gganimate::transition_time(ano)

## estilo glue
# variavel <- "Elizabeth"
# glue::glue("Olá, {variavel}")

anim

gganimate::animate(
  anim,
  nframes = 40,
  duration = 10,
  start_pause = 2,
  end_pause = 2,
  width = 800,
  height = 400,
  renderer = gifski_renderer(
    file = "praticas/gapminder.gif"
  )
)

gganimate::animate(
  anim,
  nframes = 40,
  duration = 10,
  start_pause = 2,
  end_pause = 2,
  width = 800,
  height = 400,
  renderer = av_renderer(
    file = "praticas/gapminder.mp4"
  )
)

## enfase/destaque

anim_brasil <- dados_gapminder |>
  filter(continente == "Américas") |>
  ggplot() +
  aes(
    x = expectativa_de_vida,
    y = log10(pib_per_capita),
    size = log10(populacao)
  ) +
  geom_point() +
  gghighlight::gghighlight(
    pais == "Brasil",
    label_key = pais
  ) +
  theme_minimal(15) +
  labs(
    x = "Expectativa de vida",
    y = "log10(Pib per capita)",
    title = "Ano: {frame_time}"
  ) +
  gganimate::transition_time(ano)

gganimate::animate(
  anim_brasil,
  nframes = 60,
  duration = 10,
  start_pause = 10,
  end_pause = 10,
  width = 800,
  height = 400
)


# mudando o transition

anim_brasil_reveal <- dados_gapminder |>
  filter(continente == "Américas") |>
  ggplot() +
  aes(
    x = expectativa_de_vida,
    y = log10(pib_per_capita),
    size = log10(populacao)
  ) +
  geom_line() +
  gghighlight::gghighlight(
    pais == "Brasil",
    label_key = pais
  ) +
  theme_minimal(15) +
  labs(
    x = "Expectativa de vida",
    y = "log10(Pib per capita)",
    title = "Ano: {frame_time}"
  ) +
  gganimate::transition_reveal(
    expectativa_de_vida,
    keep_last = TRUE
  )

gganimate::animate(
  anim_brasil_reveal,
  nframes = 60,
  duration = 10,
  start_pause = 10,
  end_pause = 10,
  width = 800,
  height = 400
)

voos |>
  distinct(mes, .keep_all = TRUE) |>
  ggplot(aes(x = mes, y = tempo_voo)) +
  geom_line() +
  gganimate::transition_reveal(
    mes,
    keep_last = TRUE
  )
