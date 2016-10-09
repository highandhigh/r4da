# 读取数据
dau <- read.table(file = "clipboard", sep = "\t")

date <- read.table(file = "clipboard", sep = "\t", stringsAsFactors = FALSE)

# 单列向量化
dau <- dau$V1

date <- date$V1

# hist(dau)
# 
# qqnorm(dau)
# 
# ddf <- data.frame(dau = dau, date = date)
# 
# length(dau)
# length(date)


# 用 qcc 做异常分析
# 10个交易日滚动分析异常

library(qcc)

for (t in 10:length(dau)) {
  
  dt <- dau[(t - 9):t]
  names(dt) <- date[(t - 9):t]
  
  rt <- qcc(dt, type="xbar.one", plot = FALSE)
  
  if(length(beyond.limits(rt)) > 0 & 10 %in% beyond.limits(rt)) { #包含最新d一天异常
    
    plot(rt, title = date[t])
    print(dt[sort(beyond.limits(rt))])
    
  }
  
}

# 分析具体日期的异常
# t <- 244
# 
# dt <- dau[(t - 9):t]
# names(dt) <- date[(t - 9):t]
# 
# rt <- qcc(dt, type="xbar.one", plot = FALSE)

# 画时间趋势图
library(dygraphs)
dygraph(xts(dau, order.by = as.Date(date))) %>% dyRangeSelector()
