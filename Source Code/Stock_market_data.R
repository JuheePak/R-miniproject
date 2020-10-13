#주가분석 코스피
install.packages('xts')
install.packages('quantmod')
library(xts)
library(quantmod)

farm <- getSymbols('326030.KS', from='2020-01-01', to='2020-10-01', auto.assign = FALSE)
colnames(farm) <- c('open','high','low','close','volume','adjusted')
head(farm)
tail(farm)

farm <- farm[Vo(farm)>1]
farm
farm$rtn <- ROC(Cl(farm))
farm$rtn

head(farm$close,3)
tail(farm$close,1)
farm <- na.omit(farm)

mean(farm$rtn)

plot(farm$close, type='l' , col='blue' , main='sk바이오', cex.main=1)
mtext('종가')
abline(h=mean(farm$close),col='red')

plot(density(farm$rtn), type='l' , col='purple' , main='sk바이오', cex.main=1)
mtext('일일수익률분포')
abline(v=0,col='green')

barplot(farm$volume['2020-01-01::'],col='red' , main='sk바이오', cex.main=1)
mtext('거래량')

#주가분석 코스닥
install.packages("XML")
library(XML)

output <- g.hist2("KOSDAQ:083550", "2020-01-01", "2020-10-01")
output

plot(output$Date, output$Close, type="l")

library(XML)

g.hist2 <- function(ticker, start_date, end_date){
  
  #ticker set & modify
  ticker_m <- gsub(":","%3A",ticker)
  
  #set locale
  lct<-Sys.getlocale("LC_TIME")
  Sys.setlocale("LC_TIME", "C")
  
  #set date
  start_date = as.Date(start_date)
  end_date = as.Date(end_date)
  
  #format date for calling google finance url
  fmtstr <- "%b+%d%%2C+%Y" #ex) Jan+01,+2017
  start_date_fmt <- as.character(format(start_date, fmtstr))
  end_date_fmt <- as.character(format(end_date, fmtstr))
  
  #set URL
  url = 'http://www.google.com/finance/historical?q='
  url = paste(url,ticker_m,'&starfarmate=',start_date_fmt,'&enddate=',end_date_fmt,'&num=200',sep='')
  
  #downloading data from the Google Finance
  output <- as.data.frame(readHTMLTable(url,stringsAsfarmctors=farmLSE)[4])
  
  output[, 1] <- as.Date(output[, 1], format="%b %d, %Y")
  names(output) <- c("Date", "Open","High","Low","Close","Volume")
  
  for (k in 2:6){
    output[, k] <- as.numeric(gsub(",", "", output[, k]))
  }
  
  #### Checking whether all data are retrieved or farmt ####
  end <- as.Date(output[length(output[, 1]), 1])
  ll <- 200 - length(output[, 1])
  if ((end-ll)<start_date) end <- start_date
  if (end > start_date) {
    output <- rbind(output, g.hist2(ticker,start_date,as.character(end-1)))
  }
  
  return(output)
}