# =============================================================================
# Soluções 03 - Funções
# =============================================================================

library(dplyr)
source("00_dados_exemplo.R")

# 1.
per_capita <- function(valor, populacao) {
  valor / populacao
}
per_capita(1e6, 25000)  # 40

# 2.
padronizar <- function(x) {
  (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
}
head(padronizar(municipios$idh))
# confere: a média do z-score é ~0 e o desvio é 1
mean(padronizar(municipios$idh), na.rm = TRUE)

# 3 e 4.
resumo_numerico <- function(x, casas = 2) {
  if (!is.numeric(x)) {
    stop("`x` precisa ser numérico, mas é ", class(x)[1], ".")
  }
  data.frame(
    n       = length(x),
    n_na    = sum(is.na(x)),
    media   = round(mean(x, na.rm = TRUE), casas),
    mediana = round(median(x, na.rm = TRUE), casas),
    min     = round(min(x, na.rm = TRUE), casas),
    max     = round(max(x, na.rm = TRUE), casas)
  )
}
resumo_numerico(municipios$gasto_saude)
try(resumo_numerico(municipios$regiao))  # try() mostra o erro sem parar o script

# 5.
vapply(municipios[, c("populacao", "idh", "gasto_saude")],
       \(x) median(x, na.rm = TRUE),
       numeric(1))

# 6.
ranking <- function(dados, variavel, n = 3) {
  dados |>
    arrange(desc({{ variavel }})) |>
    select(municipio, {{ variavel }}) |>
    head(n)
}
ranking(municipios, idh)
ranking(municipios, gasto_saude, n = 5)
