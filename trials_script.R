library(PAMpal)
library(banter)
library(tidyverse)

files.sources <- list.files("R", full.names = TRUE)
sapply(files.sources, source)

dirs <- list(man1 = "C:/Users/jackv/Documents/thesis/data/man1",
             man2 = "C:/Users/jackv/Documents/thesis/data/man2",
             mtc="C:/Users/jackv/Documents/thesis/data/mtc")
spWanted <- c("Kosp","Phda","Phph","Ksp","Pp","Pd")
modelNames <- c(man1="man1",man2="man2",mtc="mtc")
paramsWanted <- c("duration","peakTime","peak","peak2","peak3","trough","trough2",
                 "peakToPeak2","peakToPeak3","peakToPeak2","dBPP","Q_10dB",
                 "fmin_10dB","fmax_10dB","BW_10dB","centerkHz_10dB","Q_3dB",
                 "fmin_3dB","fmax_3dB","BW_3dB","centerkHz_3dB")

detectorsWanted <- c(man1="Click_Detector_5", man2="Click_Detector_5", mtc="Click_Detector_101")

myStudies <- lapply(dirs, makeStudies)
myClicks <- lapply(myStudies, getClickData)
filteredClicks <- lapply(modelNames, filterClicks, myClicks, detectorsWanted, paramsWanted, spWanted)
bantClicks <- lapply(filteredClicks, makeBanterData, paramsWanted, by_peak=FALSE)
bantModels <- lapply(bantClicks, makeBanterModel)
lapply(bantModels, summary)
