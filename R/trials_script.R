dirs <- list(man1 = "C:/Users/jackv/Documents/thesis/data/man1", 
             man2 = "C:/Users/jackv/Documents/thesis/data/man2", 
             mtc="C:/Users/jackv/Documents/thesis/data/mtc")
spWanted <- c("Kosp","Phda","Phph","Ksp","Pp","Pd","Noise")

myStudies <- lapply(dirs, makeStudies, spWanted)
myClicks <- lapply(myStudies, getClickData)
# saveRDS(clicks, "data/clicks.rds")

models <- c("man1","man2","mtc")
modelParams <- c("duration","peakTime","peak","peak2","peak3","trough",
                 "trough2","peakToPeak2","peakToPeak3","peakToPeak2","dBPP",
                 "Q_10dB","fmin_10dB","fmax_10dB","BW_10dB","centerkHz_10dB",
                 "Q_3dB","fmin_3dB","fmax_3dB","BW_3dB","centerkHz_3dB")

detectorsWanted <- c(man1="Click_Detector_5", man2="Click_Detector_5", mtc="Click_Detector_101")

filteredData <- lapply(models, filterClicks, myClicks, detectorsWanted, modelParams)
bantData <- lapply(filteredData, formatBanterData)
