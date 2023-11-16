library(tidyverse)

getCallRf <- function(s) {
  result <- map(names(s@detectors), ~getBanterModel(x=s,model=.x))
  names(result) <- names(s@detectors)
  return(result)
}
