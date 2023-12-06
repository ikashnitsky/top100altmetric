#===============================================================================
# 2021-03-30 -- top100altmetric
# Yearly Altmetric top-100 data, ready for R
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================
# UPD  2023-12-05 ------------------------------


source("dev/prep-session.R")

# a small function to excel files from the web
read_xlsx_from_web <- function(xlsx_url) {
    require(readxl)
    t <- tempfile()
    download.file(xlsx_url, destfile = t, mode = "wb")
    out <- read_excel(path = t)
    unlink(t)
    return(out)
}

# file figshare IDs
# Notes: for years 2014 and 2017 the files are csv
# in year 2016 there are 2 datasets
top100ids <- c(
    "2013" = 5932729,
    "2014" = 7378310,
    "2015" = 1613288,
    "2016" = 4294073,
    "2017" = 5683957,
    "2018" = 7441304,
    "2019" = 11371860,
    "2020" = 13607312,
    "2021" = 16974022
)


# function to download and read in top100altmetric data
read_in_top100altmetric <- function(figshare_id) {
    download_url <- fs_download(article_id = figshare_id) %>% extract2(1)
    file_name <- fs_details(article_id = figshare_id) %>%
        extract2("files") %>% extract2(1) %>%  extract2("name")
    if(file_name %>% str_sub(-1) %in% c("x", "s")){
        out <- read_xlsx_from_web(download_url)
    } else {
        out <- read_csv(download_url)
    }
    return(out)
}


# download all RAW datasets
top100raw <- top100ids %>% map(read_in_top100altmetric)

# save the RAW data
save(top100raw, file = "out/raw.rda")

# The format of the raw data is sooooo different from year to year that I will have to do quite some tideous manual cleaning. The biggest issue is with year 2014 that doesn't contain all the numerical Altmetric data
