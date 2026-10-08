# =============================================================================
# Soluções 02 - Data frames
# =============================================================================

library(dplyr)
library(tidyr)
source("00_dados_exemplo.R")

# 1.
municipios |> count(regiao, sort = TRUE)

# 2.
municipios |>
  arrange(desc(gasto_saude)) |>
  select(municipio, regiao, gasto_saude) |>
  head(5)
# alternativa: slice_max(municipios, gasto_saude, n = 5)

# 3.
municipios |>
  mutate(gasto_total = gasto_saude * populacao) |>
  group_by(regiao) |>
  summarise(gasto_milhoes = sum(gasto_total) / 1e6)

# 4.
municipios |>
  group_by(regiao) |>
  summarise(
    idh_medio = mean(idh, na.rm = TRUE),
    idh_max   = max(idh, na.rm = TRUE),
    sem_idh   = sum(is.na(idh))
  )

# 5.
municipios |>
  filter(regiao == "Sertão") |>
  filter(idh > mean(idh, na.rm = TRUE)) |>
  select(municipio, idh)

# 6.
municipios |>
  left_join(regioes_info, by = "regiao") |>
  group_by(litoral) |>
  summarise(gasto_medio = mean(gasto_saude))

# 7.
matriculas <- data.frame(
  municipio = c("Município 01", "Município 02", "Município 03"),
  m2022 = c(1200, 850, 3100),
  m2023 = c(1250, 830, 3300),
  m2024 = c(1310, 800, 3420)
)

longo <- matriculas |>
  pivot_longer(cols = starts_with("m20"),
               names_to = "ano",
               names_prefix = "m",          # tira o "m" de "m2022"
               values_to = "matriculas") |>
  mutate(ano = as.integer(ano))
longo

longo |>
  group_by(municipio) |>
  summarise(
    cresc_pct = (matriculas[ano == 2024] - matriculas[ano == 2022]) /
                 matriculas[ano == 2022] * 100
  )
