

df <- read.table("clipboard")
# 读取剪切板上的数据

zx_num <- df$V1
# 自选股数量

hist(zx_num[zx_num <= 100], breaks = 100) 
# breaks 直方间隔数
