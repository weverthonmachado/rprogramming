# Retorna o hospital em melhor, pior ou outra posição escolhida em determinado
# estado e doença

rankhospital <-function(state, outcome, num= "best") {
      # Carrega dados e cria lista de estados válidos
      data<-read.csv("outcome-of-care-measures.csv", 
                     colClasses="character")[,c(2, 7, 11, 17, 23)]
      states<-levels(as.factor(data[,2]))
      
      # Checa validade dos argumentos
      if (!(state %in% states)) stop("invalid state")
      if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
            stop("invalid outcome")
      }
      
      #Define coluna de acordo com doença
      out<- if (outcome=="heart attack") {
            3
            } else if (outcome=="heart failure") {
            4
            } else {
            5
      }
      
      #Dados por estado escolhido      
      statedata<-data[data[,2]==state,]
      statedata[statedata=="Not Available"]<-NA
      
      # Ordena por taxa, desempatando por ordem alfabética, e define número da
      # linha correspondente à posição do argumento num
      rank<-order(as.numeric(statedata[,out]), statedata[,1], na.last=NA)      
      i<- if (num=="best") {
            rank[1]
      } else if (num=="worst") {
            tail(rank, n=1)
      } else {
            rank[num]
      }
      statedata[i,1]
}