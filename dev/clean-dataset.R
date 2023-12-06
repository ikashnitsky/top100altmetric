#===============================================================================
# 2023-12-05 -- top100altmetric
# Prepare clean dataset for all years
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================


# Due to the vastly different formats of yearly tables I have to select the relevant columns for each year manually

source("dev/prep-session.R")

load("out/raw.rda")

# 2013 --------------------------------------------------------------------

df13 <- top100raw[["2013"]] %>%
    clean_names()

uni13 <- df13 %>%
    transmute(
        year = 2013,
        rank = row_number(),
        altmetric_attention_score,
        title,
        journal,
        journal_iss_ns,
        url,
        doi,
        access_type = case_when(
            is.na(oa) ~ "Paywalled",
            TRUE ~ "Open Access"
        ),

        news_mentions = news_outlets,
        blog_mentions = bloggers,
        twitter_mentions = tweeters,
        peer_review_mentions = f1000_reviews,
        facebook_mentions = facebook_walls,
        google_mentions = google_authors,
        reddit_mentions = reddit_threads,
        pinterest_mentions = pinterest_posts,
        q_a_mentions = q_a_site_users,
        f1000_mentions = f1000_reviews,
        mendeley_readers
)

# 2014 --------------------------------------------------------------------

load("out/df14.rda")

uni14 <- df14 %>%
    clean_names() %>%
    transmute(
        year = 2014,
        rank = row_number(),
        altmetric_id = altmetric_id %>% paste,
        altmetric_attention_score,
        title,
        authors = author_name,
        affiliations = institution,
        journal,
        subject = category,
        url,
        doi,
        access_type = access_type %>% str_replace("Paywall", "Paywalled"),
        publication_date = published %>% paste,

        news_mentions = news_stories %>% as.numeric,
        blog_mentions = blog_posts %>% as.numeric,
        twitter_mentions = tweets %>% as.numeric,
        peer_review_mentions = peer_reviews %>% as.numeric,
        facebook_mentions = facebook_posts %>% as.numeric,
        policy_mentions = policy_documents %>% as.numeric,
        weibo_mentions = weibo_posts %>% as.numeric,
        google_mentions = google_posts %>% as.numeric,
        reddit_mentions = reddit_posts %>% as.numeric,
        video_mentions = videos %>% as.numeric,
        faculty_opinions_mentions = research_highlight_platforms %>% as.numeric
    )


# 2015 --------------------------------------------------------------------

df15 <- top100raw[["2015"]] %>%
    clean_names()

uni15 <- df15 %>%
    transmute(
        year = 2015,
        rank = row_number(),
        altmetric_id = id %>% paste,
        altmetric_attention_score = score,
        title,
        authors,
        journal,
        affiliations = institutions,
        subject = categories,
        url = link,
        doi,
        access_type = case_when(
            open_access == "Yes" ~ "Open Access",
            TRUE == "No" ~ "Paywalled"
        ),
        publication_date = date %>% paste,

        news_mentions = count_news,
        blog_mentions = count_blogs,
        twitter_mentions = count_twitter,
        peer_review_mentions = count_peer_review,
        facebook_mentions = count_facebook,
        google_mentions = count_google_plus,
        reddit_mentions = count_reddit,
        video_mentions = count_video,
        faculty_opinions_mentions = count_research_hi,
        wikipedia_mentions = count_wikipedia,
        weibo_mentions = count_weibo
    )


# 2016 --------------------------------------------------------------------

df16 <- top100raw[["2016"]] %>%
    clean_names()

uni16 <- df16 %>%
    transmute(
        year = 2016,
        rank = row_number(),
        altmetric_id = altmetric_id %>% paste,
        altmetric_attention_score = score,
        title,
        journal,
        subject,
        url = link,
        doi,
        access_type = case_when(
            oa == "Yes" ~ "Open Access",
            oa == "No" ~ "Paywalled",
            TRUE ~ "Free to view"
        ),
        publication_date = publication_date %>% paste,

        news_mentions = total_posts_msm,
        blog_mentions = total_posts_blog,
        twitter_mentions = total_posts_tweet,
        peer_review_mentions = total_posts_peer_review,
        policy_mentions = total_posts_policy,
        facebook_mentions = total_posts_fbwall,
        google_mentions = total_posts_gplus,
        reddit_mentions = total_posts_rdt,
        video_mentions = total_posts_video,
        q_a_mentions = total_posts_qna,
        wikipedia_mentions = total_posts_wikipedia,
        weibo_mentions = total_posts_weibo,
        pinterest_mentions = total_posts_pinterest,
        linked_in_mentions = total_posts_linkedin,
        f1000_mentions = total_posts_f1000
    )


# 2017 --------------------------------------------------------------------

df17 <- top100raw[["2017"]] %>%
    clean_names()

uni17 <- df17 %>%
    slice(1:100) %>%
    transmute(
        year = 2017,
        rank = row_number(),
        altmetric_id = altmetric_id %>% paste,
        altmetric_attention_score = score,
        title,
        journal,
        subject,
        doi = doi,
        url = paste0("https://dx.doi.org/", doi),
        access_type = oa,
        publication_date = date %>% paste,

        news_mentions = number_of_news_stories,
        blog_mentions = number_of_blog_posts,
        policy_mentions = number_of_policy_documents,
        twitter_mentions = number_of_tweets,
        peer_review_mentions = number_of_peer_reviews,
        weibo_mentions = number_of_weibo_posts,
        facebook_mentions = number_of_facebook_posts,
        linked_in_mentions = number_of_linked_in_posts,
        wikipedia_mentions = number_of_wikipedia_pages,
        google_mentions = number_of_google_posts,
        reddit_mentions = number_of_reddit_posts,
        pinterest_mentions = number_of_pins,
        q_a_mentions = number_of_q_a_posts,
        video_mentions = number_of_videos,
        mendeley_readers = number_of_mendeley_readers,
        f1000_mentions = number_of_f1000_posts
    )


# 2018 --------------------------------------------------------------------

df18 <- top100raw[["2018"]] %>%
    clean_names()

uni18 <- df18 %>%
    slice(1:100) %>%
    transmute(
        year = 2018,
        rank = row_number(),
        altmetric_id = details_page_url %>%
            str_remove("https://www.altmetric.com/details/"),
        altmetric_attention_score,
        title,
        authors,
        affiliations = affiliations_grid,
        journal = journal_collection_title,
        journal_iss_ns,
        publisher,
        subject = subjects,
        doi = doi,
        url = doi_url,
        access_type = case_when(
            open_access == "OA" ~ "Open Access",
            open_access == "Free to read" ~ "Free to view",
            TRUE ~ "Paywalled"
        ),
        publication_date = publication_date %>% paste,

        news_mentions,
        blog_mentions,
        policy_mentions,
        twitter_mentions,
        patent_mentions,
        peer_review_mentions,
        weibo_mentions,
        facebook_mentions,
        linked_in_mentions,
        wikipedia_mentions,
        google_mentions,
        reddit_mentions,
        pinterest_mentions,
        q_a_mentions,
        video_mentions,
        f1000_mentions,
        mendeley_readers = number_of_mendeley_readers,
        dimensions_citations = number_of_dimensions_citations
    )


# 2019 --------------------------------------------------------------------


df19 <- top100raw[["2019"]] %>%
    clean_names()

uni19 <- df19 %>%
    transmute(
        year = 2019,
        rank = row_number(),
        altmetric_id = details_page_url %>%
            str_remove("https://www.altmetric.com/details/"),
        altmetric_attention_score,
        title,
        authors,
        affiliations = affiliations_grid,
        journal = journal_collection_title,
        journal_iss_ns,
        publisher,
        subject = subjects,
        doi = doi,
        url = doi_url,
        access_type = case_when(
            open_access == "OA" ~ "Open Access",
            open_access == "Free to read" ~ "Free to view",
            TRUE ~ "Paywalled"
        ),
        publication_date = publication_date %>% paste,

        news_mentions,
        blog_mentions,
        policy_mentions,
        twitter_mentions,
        patent_mentions,
        peer_review_mentions,
        weibo_mentions,
        facebook_mentions,
        linked_in_mentions,
        wikipedia_mentions,
        google_mentions,
        reddit_mentions,
        pinterest_mentions,
        q_a_mentions,
        video_mentions,
        f1000_mentions,
        mendeley_readers = number_of_mendeley_readers,
        dimensions_citations = number_of_dimensions_citations
    )


# 2020 --------------------------------------------------------------------

df20 <- top100raw[["2020"]] %>% clean_names()

uni20 <- df20 %>%
    arrange(altmetric_attention_score %>% desc) %>%
    transmute(
        year = 2020,
        rank = row_number(),
        altmetric_id = details_page_url %>%
            str_remove("https://www.altmetric.com/details/"),
        altmetric_attention_score,
        title,
        authors,
        affiliations = affiliations_grid,
        journal = journal_collection_title,
        journal_iss_ns,
        subject,
        publisher,
        doi = doi %>%
            str_remove("http://dx.doi.org/"),
        url = paste0("https://dx.doi.org/", doi),
        access_type = open_access,
        publication_date = publication_date %>% paste,
        news_mentions,
        blog_mentions,
        policy_mentions,
        twitter_mentions,
        patent_mentions,
        peer_review_mentions,
        weibo_mentions,
        facebook_mentions,
        linked_in_mentions,
        wikipedia_mentions,
        google_mentions,
        reddit_mentions,
        pinterest_mentions,
        faculty_opinions_mentions,
        q_a_mentions,
        video_mentions,
        mendeley_readers = number_of_mendeley_readers,
        dimensions_citations = number_of_dimensions_citations
    )


# 2021 --------------------------------------------------------------------

df21 <- top100raw[["2021"]] %>% clean_names()

uni21 <- df21 %>%
    arrange(altmetric_attention_score %>% desc) %>%
    transmute(
        year = 2021,
        rank = row_number(),
        altmetric_id = details_page_url %>%
            str_remove("https://www.altmetric.com/details/"),
        altmetric_attention_score,
        title,
        affiliations = affiliations_grid,
        journal = journal_collection_title,
        journal_iss_ns,
        subject = subjects_fo_r,
        doi = doi %>%
            str_remove("http://dx.doi.org/"),
        url = paste0("https://dx.doi.org/", doi),
        access_type = case_when(
            oa_status == TRUE ~ "Open Access",
            TRUE ~ "Paywalled"
        ),
        publication_date = publication_date %>% paste,
        news_mentions,
        blog_mentions,
        policy_mentions,
        twitter_mentions,
        patent_mentions,
        peer_review_mentions,
        weibo_mentions,
        facebook_mentions,
        linked_in_mentions,
        wikipedia_mentions,
        google_mentions,
        reddit_mentions,
        pinterest_mentions,
        q_a_mentions,
        video_mentions,
        mendeley_readers = number_of_mendeley_readers,
        dimensions_citations = number_of_dimensions_citations
    )


# unify -------------------------------------------------------------------

top100altmetric <- bind_rows(
    uni20,
    uni13,
    uni14,
    uni15,
    uni16,
    uni17,
    uni18,
    uni19,
    uni21
) %>%
    arrange(year) %>%
    mutate_if(is.numeric, function(x) x %>%  replace_na(0)) %>%
    # reorder last columns
    select(
        year:video_mentions, f1000_mentions,
        mendeley_readers, dimensions_citations
    )

save(top100altmetric, file = "out/top100altmetric.rda")


usethis::use_data(top100altmetric)
