#===============================================================================
# 2023-12-05 -- top100altmetric
# Reconstruct the dataset for 2014
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

source("dev/prep-session.R")

# the provided dataset for 2014
load("dat/raw.rda")
top2014 <- top100[["2014"]]


# the web page with ranking
top2014html <- read_html("https://www.altmetric.com/top100/2014/")


# article IDs -------------------------------------------------------------
# top2014html %>%
#     html_element(xpath = '//*[@id="articles"]/article[1]/div[4]/a') %>%
#     paste() %>%
#     str_extract("citation_id=[0-9]+") %>%
#     str_extract("[0-9]+")

iron_ids <- function(article_n) {
    top2014html %>%
        html_element(
            xpath = paste0(
                '//*[@id="articles"]/article[', article_n, ']/div[4]/a'
            )
        ) %>%
        paste() %>%
        str_extract("citation_id=[0-9]+") %>%
        str_extract("[0-9]+")

}

ids14 <- 1:100 %>% map_chr(iron_ids) %>%
    tibble(altmetric_id = . ) %>%
    mutate(altmetric_id = altmetric_id %>% as.numeric())


# total altmetric score ---------------------------------------------------

iron_score <- function(article_n) {
    top2014html %>%
        html_element(
            xpath = paste0(
                '//*[@id="articles"]/article[', article_n, ']/div[4]/a/div[1]/div[1]'
            )
        ) %>%
        paste() %>%
        str_extract("score=[0-9]+") %>%
        str_extract("[0-9]+")
}

scores14 <- 1:100 %>% map_chr(iron_score) %>%
    tibble(altmetric_attention_score = . ) %>%
    mutate(altmetric_attention_score = altmetric_attention_score %>% as.numeric())


# paper URLs --------------------------------------------------------------


iron_url <- function(article_n) {
    top2014html %>%
        html_element(
            xpath = paste0(
                '//*[@id="articles"]/article[', article_n, ']/h2/a'
            )
        ) %>%
        paste() %>%
        str_extract('(?<=").*?(?=")')
}

urls14 <- 1:100 %>% map_chr(iron_url) %>%
    tibble(url = . ) %>%
    # fix one arxiv link
    mutate(url = url %>% str_replace("fr.arxiv", "arxiv"))

# mention counts ----------------------------------------------------------

iron_counts <- function(article_n) {
    foo <- top2014html %>%
        html_element(
            xpath = paste0(
                '//*[@id="articles"]/article[', article_n, ']/div[4]/a/div[2]'
            )
        )

    one <- foo %>%
        xml_child(2) %>%
        as_list() %>%
        {.[seq(2, length(.), 2)]} %>%
        unlist() %>%
        matrix(nrow = 2, byrow = FALSE) %>%
        as.data.frame() %>%
        set_colnames(.[2,]) %>%
        slice(1)

    if(
        foo %>% xml_children() %>% length() > 2
    ){
        two <- foo %>%
            xml_child(3) %>%
            as_list() %>%
            {.[seq(2, length(.), 2)]} %>%
            unlist() %>%
            matrix(nrow = 2, byrow = FALSE) %>%
            as.data.frame() %>%
            set_colnames(.[2,]) %>%
            slice(1)

        one <- cbind(one, two)
    }

    return(one)
}

counts14 <- 1:100 %>% map_df(iron_counts)


# unify all ---------------------------------------------------------------

df14 <- left_join(
    top2014 %>% clean_names() %>% select(-url),
    cbind(ids14, urls14, scores14, counts14) %>% clean_names()
)

# clean non-uniform colnames
df14 <- df14 %>%
    mutate(
        reddit_posts = case_when(
            !is.na(reddit_posts) ~ reddit_posts,
            TRUE ~ reddit_post
        ),
        google_posts = case_when(
            !is.na(google_posts) ~ google_posts,
            TRUE ~ google_post
        ),
        research_highlight_platforms = case_when(
            !is.na(research_highlight_platforms) ~ research_highlight_platforms,
            TRUE ~ research_highlight_platform
        ),
        weibo_posts = case_when(
            !is.na(weibo_posts) ~ weibo_posts,
            TRUE ~ weibo_post
        ),
        peer_reviews = case_when(
            !is.na(peer_reviews) ~ peer_reviews,
            TRUE ~ peer_review
        ),
        videos = case_when(
            !is.na(videos) ~ videos,
            TRUE ~ video
        ),
        policy_documents = policy_document
    ) %>%
    select(
        -reddit_post, -google_post, -facebook_post,
        -research_highlight_platform, -peer_review,
        -weibo_post, -blog_post, -video, -policy_document
    )


save(df14, file = "out/df14.rda")



