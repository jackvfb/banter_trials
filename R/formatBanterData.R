library(tidyverse)


# Create a two staged RF classification model using package "banter"
#
# First stage of model will employ three different RF models that classify clicks.
# The first stage models will be trained to classify 1-, 2-, and 3- peaked clicks
# separately from one another.
#
# At the second stage, the event classifier will use output from the detector
# models, plus any provided event-level data, which at present their is none.


formatBanterData <- function(x, modelParams, by_peak=FALSE) {
  #Make event data frame
  events <- x %>%
    select(eventId, species) %>%
    #reduce to just distinct combinations of event and species for training model
    distinct(eventId, species) %>%
    mutate(species = as.factor(species)) %>% 
    rename(event.id = eventId)
  
  #Make detector data frame
  pk <- x %>%
    select(UID, eventId, all_of(modelParams)) %>%
    rename(event.id = eventId, call.id = UID)
  
  #Now subset detector data into one, two, three peaked clicks to train model
  if(by_peak) {
    pk1 <- subset(pk, peak2 == 0)
    pk2 <- subset(pk, peak2 != 0 & peak3 == 0)
    pk3 <- subset(pk, peak3 != 0)
    detectors = list(pk1=pk1, pk2=pk2, pk3=pk3) 
  } else {
    detectors = list(pk_together=pk)
  }
  
  #format data for banter model
  result <- list(events=events, detectors=detectors)
  return(result)  
}
