# =============================================================================
# Exercícios 03 - Funções
# =============================================================================
# Solução em: solucoes/03_funcoes_solucoes.R
# =============================================================================

library(dplyr)
source("00_dados_exemplo.R")


# 1. Escreva `per_capita(valor, populacao)` que devolve valor / populacao.
#    Teste com per_capita(1e6, 25000).


# 2. Escreva `padronizar(x)` que devolve o z-score: (x - média) / desvio,
#    ignorando NA. Teste em municipios$idh.


# 3. Escreva `resumo_numerico(x, casas = 2)` que devolve um data frame de
#    1 linha com n, n_na, media, mediana, min e max, arredondados em `casas`.
#    Aplique em municipios$gasto_saude.


# 4. Faça a função do exercício 3 dar erro com mensagem clara se `x`
#    não for numérico. Teste com resumo_numerico(municipios$regiao).


# 5. Use sapply (ou vapply) para calcular a mediana de cada uma das colunas
#    populacao, idh e gasto_saude.


# 6. Desafio: escreva `ranking(dados, variavel, n = 3)` que devolve os `n`
#    municípios com os maiores valores de `variavel` (nome de coluna sem
#    aspas, use {{ }}). Teste: ranking(municipios, idh)
