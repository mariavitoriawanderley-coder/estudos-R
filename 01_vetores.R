# =============================================================================
# 01 - Vetores
# =============================================================================
# Objetivo: entender que quase tudo em R é vetor, e tirar proveito disso.
# Rode linha a linha (Ctrl+Enter no RStudio) e observe o resultado no console.
# =============================================================================


# --- 1. Revisão rápida: criar vetores ----------------------------------------

idades  <- c(23, 35, 41, 19, 52)
nomes   <- c("Ana", "Bruno", "Carla", "Davi", "Eva")
votou   <- c(TRUE, FALSE, TRUE, TRUE, FALSE)

class(idades)   # "numeric"
class(nomes)    # "character"
class(votou)    # "logical"
length(idades)  # 5

# Sequências úteis
1:10
seq(0, 100, by = 25)
seq(0, 1, length.out = 5)
rep(c("A", "B"), times = 3)
rep(c("A", "B"), each = 3)


# --- 2. Um vetor só guarda UM tipo (coerção) ---------------------------------
# Se você misturar tipos, o R converte tudo para o tipo "mais geral":
# logical -> integer -> numeric -> character

c(1, "dois", 3)       # vira tudo character!
c(TRUE, FALSE, 10)    # TRUE vira 1, FALSE vira 0

# Isso é útil: somar um vetor lógico conta quantos TRUE existem
sum(votou)            # quantas pessoas votaram
mean(votou)           # proporção que votou


# --- 3. Vetorização: operar no vetor inteiro de uma vez ----------------------
# Em R, você raramente precisa de um loop para fazer contas elemento a elemento.

idades + 1
idades * 12           # idade em meses
idades > 30           # retorna um vetor lógico
sqrt(c(4, 9, 16))

# Dois vetores do mesmo tamanho operam par a par
renda   <- c(2000, 3500, 5000, 1500, 8000)
despesa <- c(1800, 3000, 5200, 1400, 6000)
saldo   <- renda - despesa
saldo

# CUIDADO com a "reciclagem": se os tamanhos forem diferentes, o R repete
# o vetor menor. Às vezes é o que você quer, às vezes é um bug silencioso.
c(1, 2, 3, 4) + c(10, 20)   # vira 11 22 13 24


# --- 4. Indexação: pegar pedaços de um vetor ---------------------------------

idades[1]             # o primeiro (R começa a contar do 1, não do 0)
idades[c(1, 3)]       # o 1º e o 3º
idades[-1]            # todos MENOS o primeiro
idades[2:4]

# Indexação lógica — a mais usada na prática
idades[idades > 30]
nomes[idades > 30]           # nomes de quem tem mais de 30
nomes[votou & idades < 40]   # & = "e";  | = "ou";  ! = "não"

which(idades > 30)           # POSIÇÕES que satisfazem a condição
which.max(renda)             # posição do maior valor
nomes[which.max(renda)]      # quem tem a maior renda

# Vetores com nomes
names(renda) <- nomes
renda
renda["Carla"]


# --- 5. NA: valores faltantes ------------------------------------------------

notas <- c(7.5, NA, 9.0, 6.0, NA)

mean(notas)                  # NA! Qualquer conta com NA dá NA
mean(notas, na.rm = TRUE)    # ignora os NA
is.na(notas)
sum(is.na(notas))            # quantos faltantes
notas[!is.na(notas)]         # só os válidos

# Armadilha clássica: NUNCA teste NA com ==
notas == NA                  # tudo NA — não funciona
is.na(notas)                 # jeito certo


# --- 6. Fatores: variáveis categóricas ---------------------------------------
# Fatores guardam categorias com uma ordem definida (os "levels").

escolaridade <- c("Médio", "Superior", "Fundamental", "Médio", "Superior")
escolaridade_f <- factor(
  escolaridade,
  levels = c("Fundamental", "Médio", "Superior") # ordem que faz sentido
)

levels(escolaridade_f)
table(escolaridade_f)        # contagem por categoria, na ordem dos levels
as.integer(escolaridade_f)   # internamente, fator é número + rótulo

# Por que importa? Gráficos e tabelas seguem a ordem dos levels.
# Sem definir, o R usa ordem alfabética.


# --- 7. Funções úteis para resumir vetores -----------------------------------

summary(idades)
range(idades)
quantile(idades, c(0.25, 0.5, 0.75))
sort(idades, decreasing = TRUE)
order(idades)                # posições que ordenariam o vetor
rev(idades)
unique(c(1, 1, 2, 3, 3, 3))
cumsum(1:5)                  # soma acumulada
round(3.14159, 2)

# ifelse: um "se/senão" vetorizado
ifelse(idades >= 40, "40+", "menos de 40")

# cut: transforma números em faixas (vira fator)
cut(idades, breaks = c(0, 30, 50, Inf), labels = c("até 30", "31-50", "50+"))

# paste / paste0: juntar textos
paste(nomes, "tem", idades, "anos")
paste0("ID_", 1:5)


# --- 8. Listas: o "vetor" que aceita qualquer coisa --------------------------
# Diferente do vetor comum, uma lista pode misturar tipos e tamanhos.

pessoa <- list(
  nome   = "Ana",
  idade  = 23,
  cursos = c("Estatística", "R", "Ciência Política")
)

pessoa$nome
pessoa[["cursos"]]           # [[ ]] pega o CONTEÚDO
pessoa["cursos"]             # [ ] devolve uma lista menor (repare na diferença)
str(pessoa)                  # mostra a estrutura de qualquer objeto

# Um data frame (próximo módulo) é, por dentro, uma lista de vetores
# do mesmo tamanho.


# =============================================================================
# Agora faça: exercicios/01_vetores_exercicios.R
# =============================================================================
