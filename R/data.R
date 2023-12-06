# Data --------------------------------------------------------------------

#' Altmetric top-100 data
#'
#' Yearly list of the most noticed scientific papers as tracked by Altmetric, 2013--2021
#'
#' @format
#'   A tibble with 900 rows and 34 variables:
#'   \describe{
#'     \item{year}{Year of the Altmetric top-100 list calculation.}
#'     \item{rank}{Rank of the paper in the top-100 list.}
#'     \item{altmetric_id}{Altmetric ID of the paper.}
#'     \item{altmetric_attention_score}{Integral weighted attention score calculated by Altmetric. It is caluclated based of the mentions in different sources with varying weights. See more details [here](https://help.altmetric.com/support/solutions/articles/6000233311-how-is-the-altmetric-attention-score-calculated-).}
#'     \item{title}{Title of the paper.}
#'     \item{authors}{Authors of the paper.}
#'     \item{affiliations}{Affiliations of the paper's authors.}
#'     \item{journal}{Journal in which the paper is published.}
#'     \item{journal_iss_ns}{ISSN journal identifiers.}
#'     \item{subject}{Subject category of the publication.}
#'     \item{publisher}{Publisher of the journal.}
#'     \item{doi}{DOI (digital object identifier) of the paper.}
#'     \item{url}{URL link to the paper.}
#'     \item{access_type}{Type of access to teh paper: Open Access, Paywalled, or Free to read.}
#'     \item{publication_date}{Paper's date of publication.}
#'     \item{news_mentions}{Number of times the paper was mentioned in news articles.}
#'     \item{blog_mentions}{Number of times the paper was mentioned in blog posts.}
#'     \item{policy_mentions}{Number of times the paper was mentioned in policy documents.}
#'     \item{twitter_mentions}{Number of times the paper was twitted about.}
#'     \item{patent_mentions}{Number of times the paper was mentioned in patents.}
#'     \item{peer_review_mentions}{Number of times the paper was mentioned in open peer reviews.}
#'     \item{weibo_mentions}{Number of times the paper was mentioned in Weibo posts.}
#'     \item{facebook_mentions}{Number of times the paper was mentioned in Facebook posts.}
#'     \item{wikipedia_mentions}{Number of times the paper was mentioned in Wikipedia articles.}
#'     \item{google_mentions}{Number of times the paper was mentioned in Google+ posts.}
#'     \item{reddit_mentions}{Number of times the paper was mentioned in Reddit threads.}
#'     \item{pinterest_mentions}{Number of times the paper was pined on Pinterest.}
#'     \item{faculty_opinions_mentions}{Number of times the paper was mentioned on Faculty Opinion platform.}
#'     \item{q_a_mentions}{Number of times the paper was mentioned on Q&A platforms.}
#'     \item{video_mentions}{Number of times the paper was mentioned in videos.}
#'     \item{f1000_mentions}{Number of times the paper was mentioned in F1000 articles and reviews.}
#'     \item{mendeley_readers}{Number of times the paper was read on Mendeley.}
#'     \item{dimensions_citations}{Number of citations received by the paper as neasured by Dimensions.}
#'   }
#'
#' @source
#'   Altmetric top-100 lists.
#'   \url{https://www.altmetric.com/top100/home}
"top100altmetric"
