rankall <-function(outcome, num = "best") {
      data<-read.csv("outcome-of-care-measures.csv", 
                     colClasses="character")[,c(2, 7, 11, 17, 23)]
      data[data=="Not Available"]<-NA      
      

      if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
            stop("invalid outcome")
      }
      
      out<- if (outcome=="heart attack") {
            3
            } else if (outcome=="heart failure") {
            4
            } else {
            5
      }
      
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
      
      list<-lapply(split(data,data[,2]), staterank)
      bystate<-do.call(rbind, lapply(list, data.frame, stringsAsFactors=FALSE))
      colnames(bystate)<-c("hospital", "state")
      bystate$state<-rownames(bystate)
      bystate
}