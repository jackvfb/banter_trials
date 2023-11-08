# MAKE MODEL --------------------------------------------------------------

bantMdl <- initBanterModel(training_events)
bantMdl <- addBanterDetector(bantMdl,
                             data = detectors,
                             ntree = 1000,
                             importance = TRUE)
bantMdl <- runBanterModel(bantMdl,
                          ntree = 1000)
saveRDS(bantMdl, "analysis/data/derived_data/second_training/bant2_num.Rds")