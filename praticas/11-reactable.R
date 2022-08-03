# reactable ---------------------------------------------------------------

library(tidyverse)
library(dados)
library(reactable)

pinguins |> View()

dados_summ <- pinguins |>
  group_by(ano, ilha) |>
  summarise(
    bico_medio = mean(comprimento_bico,na.rm = TRUE),
    massa_media = mean(massa_corporal, na.rm = TRUE)
  ) |>
  pivot_wider(
    names_from = ano,
    values_from = c(bico_medio, massa_media)
  )

dados_summ |> View()

# o jeito mais simples é:

dados_summ |> reactable()

# customizando:

dados_summ |> reactable(
  columns = list(
    ilha = colDef(
      "Ilha"),
    bico_medio_2007 = colDef(
      "2007",
      format = colFormat(digits = 2)
    ),
    bico_medio_2008 = colDef(
      "2008",
      format = colFormat(digits = 2)
    ),
    bico_medio_2009 = colDef(
      "2009",
      format = colFormat(digits = 2)
    ),
    massa_media_2007 = colDef(
      "2007",
      format = colFormat(
        digits = 2,
        separators = TRUE
      )),
      massa_media_2008 = colDef(
        "2008",
        format = colFormat(
          digits = 2,
          separators = TRUE
        )),
        massa_media_2009 = colDef(
          "2009",
          format = colFormat(
            digits = 2,
            separators = TRUE
          ))
    ),
  columnGroups = list(
    colGroup(
      name = "Bico Médio",
      columns = c(
        "bico_medio_2007",
        "bico_medio_2008",
        "bico_medio_2009"
      )
    ),
  colGroup(
    name = "Massa Média",
    columns = c(
      "massa_media_2007",
      "massa_media_2008",
      "massa_media_2009"
    )
  )
  ),
  striped = TRUE,
  highlight = TRUE
)




