corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  corrList = numeric(0)
  
  for (i in 1:332) {
    vec = na.omit(read.csv(paste(directory, "/", formatC(i, width=3, flag="0"), ".csv", sep="")))
    
    # if the number of rows is > threshold, compute the correlation and append it to 
    # the running list
    if (nrow(vec) > threshold) {
      corrValue = cor(vec["sulfate"], vec["nitrate"])
      if (!is.na(corrValue)) {
        corrList <- append(corrList, corrValue)
      }
    }
  }
  
  return(corrList)
}