library(ggplot2)

# colocando o fundo preto no grafico
p <- ggplot() +
  theme(plot.background = element_rect(fill = "black"),
        panel.background = element_rect(fill = "black"))

# mudando o background do grafico para imagem

ggimage::ggbackground(p, "/Users/julio/Downloads/logo_corinthians_001.jpg")

mtcars |>
  ggplot(aes(factor(vs), mpg)) +
  geom_boxplot()

ggimage::geom_pokemon()

# adicionando imagens no lugar de pontos
mtcars |>
  ggplot(aes(disp, mpg)) +
  ggimage::geom_image(aes(image = "/Users/julio/Downloads/logo_corinthians_001.jpg"))

# adicionando linhas no grafico

modelo <- lm(mpg ~ disp, data = mtcars)
parms <- coef(modelo)

mtcars |>
  ggplot(aes(disp, mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

mtcars |>
  ggplot(aes(disp, mpg)) +
  geom_point() +
  geom_abline(intercept = parms[1], slope = parms[2])
