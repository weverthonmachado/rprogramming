# Retorna o melhor hospital (menor taxa de mortalidade) 
# em determinado estado e doença

best <-function(state, outcome) {
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
      
      #Define número da linha com menor taxa, desempatando por ordem alfabética
      i<-order(as.numeric(statedata[,out]), statedata[,1], na.last=NA)[1]
      statedata[i, 1]
}