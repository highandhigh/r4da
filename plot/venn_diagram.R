# https://en.wikipedia.org/wiki/Venn_diagram
# https://cran.r-project.org/web/packages/VennDiagram/index.html

library("VennDiagram")

# grid.newpage() # draw.*.venn 函数都是在原画布上作图，故而要做新图需开新画布（newpage）



# 绘制两个集合的韦恩图
draw.pairwise.venn(
  area1 = 6530638, 
  area2 = 1387422, 
  cross.area = 310069,  
  category = c("A", "B")
)

# 参数
# area1 指第一个集合的大小
# area2 指第二个集合的大小
# cross.area 指交集的大小
# category 用于指定集合名称


# A simple two-set diagram
draw.pairwise.venn(100, 70, 30, c("First", "Second"))



# A more complicated diagram Demonstrating external area labels
draw.pairwise.venn(
  area1 = 100,
  area2 = 70,
  cross.area = 68,
  category = c("First", "Second"),
  fill = c("blue", "red"),
  lty = "blank",
  cex = 2,
  cat.cex = 2,
  cat.pos = c(285, 105),
  cat.dist = 0.09,
  cat.just = list(c(-1, -1), c(1, 1)),
  ext.pos = 30,
  ext.dist = -0.05,
  ext.length = 0.85,
  ext.line.lwd = 2,
  ext.line.lty = "dashed"
)
# grid.newpage()

# Demonstrating an Euler diagram
venn.plot <- draw.pairwise.venn(
  area1 = 100,
  area2 = 70,
  cross.area = 0,
  category = c("First", "Second"),
  cat.pos = c(0, 180),
  euler.d = TRUE,
  sep.dist = 0.03,
  rotation.degree = 45
)
# grid.newpage()





# 绘制三个集合的韦恩图

# scaled = TRUE 这个默认参数似乎没有生效，图大小都一致
draw.triple.venn(
  area1 = 6530638, 
  area2 = 1387422, 
  area3 = 37711,
  n12 = 310069, 
  n23 =  13289, 
  n13 = 31759, 
  n123 = 11884,
  category = c('A','B','c'),
  col = c('red','green','blue'),
  fill= c('red','green','blue'),
  cat.col = c('red','green','blue'),
  revers = FALSE,
  scaled = TRUE # 这里比例不对，似乎 scaled = TRUE 没有生效 
)
# 参数
# area1、area2、area3分别指第一个、第二个、第三个集合的大小
# n12表示第一个与第二个集合的交集大小，n23、n13也是类似，n123指三个集合的交集大小
# reverse则指是否对图形进行反转


# A simple three-set diagram
draw.triple.venn(65, 75, 85, 35, 15, 25, 5, c("First", "Second", "Third"))

# A more complicated diagram
draw.triple.venn(
  area1 = 65,
  area2 = 75,
  area3 = 85,
  n12 = 35,
  n23 = 15,
  n13 = 25,
  n123 = 5,
  category = c("First", "Second", "Third"),
  fill = c("blue", "red", "green"),
  lty = "blank",
  cex = 2,
  cat.cex = 2,
  cat.col = c("blue", "red", "green")
)


# Demonstrating an Euler diagram
draw.triple.venn(20, 40, 60, 0, 0, 0, 0,
                              c("First", "Second", "Third"), 
                              sep.dist = 0.1, 
                              rotation.degree = 30
)


# 绘制四个集合的韦恩图
draw.quad.venn(
  area1 = 11764562,
  area2 = 6596402,
  area3 = 1405790,
  area4 = 37756,
  n12 = 1396443,
  n13 = 804533,
  n14 = 28736,
  n23 = 289275,
  n24 = 32,
  n34 = 11997,
  n123 = 228425,
  n124 = ,
  n134 = 24804,
  n234 = 10586,
  n1234 = 9580,
  category = c("First", "Second", "Third", "Fourth"),
  fill = c("orange", "red", "green", "blue"),
  lty = "dashed",
  cex = 2,
  cat.cex = 2,
  cat.col = c("orange", "red", "green", "blue")
)


# Reference four-set diagram
draw.quad.venn(
  area1 = 72,
  area2 = 86,
  area3 = 50,
  area4 = 52,
  n12 = 44,
  n13 = 27,
  n14 = 32,
  n23 = 38,
  n24 = 32,
  n34 = 20,
  n123 = 18,
  n124 = 17,
  n134 = 11,
  n234 = 13,
  n1234 = 6,
  category = c("First", "Second", "Third", "Fourth"),
  fill = c("orange", "red", "green", "blue"),
  lty = "dashed",
  cex = 2,
  cat.cex = 2,
  cat.col = c("orange", "red", "green", "blue")
)


# Reference five-set diagram
draw.quintuple.venn(
  area1 = 301,
  area2 = 321,
  area3 = 311,
  area4 = 321,
  area5 = 301,
  n12 = 188,
  n13 = 191,
  n14 = 184,
  n15 = 177,
  n23 = 194,
  n24 = 197,
  n25 = 190,
  n34 = 190,
  n35 = 173,
  n45 = 186,
  n123 = 112,
  n124 = 108,
  n125 = 108,
  n134 = 111,
  n135 = 104,
  n145 = 104,
  n234 = 111,
  n235 = 107,
  n245 = 110,
  n345 = 100,
  n1234 = 61,
  n1235 = 60,
  n1245 = 59,
  n1345 = 58,
  n2345 = 57,
  n12345 = 31,
  category = c("A", "B", "C", "D", "E"),
  fill = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),
  cat.col = c("dodgerblue", "goldenrod1", "darkorange1", "seagreen3", "orchid3"),
  cat.cex = 2,
  margin = 0.05,
  cex = c(1.5, 1.5, 1.5, 1.5, 1.5, 1, 0.8, 1, 0.8, 1, 0.8, 1, 0.8, 1, 0.8, 
          1, 0.55, 1, 0.55, 1, 0.55, 1, 0.55, 1, 0.55, 1, 1, 1, 1, 1, 1.5),
  ind = TRUE
)
