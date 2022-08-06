library(tidyverse)
library(leaflet)
library(dados)
library(abjData)

pnud_min

## pacote {sf}
dados_geobr <- geobr::read_municipality("AL")



# mapa de marcadores ------------------------------------------------------

pnud_min |>
  filter(ano == 2010, uf_sigla == "AL") |>
  leaflet() |>
  addTiles() |>
  # addTiles(urlTemplate = "https://tile.memomaps.de/tilegen/${z}/${x}/${y}.png")
  addMarkers(
    lng = ~lon,
    lat = ~lat,
    popup = ~muni_nm,
    clusterOptions = markerClusterOptions()
  )

links_imagens <- c(
  "https://upload.wikimedia.org/wikipedia/commons/b/bb/Bandeira_%C3%81gua_Branca.png",
  "https://upload.wikimedia.org/wikipedia/commons/8/8e/Bandeira_Anadia.png"
)

pnud_min |>
  filter(ano == 2010, uf_sigla == "AL") |>
  slice(1:2) |>
  mutate(
    img = glue::glue("{muni_nm}!!!<br/><img src='{links_imagens}' />"),
    img = map(img, htmltools::HTML)
  ) |>
  leaflet() |>
  addTiles() |>
  # addTiles(urlTemplate = "https://tile.memomaps.de/tilegen/${z}/${x}/${y}.png")
  addCircleMarkers(
    lng = ~lon,
    lat = ~lat,
    label = ~img,
    radius = ~idhm*10
  )

# leaflet::addRasterImage()


# mapa temático -----------------------------------------------------------





dados_plotar <- dados_geobr |>
  mutate(code_muni = as.character(code_muni)) |>
  inner_join(
    pnud_min |> filter(ano == "2010"),
    c("code_muni" = "muni_id")
  )

escala_numerica <- colorNumeric("YlOrRd", dados_plotar$idhm)
escala_numerica(0.5)
escala_numerica(0.6)

dados_plotar |>
  leaflet() |>
  addTiles() |>
  addPolygons(
    fillColor = ~escala_numerica(idhm),
    color = NULL,
    fillOpacity = 1,
    stroke = 0,
    label = ~muni_nm
  )

# sf package --------------------------------------------------------------

dados_plotar |>
  ggplot(aes(fill = idhm)) +
  geom_sf()
