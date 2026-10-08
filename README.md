# Estudos de R

Roteiro de estudos em R, do básico ao intermediário, em 4 módulos. Cada
módulo tem um script comentado para ler e rodar linha a linha, uma lista de
exercícios e as soluções.

## Como usar

1. Instale o [R](https://cran.r-project.org/) e o [RStudio](https://posit.co/download/rstudio-desktop/).
2. Abra o arquivo `estudos-R.Rproj`. Ele faz do RStudio já abrir na pasta
   certa, e é por isso que os `source("00_dados_exemplo.R")` funcionam.
3. Instale os pacotes uma única vez, no console:
   ```r
   install.packages(c("dplyr", "tidyr", "ggplot2"))
   ```
4. Siga os módulos em ordem. Para cada um:
   - abra o script, rode linha a linha com **Ctrl+Enter** e leia os comentários;
   - modifique os exemplos, quebre de propósito, veja o que acontece;
   - faça os exercícios em `exercicios/` **antes** de olhar `solucoes/`.

Como você já sabe um pouco, as primeiras seções de cada módulo ("revisão
rápida") podem ser lidas por cima. O conteúdo novo costuma estar a partir da
metade.

## Roteiro

| # | Módulo | O que você vai aprender | Exercícios |
|---|--------|-------------------------|------------|
| 0 | `00_dados_exemplo.R` | Base de municípios **simulada** usada nos módulos 2–4 (não precisa rodar sozinho) | – |
| 1 | `01_vetores.R` | Tipos e coerção, vetorização, indexação lógica, `NA`, fatores, `ifelse`/`cut`, listas | `exercicios/01_vetores_exercicios.R` |
| 2 | `02_data_frames.R` | Inspecionar tabelas, base R x `dplyr`, `group_by` + `summarise`, joins, `pivot_longer`/`pivot_wider`, ler/salvar CSV | `exercicios/02_data_frames_exercicios.R` |
| 3 | `03_funcoes.R` | Criar funções, argumentos padrão, validação com `stop`, `if`/`for`, família `apply`, `across`, funções com `{{ }}` | `exercicios/03_funcoes_exercicios.R` |
| 4 | `04_ggplot2.R` | Gramática dos gráficos, dispersão, barras, histograma/boxplot, séries, facetas, temas, `ggsave` | `exercicios/04_ggplot2_exercicios.R` |

Sugestão de ritmo: um módulo por semana, sendo uma sessão para o script e
outra para os exercícios.

## Quando travar

- `?nome_da_funcao` no console abre a ajuda, e os exemplos ficam no fim da página.
- `str(objeto)` mostra o que um objeto é por dentro. É a ferramenta de
  diagnóstico mais útil que existe.
- Acentos aparecendo estranhos (`Ã§`, `sa..de`)? No RStudio, use
  *File > Reopen with Encoding > UTF-8*. Os arquivos deste projeto são UTF-8.
- Copie a mensagem de erro e pesquise. Quase sempre alguém já passou por ela.

## Próximos passos (depois do módulo 4)

- Trocar a base simulada por dados reais (IBGE, DATASUS, INEP, TSE). Os
  pacotes `sidrar`, `basedosdados` e `geobr` facilitam o acesso.
- Relatórios reprodutíveis com Quarto (`.qmd`).
- Estatística: `lm()`, `glm()`, testes de hipótese e o pacote `broom`.
- Mapas com `geobr` + `ggplot2` (`geom_sf`).
