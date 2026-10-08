# =============================================================================
# 03 - Funções
# =============================================================================
# Objetivo: escrever suas próprias funções para não repetir código, e
# aplicá-las em vários elementos de uma vez.
#
# Regra prática: se você copiou e colou o mesmo trecho 3 vezes, transforme
# em função.
# =============================================================================


# --- 1. Anatomia de uma função -----------------------------------------------

variacao_percentual <- function(inicial, final) {
  (final - inicial) / inicial * 100
}

variacao_percentual(200, 250)       # 25
variacao_percentual(c(100, 200), c(110, 150))  # funciona com vetores também!

# A última expressão avaliada é o valor devolvido. return() existe, mas
# costuma ser usado só para sair mais cedo da função.


# --- 2. Argumentos com valor padrão ------------------------------------------

formatar_reais <- function(valor, casas = 2) {
  paste0("R$ ", formatC(valor, format = "f", digits = casas,
                        big.mark = ".", decimal.mark = ","))
}

formatar_reais(1234567.891)
formatar_reais(1234567.891, casas = 0)

# Argumentos podem ser passados por nome, em qualquer ordem
formatar_reais(casas = 1, valor = 99.95)


# --- 3. Validar as entradas --------------------------------------------------
# Uma boa função reclama cedo e com uma mensagem clara.

taxa_por_mil <- function(eventos, populacao) {
  if (!is.numeric(eventos) || !is.numeric(populacao)) {
    stop("`eventos` e `populacao` precisam ser numéricos.")
  }
  if (any(populacao <= 0, na.rm = TRUE)) {
    warning("Há populações <= 0; o resultado nesses casos será NA.")
    populacao[populacao <= 0] <- NA
  }
  eventos / populacao * 1000
}

taxa_por_mil(35, 12000)
taxa_por_mil(c(10, 5), c(5000, 0))      # dá um aviso (warning)
# taxa_por_mil("35", 12000)             # descomente: dá erro (stop)


# --- 4. Controle de fluxo: if / else e for -----------------------------------

classificar_idh <- function(idh) {
  if (is.na(idh)) {
    "Sem dado"
  } else if (idh >= 0.8) {
    "Muito alto"
  } else if (idh >= 0.7) {
    "Alto"
  } else if (idh >= 0.55) {
    "Médio"
  } else {
    "Baixo"
  }
}

classificar_idh(0.72)
# classificar_idh(c(0.5, 0.9))  # erro! `if` só aceita UM valor.

# Para um vetor, temos duas saídas:
# (a) um loop for
valores <- c(0.50, 0.62, 0.75, NA, 0.85)
resultado <- character(length(valores))  # pré-aloca o vetor de saída
for (i in seq_along(valores)) {
  resultado[i] <- classificar_idh(valores[i])
}
resultado

# (b) a família apply (mais curta — veja a seção 6)
sapply(valores, classificar_idh)

# (c) ou reescrever de forma vetorizada, que costuma ser o melhor:
classificar_idh_vet <- function(idh) {
  cut(idh,
      breaks = c(-Inf, 0.55, 0.7, 0.8, Inf),
      labels = c("Baixo", "Médio", "Alto", "Muito alto"),
      right  = FALSE)
}
classificar_idh_vet(valores)


# --- 5. Funções que devolvem várias coisas -----------------------------------
# Devolva uma lista (ou um data frame).

descrever <- function(x) {
  list(
    n        = length(x),
    n_na     = sum(is.na(x)),
    media    = mean(x, na.rm = TRUE),
    dp       = sd(x, na.rm = TRUE),
    cv       = sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE) # coef. de variação
  )
}

d <- descrever(c(10, 12, NA, 15, 20))
d$media
str(d)


# --- 6. A família apply: aplicar uma função em vários elementos -------------

numeros <- list(a = 1:10, b = c(5, 50, 500), c = rnorm(100))

lapply(numeros, mean)   # devolve sempre uma LISTA
sapply(numeros, mean)   # tenta simplificar (aqui, para um vetor nomeado)
vapply(numeros, mean, numeric(1))  # como sapply, mas garante o tipo de saída

# Funções anônimas: \(x) é um atalho para function(x)
sapply(numeros, \(x) max(x) - min(x))

# Aplicar a mesma função em várias colunas de um data frame
source("00_dados_exemplo.R")
sapply(municipios[, c("populacao", "idh", "gasto_saude")],
       \(col) mean(col, na.rm = TRUE))


# --- 7. Funções + dplyr ------------------------------------------------------

library(dplyr)

municipios |>
  mutate(
    faixa_idh  = classificar_idh_vet(idh),
    gasto_fmt  = formatar_reais(gasto_saude)
  ) |>
  select(municipio, idh, faixa_idh, gasto_fmt) |>
  head()

# across(): aplica a mesma função em várias colunas dentro do dplyr
municipios |>
  group_by(regiao) |>
  summarise(across(c(populacao, idh, gasto_saude),
                   \(x) mean(x, na.rm = TRUE)))

# Funções que recebem nomes de colunas: use {{ }} ("curly-curly")
media_por_grupo <- function(dados, grupo, variavel) {
  dados |>
    group_by({{ grupo }}) |>
    summarise(media = mean({{ variavel }}, na.rm = TRUE), .groups = "drop")
}

media_por_grupo(municipios, regiao, gasto_saude)
media_por_grupo(municipios, regiao, idh)


# --- 8. Escopo: o que a função "enxerga" -------------------------------------

x <- 10
muda_x <- function() {
  x <- 999   # este x só existe DENTRO da função
  x
}
muda_x()  # 999
x         # continua 10 — a função não altera o ambiente de fora

# Boa prática: tudo que a função usa deve entrar pelos argumentos.


# =============================================================================
# Agora faça: exercicios/03_funcoes_exercicios.R
# =============================================================================
