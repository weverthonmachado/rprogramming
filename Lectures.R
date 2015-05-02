######    Coursera   ######

###### R Programming ######


##########
# Week 1 #
##########


# Data types 
#-----------------------------------

## Vectors
x<-4
x

## Lists
w<-list("w", 11, 5:8, TRUE)
w

## Matrices
m<-matrix(nrow=3, ncol=3)
m
attributes(m)
m<-1:30
dim(m)<-c("o"=2,"d"=5,"p"=3)
dimnames(m)<-list("o"=1:2, "d"=1:5, "p"=c("brasil", "argentina", "chile"))
m

## Factors
x<-factor(c("yes", "yes", "no", "yes", "no"))
x   # o R definiu a ordem dos fatores pela ordem alfab?tica
table(x)
unclass(x) # no=1, yes=2

 # eu posso definir a ordem que quiser par os fatores, com o arg "levels
x<-factor(c("yes", "yes", "no", "yes", "no"),
          levels=c("yes", "no"))
x # agora a primeira categoria (que ser? a baseline em modelos) ? yes

## Missing values

# NA ou NaN (para opera??es matem?ticas)
# Todo NaN ? tamb?m NA, o inverso n?o ? verdadeiro

x<- c(1, 2, NA, 10, 3)
is.na(x)
is.nan(x)

x<-c(1, 2, NaN, Na, 7)
is.na(x)
is.nan(x)

## Data frames

x<- data.frame(foo=1:4, bar=c(T, T, F, F))
x
nrow(x)
ncol(x)

## Names attribute
x<- 1:3
names(x)
names(x) <- c("foo", "bar","norf")
x
names(x)

x<-list(a=1, b=2, c=3)
x

m<-matrix(1:4, nrow=2, ncol=2)
dimnames(m) <-list(c("a", "b"), c("c", "d"))
m


# Reading tabular data
#-------------------------------

# Para datasets pequenos e m?dios, a fun??o read.table (e read.csv) pode ser rodada com o m?nimo de
# argumentos. Para datasets grande, ? recomend?vel otimizar adiantando algumas informa??es pro R, 
# como as classes de cada coluna (colClasses). Um modo b?sico de descobrir os tipos de dados
# em cada coluna e dizer pro R:
initial<-read.table("datatable.txt", nrows=100)
classes<-sapply(initial, class)
tabAll<-read.table("datatable.txt", colClasses=classes)


# Textual data formats
#---------------------------

# dump e dput preservam metadados (mas sacrificando um pouco a leitura e o espa?o)
setwd("C:\\Users\\Weverthon\\Dropbox\\Coursera\\R programming")

#dput s? pode ser usado com um objeto
y<- data.frame(a=1, b="a")
y
  dput(y)
dput(y, file="dput.R")
new.y<- dget("dput.R")
new.y

#dump pode ser usado com v?rios
x<-"foo"
y<- data.frame(a=1, b="a")
dump(c("x", "y"), file="dump.R")
rm(x,y) 
source("dump.R")


# Connections
#-----------------------

con<-file("file.txt", "r")
data<-read.csv(con)
close(con)
# ? o mesmo que:
data<-read.csv("file.txt")

con<-url("http://www.jhsph.edu", "r")
x<-readLines(con)
head(x)


# Subsetting
#------------------------

## Basics

x<-c("a","b","c","c", "d","a")
x[1]
x[2]
x[1:4]

x[x>"a"]
u<-x>"a"
u

## Lists

x<- list(foo=1:4, bar=0.6)

x[1] 
   # retorna uma lista contendo elementos 1 a 4

x[[1]]
  # retorna apenas os elementos 1 a 4

x$bar
x[["bar"]]
x["bar"]

x<- list(foo=1:4, bar=0.6, baz="hello")
x[c(1,3)]

# Eu posso criar um vetor para usar como ?ndice.
# Nesse caso, preciso usar [[]]

name<-"foo"
x[[name]]

x$name # n?o funciona pq o $ procura elemento com o nome exato
x$foo

# [[ pode ser usado com uma sequencia de numeros inteiros
x<- list(a=list(10, 12, 14), b=c(3.14, 2.01))

x[[c(1,3)]] # extraindo o terceiro elemento do primeiro elemento
x[[1]][[3]]

x[[c(2,1)]]

## Matrices
x<-matrix(1:6,2,3)
x[1,2] # ?ndice [linha, coluna]

x[1,]

# Por padr?o, susetting um ?nico elemento de uma matriz retorna um vetor,
# e n?o uma matriz 1x1. Para mudar (ou seja, preservando as dimens?es:
x[1,2, drop=FALSE]
x[1, , drop=FALSE]


## Partial matching

# ?til no uso interativo, n?o para escrever fun??es. Funciona com $ e [[]]

x<-list(aardwack=1:5)
x$a

x[["a"]] # n?o funciona. por padr?o [[]] procura nome exato
x[["a", exact=FALSE]]


## Removing missig data
x<-c(1, 2, NA, 4, NA, 5)
bad<-is.na(x) # crio um vetor l?gico identificando os missing
x[!bad] # (!=n?o)

# Com m?ltiplos objetos (util pra data frame)

# Vectorizes operations
#-----------------------

# Faz opera??es em paralelo, sem precisar de loops

x<-1:4
y<-6:9

x+y # soma elemento por elemento
x>2
x>=2
y==8
x*y
x/y

# tbm ? possivel fazer com matrizes
x<-matrix(1:4,2,2)
y<-matrix(rep(10,4),2,2)

x*y #opera??es elemento por elemento
x/y

x%*%y # multiplica??o das matrizes



##########
# Week 2 #
##########

# Control structures
# -----------------------

# Permitem controlar o fluxo do c?digo


## If-else

# Teste l?gico de uma condi??o

if(<condition>) {
  <do something>
} else {    # o else ? original, ? poss?vel n?o faer nada se a condi??o for falsa
  <do something different>
}

if(<condition>) {
    <do something>
} else if(<condition>){
    <do something different>
} else {
    <do something different>
}


# Duas estruturas v?lidas:

if(x>3){
      y <-10
} else {
      y<-0
}

# ? o mesmo que:

y<- if(x>3){
        10
} else {
        0
}


## For loops

# Mais usualmente utilizados para iterar por elementos de um objeto
for (i in 1:10) {
  print(i)
}


x<- c("a", "b", "c", "d")

for(i in 1:4) {
  print(x[i])
}

for(i in seq_along(x)) {
  print(x[i])
}

for(letter in x) {
  print(letter)
}

#for loops aninhados

x <- matrix(1:6, 2, 3)

for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }   
}


## While

count <- 0
while(count < 10) {
    print(count)
    count <- count + 1
}

z <- 5

while(z >= 3 && z <= 10) {
    print(z)
    coin <- rbinom(1, 1, 0.5)
    
    if(coin == 1) {  ## random walk
        z <- z + 1
    } else {
        z <- z - 1
    } 
}


# Functions
#-----------------------

#
add2 <- function(x, y) {
                x + y
}
add2(3,5)


#
above10<- function(x) {
          use <- x>10
          x[use]
}

above<- function(x, n) {
        use <- x>n
        x[use]
}

above<- function(x, n = 10) { #posso especificar 10 como valor default
  use <- x>n
  x[use]
}

# calcula m?dias por coluna em uma matriz/data.freame
columnmean<- function(y){
            nc<-ncol(y)
            means<- numeric(nc)
            for(i in 1:nc){
              means[i]<-mean(y[,i])
            }  
            means
}

columnmean(airquality)
        # duas primeiras colunas constam como NAs. Vamos especificar uma op??o pra resolver:

columnmean<- function(y, removeNA=T){
    nc<-ncol(y)
    means<- numeric(nc)
    for(i in 1:nc){
        means[i]<-mean(y[,i], na.rm= removeNA)
    }  
    means
}
columnmean(airquality)


## Scoping rules

# Na hora de definir o valor de uma vari?vel livre, o R procura o s?mbolo primeiro
# no ambiente em que a fun??o foi definida (o que pode inclusive outra fun??o) 



##########
# Week 3 #
##########

# Loop functions
#-------------------

## lapply

 # function (X, FUN, ...) 
 # aplica uma fun??o a todos os objetos de uma lista

x<-list(a=1:5, b=rnorm(10))
lapply(x, mean)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

x <- 1:4
lapply(x, runif)

x <- 1:4
lapply(x, runif, min=0, max=10) #passando argumento adicionais da fun??o
                                # runif atrav?s do argumento ... da lapply

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2)) 
lapply(x, function(elt) elt[,1])
            # essa ? uma fun??o "an?nima", que s? existe nessa chamada
            # da lapply. Ou seja, ? poss?vel criar uma fun??o simples
            # sem precisar nome?-la, careg?-la no environment, etc


## sapply

  # variante de lapply que tenta simplificar o resultado

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean) #retorna lista com m?dias
sapply(x, mean) #retorna vetor com m?dias


## apply

  # function (X, MARGIN, FUN, ...)
  # aplica FUN em margens de uma array (como lins e cols de matriz)

x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) # 2=colunas: estou "mantendo" as colunas e calculando
                  # as m?dias atrav?s de todas as linhas de cada coluna
apply(x, 1, sum)
                  # colSums, rowSums, colMeans e rowMeans sao mais
                  # r?pidas nesses caso

x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75))

      #array com mais de 2 dim
a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
apply(a, c(1, 2), mean)
rowMeans(a, dims = 2)


## mapply

   # aplica fun??o a mais de um objeto, usados como argumentos

#em vez de:
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))
#posso fazer:
mapply(rep, 1:4, 4:1)


noise <- function(n, mean, sd) {
       rnorm(n, mean, sd)
       }
noise(5, 1, 2)

noise(1:5, 1:5, 2)
mapply(noise, 1:5, 1:5, 2) # nesse caso, o mapply possibilitou
                           # opera?? vetorizada em uma fun??o que
                           # que n?o possibilitava isso


## tapply

  #function (X, INDEX, FUN = NULL, ..., simplify = TRUE)
  # aplica FUN a subsets de um vetor

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
f

## split


# Debugging tools
# -------------------

## Diagnosing the problem: messages, warnings, errors

## Basic tools:

# traceback
mean(x)
traceback()

lm(y ~ x)
traceback()
      # erro ocorre no sétimo passo


# debug
debug(lm)
lm(y~x)


# recover
options(error=recover)
read.csv("nosuchfile")


##########
# Week 4 #
##########

# Simulation
#------------------

## Random numbers

# Várias funções com r (gera números), d (avalia densidade), p (probabilidade)
# e q (quantis). Ex: rnorm, rpois, dnorm, rbinom, etc

## Simulating from a linear model
set.seed(20)
x<-rnorm(100)
e<-rnorm(100, 0, 2)
y<-0.5+2*x+e
summary(y)
plot(x,y)


set.seed(10)
x<-rbinom(100, 1, 0.5)
e<-rnorm(100, 0, 2)
y<-0.5+2*x+e
summary(y)
plot(x,y)

# generalized linear model
set.seed(1)
x<-rnorm(100)
log.mu<-0.5+0.3*x
y<-rpois(100, exp(log.mu))
summary(y)
plot(x,y)

## Random sample
set.seed(1)
sample(1:10, 4)
sample(1:10, 4)

sample(letters, 5)

sample(1:10)

sample(1:10, replace=TRUE)


# R profiler
# --------------------
