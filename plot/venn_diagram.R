
# https://en.wikipedia.org/wiki/Venn_diagram

library("VennDiagram")

# 绘制两个集合的韦恩图
draw.pairwise.venn(area1 = 6175410, area2 = 11172839, cross.area = 1271132,  category = c("A", "B"))

# 参数
# area1 指第一个集合的大小
# area2 指第二个集合的大小
# cross.area 指交集的大小
# category 用于指定集合名称

# 绘制三个集合的韦恩图
draw.triple.venn(area1=Length_A, area2=Length_B, area3=Length_C
                  ,n12=Length_AB, n23=Length_BC, n13=Length_AC, n123=Length_ABC
                  ,category = c('A','B','C')
                  ,col=c('red','green','blue'),fill=c('red','green','blue')
                  ,cat.col=c('red','green','blue')
                  ,reverse = FALSE)
# 参数
# area1、area2、area3分别指第一个、第二个、第三个集合的大小
# n12表示第一个与第二个集合的交集大小，n23、n13也是类似，n123指三个集合的交集大小
# reverse则指是否对图形进行反转
