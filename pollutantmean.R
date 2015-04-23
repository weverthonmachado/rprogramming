pollutantmean <- function(directory, pollutant, id=1:332) {
      id0<-sprintf(paste("C:/Users/Weverthon/Dropbox/Coursera/R programming/", 
                        directory, 
                        "/", 
                        "%03d.csv",
                        sep=""), 
                        id)
      data<-do.call(rbind, lapply(id0, read.csv))
      mean(data[[pollutant]], na.rm=TRUE)      
}


