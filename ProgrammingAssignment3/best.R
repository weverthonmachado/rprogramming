best <-function(state, outcome) {
      outcome<-read.csv("outcome-of-care-measures.csv", colClasses="character")
      states<-levels(as.factor(outcome[,7]))
      
      

}