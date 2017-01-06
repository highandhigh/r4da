
df <- read.table("clipboard")
# 读取剪切板上的数据

diff_time <- df$V1
# 自选股数量

hist(diff_time[diff_time <= 60 & diff_time >= 0], 
     breaks = 60, 
     ylim = c(0, 3000),
     main = "2017-01-06 首页焦点图第四帧广告，在会话开始后点击时间分布(秒)",
     xlab = "会话开始后点击时间分布(秒)",
     ylab = "首页焦点图广告点击次数"
     ) 
# breaks 直方间隔数
