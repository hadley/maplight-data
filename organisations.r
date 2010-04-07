options(stringsAsFactors = FALSE)
library(rjson)
library(stringr)

orgs_url <-  "http://maplight.org/services_open_api/map.organization_search_v1.json"

org_search <- function(string) {
  url <- str_c(orgs_url, "?apikey=6b1dd81152ca4bf31d6c9eeca4076af7&search=", string)
  contents <- str_c(readLines(url), collapse = "")
  
  fromJSON(contents)
}


json <- lapply(c("a", "e", "i", "o", "u"), org_search)
json2 <- lapply(json, "[[", 1)
json2 <- unlist(json2, recursive = FALSE)

orgs <- ldply(json2, as.data.frame)
orgs <- unique(orgs)

write.table(orgs, "organisations.csv", sep = ",", row = F)
