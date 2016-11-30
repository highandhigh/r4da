
library(RCurl)
library(rvest)

url <- "https://xueqiu.com/strategy/37"

## 方法1：通过 XML2 读取网页
# read_html(url)
# Error in open.connection(x, "rb") : HTTP error 403.


## 方法2：通过 RCurl 读取网页

myHttpheader <- c(
  "User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
  "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language"="en-us",
  "Connection"="keep-alive",
  "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7")


webpage <- getURL(url, httpheader=myHttpheader, encoding="utf-8")

xueqiu_strategy_37 <- read_html(webpage)


stock_name <- xueqiu_strategy_37 %>% 
  html_nodes("div.stock-name span:nth-child(1)") %>%
  html_text()


stock_symbol <- xueqiu_strategy_37 %>% 
  html_nodes("div.stock-symbol") %>%
  html_text()


singal_price <- xueqiu_strategy_37 %>% 
  html_nodes("div.card.stock td:nth-child(3)") %>%
  html_text()


singal_description <- xueqiu_strategy_37 %>% 
  html_nodes("tr.description-row td p") %>%
  html_text()

xueqiu_strategy_37_df <- data.frame(stock_name = stock_name, 
                 stock_symbol = stock_symbol, 
                 singal_price = singal_price, 
                 singal_description = singal_description,
                 stringsAsFactors = FALSE)
