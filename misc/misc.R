
# if else 的正确写法
x <- -5
if(x > 0){
  print("Non-negative number")
} else { # 正确
  print("Negative number")
}

# else 不能作为一行语句的开头，它与 if 是一个整体的语句，否则会报错
# 这是常见错误
x <- -5
if(x > 0){
  print("Non-negative number")
} 
else { # 错误: 意外的'else' in "else"
  print("Negative number")
}



# Check if a Variable Exists in R

# if you use attach, it is easy to tell if a variable exists. You can simply use exists to check:
#   
# attach(df)
# 
# >exists("varName")
# [1] TRUE
# 
# However, if you don’t use attach (and I find you generally don’t want to), this simple solution doesn’t work.
# > detach(df)
# > exists("df$varName")
# [1] FALSE
# Instead of using exists, you can use in or any from the base package to determine if a variable is defined in a data frame:
#   > "varName" %in% names(df)
# [1] TRUE
# > any(names(df) == "varName")
# [1] TRUE
# Or to determine if a variable is defined in a matrix:
#   
#   > "varName" %in% colnames(df)
# [1] TRUE
# > any(colnames(df) == "varName")
# [1] TRUE
