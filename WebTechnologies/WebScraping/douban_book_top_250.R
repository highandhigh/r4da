
library(rvest)
library(stringr)

url <- "https://book.douban.com/top250?icn=index-book250-all"

douban_book_top_250 <- read_html(webpage)

title <- douban_book_top_250 %>% 
  html_nodes("div.article div.pl2 a") %>%
  html_attr("title")


author_pub <- douban_book_top_250 %>% 
  html_nodes("div.article p.pl") %>%
  html_text()

rating <- douban_book_top_250 %>% 
  html_nodes("div.article div.star span.rating_nums") %>%
  html_text() %>%
  as.numeric()

voter_num <- douban_book_top_250 %>% 
    html_nodes("div.article div.star span.pl") %>%
  html_text() %>%
  str_extract("\\d+")

douban_book_top_250_df <- data.frame(title = title, 
                 author_pub = author_pub, 
                 rating = rating, 
                 voter_num = voter_num,
                 stringsAsFactors = FALSE)
