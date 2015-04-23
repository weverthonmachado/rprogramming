complete <- function(directory, id=1:332) {
      id0<-sprintf(paste("C:/Users/Weverthon/Dropbox/Coursera/R programming/", 
                         directory, 
                         "/", 
                         "%03d.csv",
                         sep=""), 
                   id)
      data_all<-do.call(rbind, lapply(id0, read.csv))
      data_complete<-data_all[complete.cases(data_all),]
      data_complete$ID<-factor(data_complete$ID, levels= id)
      df<-data.frame(table(data_complete$ID))
      colnames(df)<-c("id", "nobs")
      df
}

