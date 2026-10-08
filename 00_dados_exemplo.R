# =============================================================================
# 00 - Dados de exemplo
# =============================================================================
# Este script cria uma base SIMULADA (inventada, não são dados reais) de
# municípios, usada nos módulos 02 e 04. Ele é chamado pelos outros scripts
# com source("00_dados_exemplo.R") — você não precisa rodá-lo sozinho.
#
# Por que simular? Assim os scripts funcionam sem internet e sem baixar nada.
# Depois, troque por dados reais (IBGE, DATASUS, INEP...) para praticar.
# =============================================================================

set.seed(2026) # garante que os números "aleatórios" sejam sempre os mesmos

n <- 40

municipios <- data.frame(
  municipio   = paste("Município", sprintf("%02d", 1:n)),
  regiao      = sample(c("Metropolitana", "Mata", "Agreste", "Sertão"),
                       n, replace = TRUE),
  populacao   = round(rlnorm(n, meanlog = 10, sdlog = 1)),
  idh         = round(runif(n, 0.50, 0.80), 3),
  gasto_saude = round(runif(n, 300, 1200), 2), # R$ per capita
  ano         = 2024
)

# Alguns valores faltantes de propósito, para treinar o tratamento de NA
municipios$idh[c(5, 18, 33)] <- NA

# Base pequena e separada, para treinar junções (joins) no módulo 02
regioes_info <- data.frame(
  regiao   = c("Metropolitana", "Mata", "Agreste", "Sertão"),
  litoral  = c(TRUE, TRUE, FALSE, FALSE)
)
