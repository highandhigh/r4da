
library(RCurl)
library(stringi) 
library(rvest)


# 问题：该网页是 gb2312 编码的，但是其中有很多繁体和日文，普通的字符编码转化为正常中文

# 解决：通过 stringi 中的 stri_enc_detect() 检测最有可能的编码，再做转化

url <- "http://t66y.com/thread0806.php?fid=2&search=&page=1"

myHttpheader <- c(
  "User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
  "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language"="en-us",
  "Connection"="keep-alive",
  "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7")


webpage <- getURL(url, httpheader=myHttpheader, .encoding = "gb2312", .mapUnicode = FALSE)

# iconv(webpage, from = "gb2312", to = "utf-8")
# 失败

#stri_enc_detect(webpage)
# GB18030 是置信度最高的

t66y_asia_uncensored <- read_html(stri_conv(webpage, from = "GB18030", to = "utf-8"))

#标题 CSS selctor
#ajaxtable > tbody:nth-child(2) > tr:nth-child(9) > td:nth-child(2) > h3 > a

title <- t66y_asia_uncensored %>%
  html_nodes("tbody tr td h3 a") %>%
  html_text()

link <- t66y_asia_uncensored %>%
  html_nodes("tbody tr td h3 a") %>%
  html_attr("href")
# 实际的链接还要在 link 加入域名


# 应用场景：可以通过对标题中的文件大小信息、格式和主演名称检索，获得所需的链接
# 注：连接该网站需翻墙
