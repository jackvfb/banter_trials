library(tidyverse)

filterClickData <- function(modelName, clicks, detectorsWanted, paramsWanted, sppWanted){
  thisData <- clicks[[modelName]]
  thisDetector <- detectorsWanted[[modelName]]
  result <- doFilter(thisData, thisDetector, paramsWanted, sppWanted)
}


doFilter <- function(x, detector, params, spp){
  result <- x %>%
    #just training data
    filter(species %in% spp) %>% 
    #subset clicks just from the wanted detector
    filter(detectorName == detector) %>%
    #remove clicks with NA values in needed parameters
    drop_na(all_of(params)) %>%
    #filter out clicks with unrealistic parameters: duration greater than 2 microseconds
    filter(duration < 2) %>%
    #filter out BW > 4kHz
    filter(BW_3dB < 4) %>%
    #if both channels remain for the click, choose the lower noiseLevel of the two
    group_by(UID) %>%
    slice_min(noiseLevel) %>%
    ungroup() %>% 
    #remove duplicates, of which there appear to be many. Not sure why.
    distinct(UID, .keep_all = TRUE)
    #additional filter to just use clicks surpassing a SNR threshold?
  return(result)
}
