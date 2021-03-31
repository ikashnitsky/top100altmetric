#===============================================================================
# 2021-03-31 -- top100altmetric
# Reconstruct the dataset for 2014
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

library(rvest)

# the web page with ranking
top2014html <- read_html("https://www.altmetric.com/top100/2014/")

# the provided dataset for 2014
load("dat/raw.rda")
top2014 <- top100[["2014"]]


