# cleaning OpenSecrets.org's data
options(stringsAsFactors = F)

lob_indus <- read.delim("lob_indus.txt", quote ="|", sep = ",")
names(lob_indus) <- c("parent", "client", "total_amt", "year", "catcode")
save(lob_indus, file = "lob_indus.rdata")

lob_bills <- read.delim("lob_bills.txt", quote ="|", sep = ",")
names(lob_bills) <- c("bill_id", "si_id", "cong_no", "bill_name")
save(lob_bills, file = "lob_bills.rdata")

lob_rpt <- read.delim("lob_rpt.txt", quote ="|", sep = ",")
names(lob_rpt) <- c("rep_type", "rep_code")
save(lob_rpt, file = "lob_reports.rdata")

lob_lobbying <- read.delim("lob_lobbying.txt", quote ="|", sep = ",")
names(lob_lobbying) <- c("uniqueid", "raw_registrant", "registrant", "is_lobbying", "raw_client", "client", "parent", "amount", "catcode", "source", "type_of_filing", "include_NSFS", "use", "include", "year", "rep_type", "rep_type_long", "org_id", "affiliate")
save(lob_rpt, file = "lob_reports.rdata")