pollutantmean <- function(directory, pollutant, id=1:332) {
      setwd(directory)
      id0<-sprintf("%03d.csv", id)
      data<-do.call(rbind, lapply(id0, read.csv))
      mean(data[[pollutant]], na.rm=TRUE)      
}

pollutantmean("C:\\Users\\Weverthon\\Dropbox\\Coursera\\R programming\\specdata", "nitrate", 23)

