rankhospital <-function(state, outcome, num= "best") {
      data<-read.csv("outcome-of-care-measures.csv", 
                     colClasses="character")[,c(2, 7, 11, 17, 23)]
      states<-levels(as.factor(data[,2]))
      
      if (!(state %in% states)) stop("invalid state")
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
      statedata<-data[data[,2]==state,]
      statedata[statedata=="Not Available"]<-NA
      rank<-order(as.numeric(statedata[,out]), rev(statedata[,1]), na.last=NA)
      
      i<- if (num=="best") {
            rank[1]
      } else if (num=="worst") {
            tail(rank, n=1)
      } else {
            rank[num]
      }
      statedata[i,1]
}