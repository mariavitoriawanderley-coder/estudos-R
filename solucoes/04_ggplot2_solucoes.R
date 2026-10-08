# =============================================================================
# Soluções 04 - ggplot2
# =============================================================================

library(ggplot2)
library(dplyr)
source("00_dados_exemplo.R")

# 1.
ggplot(municipios, aes(x = idh)) +
  geom_histogram(bins = 12, fill = "steelblue", color = "white")

# 2.
ggplot(municipios, aes(x = regiao, y = idh)) +
  geom_boxplot(outlier.shape = NA) +   # evita desenhar outliers duas vezes
  geom_jitter(width = 0.15, alpha = 0.6)

# 3.
municipios |>
  group_by(regiao) |>
  summarise(pop_total = sum(populacao)) |>
  ggplot(aes(x = reorder(regiao, pop_total), y = pop_total)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  scale_y_continuous(labels = scales::label_number(big.mark = ".")) +
  labs(title = "População total por região", x = NULL, y = "Habitantes")

# 4.
ggplot(municipios, aes(x = populacao, y = gasto_saude, color = regiao)) +
  geom_point() +
  scale_x_log10(labels = scales::label_number(big.mark = ".")) +
  facet_wrap(~ regiao) +
  theme(legend.position = "none")  # a legenda é redundante com os painéis

# 5.
municipios <- municipios |>
  mutate(porte = case_when(
    populacao < 20000  ~ "Pequeno",
    populacao < 100000 ~ "Médio",
    TRUE               ~ "Grande"
  ),
  porte = factor(porte, levels = c("Pequeno", "Médio", "Grande")))

ggplot(municipios, aes(x = regiao, fill = porte)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::label_percent()) +
  labs(x = NULL, y = "Proporção de municípios", fill = "Porte")

# 6.
meu_grafico <- ggplot(municipios, aes(x = regiao, fill = porte)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_fill_brewer(palette = "Blues") +
  labs(title    = "Porte dos municípios por região",
       subtitle = "Proporção de municípios em cada faixa de população",
       caption  = "Fonte: dados simulados para fins didáticos.",
       x = NULL, y = NULL, fill = "Porte") +
  theme_minimal()

meu_grafico
ggsave("graficos/meu_grafico.png", meu_grafico, width = 7, height = 5, dpi = 300)
