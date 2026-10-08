# =============================================================================
# Exercícios 02 - Data frames
# =============================================================================
# Use a base `municipios` (simulada) e o dplyr.
# Solução em: solucoes/02_data_frames_solucoes.R
# =============================================================================

library(dplyr)
library(tidyr)
source("00_dados_exemplo.R")


# 1. Quantos municípios há em cada região? Ordene do maior para o menor.


# 2. Liste os 5 municípios com MAIOR gasto em saúde per capita, mostrando
#    só as colunas municipio, regiao e gasto_saude.


# 3. Crie a coluna `gasto_total` (gasto_saude * populacao) e, por região,
#    calcule o gasto total somado em milhões de reais.


# 4. Por região, calcule o IDH médio e o IDH máximo (atenção aos NA!)
#    e quantos municípios estão sem IDH.


# 5. Quais municípios do Sertão têm IDH acima da média do próprio Sertão?
#    Dica: group_by() + filter() funciona: a média é calculada por grupo.


# 6. Junte `municipios` com `regioes_info` e calcule o gasto médio em
#    saúde de municípios do litoral versus do interior.


# 7. Desafio: a tabela abaixo está no formato largo. Passe para o formato
#    longo, com as colunas: municipio, ano, matriculas. Depois calcule o
#    crescimento percentual de 2022 para 2024 em cada município.

matriculas <- data.frame(
  municipio = c("Município 01", "Município 02", "Município 03"),
  m2022 = c(1200, 850, 3100),
  m2023 = c(1250, 830, 3300),
  m2024 = c(1310, 800, 3420)
)
