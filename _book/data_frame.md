
## 数据框 data.frame




数据框是R语言中的一个种表格结构，对应于数据库中的表，类似Excel中的数据表。数据框的是由多个向量构成，每个向量的长度相同。

数据框类似于矩阵，也是一个二维表结构。

在统计学术语中，用`行`来表示`观测(observations)`，用`列`来表示`变量(variables)`。

类似于数据库系统，`行`代表数据表的`记录(records)`,`列`代表数据表的`字段(fields)`。

针对数据框来说，可能会在不同的情景下使用`行`、`观测`、`记录`这几个名称，他们指代的含义相同；类似的，也可能会在不同的情景下使用`列`、`变量`、`字段`这几个名称，他们指代的也含义相同；并不会再特别说明，怎么适合表达就怎么用。

### 创建数据框

创建数据框，最简单的方法就是用同名的定义函数 data.frame()，输入每个变量的名称及对应的向量，每个向量的长度相同。



针对示例过程中创建的15名员工信息的向量，将其组合成一个员工信息表：


```r
# 当参数较多时，可以换行书写，使得函数结构更为清晰
employee <- data.frame(name = name,
                       height = height,
                       weight = weight,
                       islocal = islocal,
                       gender = gender,
                       grade = grade,
                       birthday = birthday
                       )
print(employee) # 打印数据框时，会在屏幕中显示行的序号和变量名称
#>          name height weight islocal gender grade   birthday
#> 宋子启 宋子启   1.73     73    TRUE     男    中 1984-02-28
#> 张伯仲 张伯仲   1.68     70    TRUE     男    良 1988-09-26
#> 孟轲舆 孟轲舆   1.72     68   FALSE     男    良 1989-07-28
#> 张伟     张伟   1.65     60    TRUE     男    中 1990-01-25
#> 王雪梅 王雪梅   1.66     55   FALSE     女    优 1987-04-30
#> 陈梦妍 陈梦妍   1.62     52   FALSE     女    良 1989-12-20
#> 李元礼 李元礼   1.81     80   FALSE     男    中 1992-06-14
#> 杨伯侨 杨伯侨   1.74     75    TRUE     男    优 1991-07-01
#> 赵蜚廉 赵蜚廉   1.78     78   FALSE     男    中 1990-08-08
#> 蒋欣     蒋欣   1.71     54   FALSE     女    良 1985-05-10
#> 沈约度 沈约度   1.72     61    TRUE     男    良 1993-04-01
#> 陈淮阳 陈淮阳   1.69     62    TRUE     男    中 1991-03-05
#> 况天佑 况天佑   1.74     56   FALSE     男    良 1991-09-25
#> 王珍珍 王珍珍   1.70     53    TRUE     女    中 1992-01-31
#> 马小玲 马小玲   1.72     82    TRUE     女    优 1988-02-14
class(employee) # 对象的类，数据框类的名称为 data.frame
#> [1] "data.frame"
is.data.frame(employee) # 判断一个对象是否为数据框
#> [1] TRUE
```


变量的名称可以自定义，只要符合R语言对象命名规则即可，上面的自理正好使用和已有向量相同的名字而已。例如下面创建的数据框，变量的名字是任意给定的：


```r
df <- data.frame(a = c("A", "B", "C", "A", "A", "B"), b = c(-0.33, 0.07, -0.40, 0.77, 0.24, 1.07))
print(df)
#>   a     b
#> 1 A -0.33
#> 2 B  0.07
#> 3 C -0.40
#> 4 A  0.77
#> 5 A  0.24
#> 6 B  1.07
```

### 数据框的属性

数据框是二维的数据表，故而继承了很多矩阵的属性和计算函数。


```r
dim(employee) # 维度属性，行数和列数，也就是观测数和变量数
#> [1] 15  7
nrow(employee) # 行数，也就是观测数，记录数
#> [1] 15
ncol(employee) # 列数，也就是变量数，字段数
#> [1] 7
rownames(employee) # 行名称，如果没有命名则返回行序号向量
#>  [1] "宋子启" "张伯仲" "孟轲舆" "张伟"   "王雪梅" "陈梦妍" "李元礼"
#>  [8] "杨伯侨" "赵蜚廉" "蒋欣"   "沈约度" "陈淮阳" "况天佑" "王珍珍"
#> [15] "马小玲"
colnames(employee) # 列名称，返回变量名称；数据框中变量名称是必须指定的
#> [1] "name"     "height"   "weight"   "islocal"  "gender"   "grade"   
#> [7] "birthday"
row.names(employee) # 行的名称，数据框自己定义的属性，与 rownames 相同
#>  [1] "宋子启" "张伯仲" "孟轲舆" "张伟"   "王雪梅" "陈梦妍" "李元礼"
#>  [8] "杨伯侨" "赵蜚廉" "蒋欣"   "沈约度" "陈淮阳" "况天佑" "王珍珍"
#> [15] "马小玲"
names(employee) # 变量名称，数据框自己定义的属性，与 colnames 相同
#> [1] "name"     "height"   "weight"   "islocal"  "gender"   "grade"   
#> [7] "birthday"
# 数据框中变量名称更为重要，故而直接用 names() 函数返回，更为便捷
```

#### 数据框的合并


```r
df_1 <- data.frame(V1 = 1:2, V2 = c("A","B")) ; print(df_1) # 两个语句之间可以用`;`隔开就可以写在一行中
#>   V1 V2
#> 1  1  A
#> 2  2  B
print(df_2 <- data.frame(V1 = 3:3, V2 = c("C","D"))) # 赋值语句结束后将该表达式的结果打印出来
#>   V1 V2
#> 1  3  C
#> 2  3  D
rbind(df_1, df_2)
#>   V1 V2
#> 1  1  A
#> 2  2  B
#> 3  3  C
#> 4  3  D
df_3 <- data.frame(V3 = c(95, 88), V4 = c("Actor", "Farmer"))
print(df_3) # 这才是比较合适的书写规范，一行语句执行一个命令；以上两种写法均可，但不推荐
#>   V3     V4
#> 1 95  Actor
#> 2 88 Farmer
cbind(df_1, df_3)
#>   V1 V2 V3     V4
#> 1  1  A 95  Actor
#> 2  2  B 88 Farmer
```


### 数据结构与数据汇总 

`str()`可以快速显示一个对象的结构。

对数据框来说， `str()`返回多个信息，包含：类名称；观测个数和变量个数；每个变量也就是向量的名称，及其类型，和前10个值；如果每个变量是因子向量，则返回其水平，及水平映射的整数值。

`str()`能显示整个数据框的数据结构，非常实用。


```r
str(employee)
#> 'data.frame':	15 obs. of  7 variables:
#>  $ name    : Factor w/ 15 levels "沈约度","陈淮阳",..: 9 13 8 14 10 3 6 12 15 4 ...
#>  $ height  : num  1.73 1.68 1.72 1.65 1.66 1.62 1.81 1.74 1.78 1.71 ...
#>  $ weight  : num  73 70 68 60 55 52 80 75 78 54 ...
#>  $ islocal : logi  TRUE TRUE FALSE TRUE FALSE FALSE ...
#>  $ gender  : Factor w/ 2 levels "男","女": 1 1 1 1 2 2 1 1 1 2 ...
#>  $ grade   : Ord.factor w/ 4 levels "差"<"中"<"良"<..: 2 3 3 2 4 3 2 4 2 3 ...
#>  $ birthday: Date, format: "1984-02-28" "1988-09-26" ...
```

`summary()`函数，可以快速显示一个对象的汇总结果。

对数据框来说，返回每个变量的汇总结果：

* 对因子向量，返回每个因子的水平及计数结果（个数）；只显示前6个，剩下的显示为`(Other)`
* 对数值向量，返回5分位数及平均值，分别是
  + Min.   :最小值
  + 1st Qu.:四分之一分位数
  + Median :中位数
  + Mean   :算术平均值
  + 3rd Qu.:四分之三分位数
  + Max.   :最大值
* 对逻辑向量，返回其模式(mode), TRUE 和 FALSE 的个数，缺失值的个数
* 对字符向量，返回每个唯一字符的个数，只显示前6个，剩下的显示为`(Other)`
  
查看返回数据的结果汇总，就能对数据的概括有个大致的了解。


```r
summary(employee)
#>       name       height         weight      islocal        gender  grade 
#>  沈约度 :1   Min.   :1.62   Min.   :52.0   Mode :logical   男:10   差:0  
#>  陈淮阳 :1   1st Qu.:1.69   1st Qu.:55.5   FALSE:7         女: 5   中:6  
#>  陈梦妍 :1   Median :1.72   Median :62.0   TRUE :8                 良:6  
#>  蒋欣   :1   Mean   :1.71   Mean   :65.3   NA's :0                 优:3  
#>  况天佑 :1   3rd Qu.:1.74   3rd Qu.:74.0                                 
#>  李元礼 :1   Max.   :1.81   Max.   :82.0                                 
#>  (Other):9                                                               
#>     birthday         
#>  Min.   :1984-02-28  
#>  1st Qu.:1988-06-05  
#>  Median :1990-01-25  
#>  Mean   :1989-09-27  
#>  3rd Qu.:1991-08-13  
#>  Max.   :1993-04-01  
#> 
```

### 访问数据框变量

一个数据框可能包含多个变量（向量），有时需要单独提取某个变量，使用`$`特殊的符号来访问，由`数据框$变量名`构成。


```r
employee$name # 访问 employee 数据框中名为 name 的变量；结果就是一个向量
#>  [1] 宋子启 张伯仲 孟轲舆 张伟   王雪梅 陈梦妍 李元礼 杨伯侨 赵蜚廉 蒋欣  
#> [11] 沈约度 陈淮阳 况天佑 王珍珍 马小玲
#> 15 Levels: 沈约度 陈淮阳 陈梦妍 蒋欣 况天佑 李元礼 马小玲 ... 赵蜚廉
employee$height 
#>  [1] 1.73 1.68 1.72 1.65 1.66 1.62 1.81 1.74 1.78 1.71 1.72 1.69 1.74 1.70
#> [15] 1.72
employee$weight
#>  [1] 73 70 68 60 55 52 80 75 78 54 61 62 56 53 82
employee$islocal
#>  [1]  TRUE  TRUE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE
#> [12]  TRUE FALSE  TRUE  TRUE
employee$gender
#>  [1] 男 男 男 男 女 女 男 男 男 女 男 男 男 女 女
#> Levels: 男 女
```

增加一个变量，只需要将一个等长的向量赋值给`数据框$新变量名`即可

```r
employee$bmi <- employee$weight/(employee$height^2)
str(employee)
#> 'data.frame':	15 obs. of  8 variables:
#>  $ name    : Factor w/ 15 levels "沈约度","陈淮阳",..: 9 13 8 14 10 3 6 12 15 4 ...
#>  $ height  : num  1.73 1.68 1.72 1.65 1.66 1.62 1.81 1.74 1.78 1.71 ...
#>  $ weight  : num  73 70 68 60 55 52 80 75 78 54 ...
#>  $ islocal : logi  TRUE TRUE FALSE TRUE FALSE FALSE ...
#>  $ gender  : Factor w/ 2 levels "男","女": 1 1 1 1 2 2 1 1 1 2 ...
#>  $ grade   : Ord.factor w/ 4 levels "差"<"中"<"良"<..: 2 3 3 2 4 3 2 4 2 3 ...
#>  $ birthday: Date, format: "1984-02-28" "1988-09-26" ...
#>  $ bmi     : num  24.4 24.8 23 22 20 ...
```

### 数据框的长度与类型

数据框可以由多个不同的向量组成，故而其 `长度length()` 和 `模式mode()` 属性没太大的意义。


```r
length(employee)
#> [1] 8
```

增加一个变量，只需要将一个等长的向量赋值给`数据框$新变量名`即可

```r
employee$bmi <- employee$weight/(employee$height^2) 
str(employee)
#> 'data.frame':	15 obs. of  8 variables:
#>  $ name    : Factor w/ 15 levels "沈约度","陈淮阳",..: 9 13 8 14 10 3 6 12 15 4 ...
#>  $ height  : num  1.73 1.68 1.72 1.65 1.66 1.62 1.81 1.74 1.78 1.71 ...
#>  $ weight  : num  73 70 68 60 55 52 80 75 78 54 ...
#>  $ islocal : logi  TRUE TRUE FALSE TRUE FALSE FALSE ...
#>  $ gender  : Factor w/ 2 levels "男","女": 1 1 1 1 2 2 1 1 1 2 ...
#>  $ grade   : Ord.factor w/ 4 levels "差"<"中"<"良"<..: 2 3 3 2 4 3 2 4 2 3 ...
#>  $ birthday: Date, format: "1984-02-28" "1988-09-26" ...
#>  $ bmi     : num  24.4 24.8 23 22 20 ...
```


### 数据框索引与筛选

类似与矩阵，数据框也用类似的方法索引和筛选子集，包括整数位置、名称属性、逻辑向量索引，但最常用的是`subset()`和`head()`函数。

`subset()`常用是因为可以复合多个逻辑表达式条件。

`head()`常用是因为通常数据表的行数很大，直接打印所有的行会使控制台刷屏，多数时候只需看数据库的前几行即可，结合 str() 查看数据结构、summary() 查看数据汇总情况。


```r
# 前3名员工的身高和体重
employee[1:3, c("height", "weight")] 
#>        height weight
#> 宋子启   1.73     73
#> 张伯仲   1.68     70
#> 孟轲舆   1.72     68

# employee$islocal 是逻辑向量，第2个维度就是变量，不限制条件就是选中所有变量
employee[employee$islocal,] 
#>          name height weight islocal gender grade   birthday  bmi
#> 宋子启 宋子启   1.73     73    TRUE     男    中 1984-02-28 24.4
#> 张伯仲 张伯仲   1.68     70    TRUE     男    良 1988-09-26 24.8
#> 张伟     张伟   1.65     60    TRUE     男    中 1990-01-25 22.0
#> 杨伯侨 杨伯侨   1.74     75    TRUE     男    优 1991-07-01 24.8
#> 沈约度 沈约度   1.72     61    TRUE     男    良 1993-04-01 20.6
#> 陈淮阳 陈淮阳   1.69     62    TRUE     男    中 1991-03-05 21.7
#> 王珍珍 王珍珍   1.70     53    TRUE     女    中 1992-01-31 18.3
#> 马小玲 马小玲   1.72     82    TRUE     女    优 1988-02-14 27.7

# select 参数不选择就是所有变量
subset(employee, employee$height > 1.7) 
#>          name height weight islocal gender grade   birthday  bmi
#> 宋子启 宋子启   1.73     73    TRUE     男    中 1984-02-28 24.4
#> 孟轲舆 孟轲舆   1.72     68   FALSE     男    良 1989-07-28 23.0
#> 李元礼 李元礼   1.81     80   FALSE     男    中 1992-06-14 24.4
#> 杨伯侨 杨伯侨   1.74     75    TRUE     男    优 1991-07-01 24.8
#> 赵蜚廉 赵蜚廉   1.78     78   FALSE     男    中 1990-08-08 24.6
#> 蒋欣     蒋欣   1.71     54   FALSE     女    良 1985-05-10 18.5
#> 沈约度 沈约度   1.72     61    TRUE     男    良 1993-04-01 20.6
#> 况天佑 况天佑   1.74     56   FALSE     男    良 1991-09-25 18.5
#> 马小玲 马小玲   1.72     82    TRUE     女    优 1988-02-14 27.7

# subset 逻辑表达式可以由多个逻辑表达式的逻辑运算结果构成，所以可以有多个条件的筛选
subset(employee, employee$height > 1.7 & employee$weight > 65, select = c("name", "gender", "bmi")) 
#>          name gender  bmi
#> 宋子启 宋子启     男 24.4
#> 孟轲舆 孟轲舆     男 23.0
#> 李元礼 李元礼     男 24.4
#> 杨伯侨 杨伯侨     男 24.8
#> 赵蜚廉 赵蜚廉     男 24.6
#> 马小玲 马小玲     女 27.7

head(employee) # 显示前6个元素
#>          name height weight islocal gender grade   birthday  bmi
#> 宋子启 宋子启   1.73     73    TRUE     男    中 1984-02-28 24.4
#> 张伯仲 张伯仲   1.68     70    TRUE     男    良 1988-09-26 24.8
#> 孟轲舆 孟轲舆   1.72     68   FALSE     男    良 1989-07-28 23.0
#> 张伟     张伟   1.65     60    TRUE     男    中 1990-01-25 22.0
#> 王雪梅 王雪梅   1.66     55   FALSE     女    优 1987-04-30 20.0
#> 陈梦妍 陈梦妍   1.62     52   FALSE     女    良 1989-12-20 19.8
```



