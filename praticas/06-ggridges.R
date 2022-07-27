library(dados)
library(ggplot2)

# ggridges :)

library(ggridges)

diamante |> View()

# quero comparar a distribuicao de preco para diferentes cortes

# histograma

# horrivel
diamante |>
  ggplot() +
  aes(x = preco, fill = corte) +
  geom_histogram(position = "identity", alpha = .3)

# densidade

diamante |>
  ggplot() +
  aes(x = preco, fill = corte) +
  geom_density(alpha = .3)

# facet_wrap

diamante |>
  ggplot() +
  aes(x = preco, fill = corte) +
  geom_density(alpha = .3) +
  facet_wrap(~corte)


# com ggridges

# essa é a melhor
diamante |>
  ggplot() +
  aes(x = preco, fill = corte, y = corte) +
  geom_density_ridges(alpha = 0.4)


# otimizando o grafico :)

## adicionando quantis

diamante |>
  ggplot() +
  aes(x = preco, fill = corte, y = corte) +
  geom_density_ridges(alpha = 0.4,
                      quantile_lines = TRUE,
                      quantiles = 2)


## media geral

media_geral = mean(diamante$preco)

diamante |>
  ggplot() +
  aes(x = preco, fill = corte, y = corte) +
  geom_density_ridges(alpha = 0.4,
                      quantile_lines = TRUE,
                      quantiles = 2) +
  geom_vline(
    xintercept = media_geral,
    colour = "red",
    linetype = 2
  )


## tirando a legenda

diamante |>
  ggplot() +
  aes(x = preco, fill = corte, y = corte) +
  geom_density_ridges(alpha = 0.4,
                      quantile_lines = TRUE,
                      quantiles = 2,
                      show.legend = FALSE) +
  geom_vline(
    xintercept = media_geral,
    colour = "red",
    linetype = 2
  )


## mudando labels eixo y

estrela <- "★"

labs_estrela <- purrr::map_chr(1:5, ~paste(rep(estrela, .x), collapse = ""))

diamante |>
  ggplot() +
  aes(x = preco, fill = corte, y = corte) +
  geom_density_ridges(alpha = 0.4,
                      quantile_lines = TRUE,
                      quantiles = 2,
                      show.legend = FALSE) +
  geom_vline(
    xintercept = media_geral,
    colour = "red",
    linetype = 2
  ) +
  scale_y_discrete(labels = labs_estrela)


## mudando cores

diamante |>
  ggplot() +
  aes(x = preco, fill = corte, y = corte) +
  geom_density_ridges(alpha = 0.4,
                      quantile_lines = TRUE,
                      quantiles = 2,
                      show.legend = FALSE) +
  geom_vline(
    xintercept = media_geral,
    colour = "red",
    linetype = 2
  ) +
  scale_y_discrete(labels = labs_estrela) +
  scale_fill_viridis_d(
    option = "E"
  )


## valores em dollar

diamante |>
  ggplot() +
  aes(x = preco, fill = corte, y = corte) +
  geom_density_ridges(alpha = 0.4,
                      quantile_lines = TRUE,
                      quantiles = 2,
                      show.legend = FALSE) +
  geom_vline(
    xintercept = media_geral,
    colour = "red",
    linetype = 2
  ) +
  scale_y_discrete(labels = labs_estrela) +
  scale_fill_viridis_d(
    option = "E"
  ) +
  scale_x_continuous(labels = scales::dollar)


## modificando eixos


diamante |>
  ggplot() +
  aes(x = preco, fill = corte, y = corte) +
  geom_density_ridges(alpha = 0.4,
                      quantile_lines = TRUE,
                      quantiles = 2,
                      show.legend = FALSE) +
  geom_vline(
    xintercept = media_geral,
    colour = "red",
    linetype = 2
  ) +
  scale_y_discrete(labels = labs_estrela) +
  scale_fill_viridis_d(
    option = "E"
  ) +
  scale_x_continuous(labels = scales::dollar) +
  labs(x = "Preço",
       y = "Corte")



