#===============================================================================
# 2021-04-01 -- top100altmetric
# Altmetric weights for the sources
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com, @ikashnitsky
#===============================================================================

# https://web.archive.org/web/20210329144550/https://help.altmetric.com/support/solutions/articles/6000233311-how-is-the-altmetric-attention-score-calculated-

altmetric_weights <- tibble::tribble(
                               ~source, ~weight,
                                "news",       8,
                                "blog",       5,
                              "policy",       3,
                              "patent",       3,
                           "wikipedia",       3,
                         "peer_review",       1,
                               "weibo",       1,
                              "google",       1,
                               "f1000",       1,
                             "syllabi",       1,
                           "linked_in",     0.5,
                             "twitter",    0.25,
                            "facebook",    0.25,
                              "reddit",    0.25,
                           "pinterest",    0.25,
                                 "q_a",    0.25,
                               "video",    0.25
                         )



save(altmetric_weights, file = "out/altmetric_weights.rda")
