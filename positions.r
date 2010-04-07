options(stringsAsFactors = FALSE)
library(rjson)
library(plyr)
library(stringr)

org <- read.csv("organisations.csv")
pos_url <-  "http://maplight.org/services_open_api/map.organization_positions_v1.json"

pos_search <- function(string) {
  url <- str_c(pos_url, "?apikey=6b1dd81152ca4bf31d6c9eeca4076af7&organization_id=", string)
  contents <- suppressWarnings(str_c(readLines(url), collapse = ""))
  contents <- str_replace(contents, "\\\\/", "/")
  
  json <- fromJSON(contents)[1]$positions
  
  ldply(json, function(pos) data.frame(compact(pos)))
}


save_pos <- function(org_id) {
  out_path <- file.path("positions", str_c(org_id, ".csv"))
  if (file.exists(out_path)) return(invisible())

  pos <- pos_search(org_id)  
  write.table(pos, out_path, sep = ",", row = F)
}

todo <- org$organization_id
paths <- file.path("positions", str_c(todo, ".csv"))

todo <- todo[!file.exists(paths)]

l_ply(todo, function(id) {
  cat(id, "\n")
  save_pos(id)
  # Sys.sleep(1)
})



pos_path <- dir("positions", full.names = TRUE)
names(pos_path) <- str_match(pos_path, "[0-9]+")

lengths <- laply(pos_path, function(x) length(readLines(x)), 
  .progress = "text")
valid <- pos_path[lengths > 1]

contents <- llply(valid, failwith(NULL, read.csv))
pos <- ldply(contents, compact)

pos$org_id <- as.numeric(pos$.id)
pos$.id <- NULL

write.table(pos, "positions.csv", sep = ",", row =F)