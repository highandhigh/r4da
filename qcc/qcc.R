

dau <- read.table(file = "clipboard", sep = "\t")

dau <- read.table(file = "clipboard", sep = "\t")

date <- read.table(file = "clipboard", sep = "\t", stringsAsFactors = FALSE)

dau <- dau$V1

date <- date$V1

hist(dau)

qqnorm(dau)

shapiro.test(dau)

qcc(dau, type="xbar.one")

t <- 10

for(t in (10:154)) {
qcc(dau[(t-10):t], type="xbar.one", title = date[t])
}
