# =============================================================================
# Soluções 01 - Vetores
# =============================================================================
# Há mais de um jeito certo. Se o seu deu o mesmo resultado, está ótimo.
# =============================================================================

votos     <- c(312, 289, NA, 401, 275, 350)
eleitores <- c(400, 380, 410, 500, 390, 420)
secao     <- c("S01", "S02", "S03", "S04", "S05", "S06")

# 1.
comparecimento <- round(votos / eleitores * 100, 1)
comparecimento

# 2.
sum(votos, na.rm = TRUE)

# 3. which() descarta os NA; sem ele, a S03 viraria um NA no resultado
secao[which(comparecimento > 75)]
# alternativa:
secao[comparecimento > 75 & !is.na(comparecimento)]

# 4.
secao[which.min(comparecimento)]

# 5.
sum(is.na(votos))

# 6.
faixa <- cut(comparecimento,
             breaks = c(-Inf, 70, 80, Inf),
             labels = c("baixo", "médio", "alto"),
             right  = FALSE)  # intervalos [a, b): 80 entra em "alto"
table(faixa)

# 7.
paste0("Seção ", secao, ": ", comparecimento, "%")
