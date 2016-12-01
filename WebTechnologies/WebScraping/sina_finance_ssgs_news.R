
library(RCurl)
library(rvest)

# 获取新浪财经上上市公司新闻列表标题

# 问题：该网页是 gb2312 编码的，通过Rcurl中得到的网页代码乱码，较难转化为正常中文，该问题普遍存在

# 解决：手动指定 .encoding 和 .mapUnicode 参数，对得到的文本代码再做一次转化从 gb2312 转为 utf-8

url <- "http://roll.finance.sina.com.cn/finance/zq1/ssgs/index.shtml"
  
sina_finance_ssgs_news <- getURL(url, .encoding = "gb2312", .mapUnicode = FALSE) %>%
  iconv(from = "gb2312", to = "utf-8") %>%
  read_html()

sina_finance_ssgs_news %>% 
  html_nodes("body ul.list_009 li a") %>%
  html_text()

# 这里直接使用 xml2 中的 read_html() 得到的网页代码是正常显示中文的
# 该案例使用 RCurl 中的 getURL() 只是为了演示该问题，因为部分情况下 read_html() 是无法获取到网页代码的
