# =============================================================================
# 04 - Gráficos com ggplot2
# =============================================================================
# Objetivo: entender a "gramática dos gráficos" e montar gráficos de
# publicação em camadas.
#
# A receita de todo ggplot:
#   ggplot(DADOS, aes(MAPEAMENTOS)) +   # que colunas vão em x, y, cor...
#     geom_XXX() +                       # que forma desenhar
#     labs() + theme()                   # títulos e aparência
#
# Pacotes: install.packages(c("ggplot2", "dplyr"))
# =============================================================================

library(ggplot2)
library(dplyr)

source("00_dados_exemplo.R")
municipios <- municipios |>
  mutate(regiao = factor(regiao,
                         levels = c("Metropolitana", "Mata",
                                    "Agreste", "Sertão")))


# --- 1. Dispersão: relação entre duas variáveis numéricas --------------------

ggplot(municipios, aes(x = gasto_saude, y = idh)) +
  geom_point()

# Adicionando cor por grupo e uma linha de tendência
ggplot(municipios, aes(x = gasto_saude, y = idh)) +
  geom_point(aes(color = regiao), size = 3, alpha = 0.8) +
  geom_smooth(method = "lm", se = TRUE, color = "grey30") +
  labs(
    title    = "IDH x gasto em saúde per capita",
    subtitle = "Dados simulados, 2024",
    x        = "Gasto em saúde (R$ per capita)",
    y        = "IDH",
    color    = "Região"
  )

# Observação: o aviso "Removed 3 rows" vem dos NA do IDH. É esperado.

# Diferença importante:
#   aes(color = regiao)  -> cor DEPENDE dos dados (vai para a legenda)
#   color = "steelblue"  -> cor FIXA (fora do aes)


# --- 2. Barras: contagens e valores por categoria ----------------------------

# geom_bar conta as linhas sozinho
ggplot(municipios, aes(x = regiao)) +
  geom_bar(fill = "steelblue")

# geom_col usa um valor que você já calculou
resumo <- municipios |>
  group_by(regiao) |>
  summarise(gasto_medio = mean(gasto_saude))

ggplot(resumo, aes(x = reorder(regiao, gasto_medio), y = gasto_medio)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = round(gasto_medio)), hjust = -0.2) +
  coord_flip() +                       # barras horizontais: leitura mais fácil
  expand_limits(y = max(resumo$gasto_medio) * 1.1) +
  labs(x = NULL, y = "Gasto médio em saúde (R$ per capita)")

# Barras empilhadas x lado a lado
ggplot(municipios, aes(x = regiao, fill = idh >= 0.65)) +
  geom_bar(position = "dodge") +       # troque por "stack" ou "fill"
  labs(fill = "IDH >= 0,65")


# --- 3. Distribuições: histograma e boxplot ----------------------------------

ggplot(municipios, aes(x = gasto_saude)) +
  geom_histogram(bins = 10, fill = "grey60", color = "white")

ggplot(municipios, aes(x = regiao, y = gasto_saude)) +
  geom_boxplot(fill = "grey90") +
  geom_jitter(width = 0.15, alpha = 0.6)  # mostra os pontos por cima

# População é muito assimétrica: escala log ajuda a enxergar
ggplot(municipios, aes(x = populacao)) +
  geom_histogram(bins = 15) +
  scale_x_log10(labels = scales::label_number(big.mark = "."))


# --- 4. Linhas: séries temporais ---------------------------------------------

serie <- expand.grid(ano = 2015:2024, regiao = levels(municipios$regiao)) |>
  mutate(cobertura = 50 + (ano - 2015) * runif(n(), 1, 3) +
                     as.integer(regiao) * 3)

ggplot(serie, aes(x = ano, y = cobertura, color = regiao)) +
  geom_line(linewidth = 1) +
  geom_point() +
  scale_x_continuous(breaks = 2015:2024) +
  labs(y = "Cobertura (%)", x = NULL, color = NULL,
       title = "Evolução da cobertura por região (simulado)")


# --- 5. Facetas: um gráfico por grupo ----------------------------------------

ggplot(municipios, aes(x = gasto_saude, y = idh)) +
  geom_point() +
  facet_wrap(~ regiao, ncol = 2) +
  labs(x = "Gasto em saúde (R$ per capita)", y = "IDH")


# --- 6. Deixar bonito: temas, escalas e rótulos ------------------------------

grafico_final <- ggplot(municipios,
                        aes(x = gasto_saude, y = idh, color = regiao)) +
  geom_point(size = 3, alpha = 0.85) +
  scale_color_brewer(palette = "Dark2") +
  scale_x_continuous(labels = scales::label_dollar(prefix = "R$ ",
                                                   big.mark = ".",
                                                   decimal.mark = ",")) +
  labs(
    title    = "IDH x gasto em saúde por município",
    subtitle = "Cada ponto é um município",
    caption  = "Fonte: dados simulados para fins didáticos.",
    x = "Gasto em saúde per capita", y = "IDH", color = "Região"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position  = "bottom",
    plot.title       = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

grafico_final


# --- 7. Salvar -----------------------------------------------------------------

ggsave("graficos/idh_x_gasto.png", grafico_final,
       width = 8, height = 5, dpi = 300)

# Formatos: .png (slides/Word), .pdf (vetorial, artigos), .svg


# --- Colinha de geoms ----------------------------------------------------------
# geom_point      dispersão               geom_line     séries temporais
# geom_col/bar    barras                  geom_histogram distribuição
# geom_boxplot    distribuição por grupo  geom_density  densidade suave
# geom_smooth     tendência/regressão     geom_text     rótulos
# geom_hline/vline linhas de referência   geom_errorbar intervalos


# =============================================================================
# Agora faça: exercicios/04_ggplot2_exercicios.R
# =============================================================================
