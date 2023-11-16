library(banter)

# MAKE MODEL --------------------------------------------------------------

makeBanterModel <- function(x, det_ntree=1000, ev_ntree=1000) {
  bantMdl <- initBanterModel(x$events)
  bantMdl <- addBanterDetector(bantMdl, data=x$detectors, ntree=det_ntree,
                               importance=TRUE, sampsize = 0.5)
  bantMdl <- runBanterModel(bantMdl, ntree = ev_ntree)
  return(bantMdl)  
}
