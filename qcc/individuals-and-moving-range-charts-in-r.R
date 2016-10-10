
# https://tomhopper.me/2014/03/01/individuals-and-moving-range-charts-in-r/

library(qcc)
#' The data, from sample published by Donald Wheeler
my.xmr.raw <- c(5045,4350,4350,3975,4290,4430,4485,4285,3980,3925,3645,3760,3300,3685,3463,5200)
#' Create the individuals chart and qcc object
my.xmr.x <- qcc(my.xmr.raw, type = "xbar.one", plot = TRUE)
#' Create the moving range chart and qcc object. qcc takes a two-column matrix
#' that is used to calculate the moving range.
my.xmr.raw.r <- matrix(cbind(my.xmr.raw[1:length(my.xmr.raw)-1], my.xmr.raw[2:length(my.xmr.raw)]), ncol=2)
my.xmr.mr <- qcc(my.xmr.raw.r, type="R", plot = TRUE)
