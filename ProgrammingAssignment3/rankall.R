# Retorna o hospital em melhor, pior ou outra posição escolhida em todos os 
# estados para determinada doença

rankall <-function(outcome, num = "best") {
      # Carrega dados
      data<-read.csv("outcome-of-care-measures.csv", 
                     colClasses="character")[,c(2, 7, 11, 17, 23)]
      data[data=="Not Available"]<-NA      
      
      # Checa validade dos argumentos
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
      
      # Função: ordena por taxa, desempatando por ordem alfabética, e define 
      # número da linha correspondente à posição do argumento num
      staterank<-function(x) {
            rank<-order(as.numeric(x[,out]), 
                        x[,1], na.last=NA)
            
            i<- if (num=="best") {
                  rank[1]
            } else if (num=="worst") {
                  tail(rank, n=1)
            } else {
                  rank[num]
            }
            x[i,1:2]
      }
      
      # Aplica a função acima para cada estado
      list<-lapply(split(data,data[,2]), staterank)
      
      # Cria data.frame com resultados
      bystate<-do.call(rbind, lapply(list, data.frame, stringsAsFactors=FALSE))
      colnames(bystate)<-c("hospital", "state")
      bystate$state<-rownames(bystate)
      bystate
}