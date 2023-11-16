library(PAMpal)

makeStudies <- function(dir){
  dbs <- file.path(dir, "db")
  bins <- file.path(dir, "binaries")
  pps <- PAMpalSettings(db = dbs, binaries = bins, sr_hz = "auto", filterfrom_khz = 100, filterto_khz = 160, winLen_sec = 0.0025)
  study <- processPgDetections(pps = pps, mode = "db", id = basename(dir))
  study <- setSpecies(study, method = "pamguard")
  return(study)
}