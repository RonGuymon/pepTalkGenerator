# This is the file that has instructions to deploy the plumber file
library(plumber)

root <- pr(paste0(getwd(), "/peptalkplumber.R"))
pr_run(root, host = "0.0.0.0", port = 80)
