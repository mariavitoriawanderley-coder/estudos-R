# =============================================================================
# 02 - Data frames
# =============================================================================
# Objetivo: ler, inspecionar, filtrar, transformar e resumir tabelas.
# Primeiro do jeito "base R", depois com dplyr (tidyverse), que é o que
# você mais vai usar no dia a dia.
#
# Pacotes necessários (instale uma vez só):
#   install.packages(c("dplyr", "tidyr"))
# =============================================================================

source("00_dados_exemplo.R") # cria os objetos `municipios` e `regioes_info`


# --- 1. Inspecionar ----------------------------------------------------------

head(municipios)       # primeiras 6 linhas
tail(municipios, 3)
dim(municipios)        # linhas x colunas
nrow(municipios)
names(municipios)      # nomes das colunas
str(municipios)        # tipo de cada coluna
summary(municipios)    # resumo estatístico de cada coluna

# No RStudio, View(municipios) abre a tabela numa aba (tipo planilha).


# --- 2. Base R: acessar colunas e linhas -------------------------------------
# Sintaxe: dados[LINHAS, COLUNAS]

municipios$populacao                # uma coluna = um vetor
municipios[1:3, ]                   # linhas 1 a 3, todas as colunas
municipios[, c("municipio", "idh")] # todas as linhas, 2 colunas
municipios[municipios$regiao == "Sertão", ]

# Criar uma coluna nova
municipios$pop_mil <- municipios$populacao / 1000

# Tudo o que você aprendeu de vetores vale aqui, coluna por coluna
mean(municipios$idh, na.rm = TRUE)
table(municipios$regiao)

# Agregar por grupo (base R)
aggregate(gasto_saude ~ regiao, data = municipios, FUN = mean)


# --- 3. dplyr: o jeito "tidy" ------------------------------------------------
# Os verbos principais:
#   filter()    -> escolhe LINHAS por condição
#   select()    -> escolhe COLUNAS
#   mutate()    -> cria/altera colunas
#   arrange()   -> ordena
#   summarise() -> resume (média, soma, contagem...)
#   group_by()  -> faz as operações seguintes por grupo
#
# O pipe |> ("e então") passa o resultado de um passo para o próximo.
# (Você também vai ver %>% em códigos antigos — funciona igual.)

library(dplyr)

municipios |>
  filter(regiao == "Agreste", populacao > 20000) |>
  select(municipio, populacao, idh) |>
  arrange(desc(populacao))

# mutate com várias colunas e condições
municipios <- municipios |>
  mutate(
    porte = case_when(
      populacao < 20000  ~ "Pequeno",
      populacao < 100000 ~ "Médio",
      TRUE               ~ "Grande"     # "todo o resto"
    ),
    porte = factor(porte, levels = c("Pequeno", "Médio", "Grande")),
    idh_alto = idh >= 0.7
  )

# Resumo por grupo — provavelmente o padrão mais útil de todos
resumo_regiao <- municipios |>
  group_by(regiao) |>
  summarise(
    n_municipios   = n(),
    pop_total      = sum(populacao),
    idh_medio      = mean(idh, na.rm = TRUE),
    gasto_mediano  = median(gasto_saude),
    .groups = "drop"
  ) |>
  arrange(desc(idh_medio))

resumo_regiao

# count() é um atalho para group_by + summarise(n = n())
municipios |> count(regiao, porte)


# --- 4. Lidar com NA em tabelas ----------------------------------------------

municipios |> filter(is.na(idh))            # quais linhas têm NA
colSums(is.na(municipios))                   # NA por coluna
municipios |> filter(!is.na(idh)) |> nrow()  # quantas linhas completas

# Atenção: filter(idh > 0.7) já descarta os NA silenciosamente.


# --- 5. Juntar tabelas (joins) -----------------------------------------------
# left_join mantém todas as linhas da tabela da esquerda e traz as colunas
# da direita que casam pela chave (`by`).

municipios <- municipios |>
  left_join(regioes_info, by = "regiao")

municipios |> select(municipio, regiao, litoral) |> head()

# Outros: inner_join (só o que casa), anti_join (o que NÃO casa — ótimo
# para achar erros de digitação nas chaves), full_join (tudo).


# --- 6. Formato longo x largo (tidyr) ----------------------------------------
# Muitas bases públicas vêm "largas" (um ano por coluna). Para analisar e
# para o ggplot, normalmente queremos "longo" (uma linha por observação).

library(tidyr)

largo <- data.frame(
  regiao = c("Mata", "Sertão"),
  `2022` = c(0.61, 0.58),
  `2023` = c(0.62, 0.59),
  `2024` = c(0.64, 0.60),
  check.names = FALSE  # permite nomes de coluna que começam com número
)
largo

longo <- largo |>
  pivot_longer(cols = -regiao, names_to = "ano", values_to = "idh") |>
  mutate(ano = as.integer(ano))
longo

# E o caminho de volta
longo |> pivot_wider(names_from = ano, values_from = idh)


# --- 7. Ler e salvar arquivos ------------------------------------------------
# Salvando em CSV (padrão brasileiro: separador ";" e decimal ","):

write.csv2(resumo_regiao, "resumo_regiao.csv", row.names = FALSE)
lido <- read.csv2("resumo_regiao.csv")
head(lido)
file.remove("resumo_regiao.csv") # limpando o exemplo

# Para arquivos reais você vai usar muito:
#   readr::read_csv() / readr::read_csv2()  -> CSV, mais rápido
#   readxl::read_excel()                    -> planilhas .xlsx
#   haven::read_dta() / read_sav()          -> Stata / SPSS
# Dica: se aparecerem caracteres estranhos (Ã§), tente
#   read.csv2("arquivo.csv", fileEncoding = "latin1")


# =============================================================================
# Agora faça: exercicios/02_data_frames_exercicios.R
# =============================================================================
