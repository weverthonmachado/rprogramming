corr <- function(directory, threshold = 0) {
      df<-complete(directory, 1:332)
      meets<-df$id[df$nobs>=threshold]   
      if (length(meets)==0) {
                        numeric()
      } else {
      id0<-sprintf(paste("C:/Users/Weverthon/Dropbox/Coursera/R programming/", 
                         directory, 
                         "/", 
                         "%03d.csv",
                         sep=""), 
                   meets)
      data_all<-do.call(rbind, lapply(id0, read.csv))
      data_complete<-data_all[complete.cases(data_all),]
      data_complete$ID<-factor(data_complete$ID, levels= meets)
      as.numeric(
            by(data_complete, data_complete$ID, 
               FUN = function(X) cor(X$nitrate, X$sulfate)))
      }
}


