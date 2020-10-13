library(stringr)

final_url<-c()
final_tit<-c()
final_date<-c()
mydate <- c(rep(20200702:20200731, 1), rep(20200801:20200831, 1), rep(20200901:20200930, 1))
#7월1일데이터제외

j <- NULL; mydate <- as.numeric(mydate)
length(mydate)*20*3 #5460개


for(j in mydate){
  
  i <- 1
  #크롤링    
  for(i in 1:3){
    # https://news.nate.com/recent?mid=n0100&type=c&date=20200101&page=2
    # https://news.nate.com/recent?cate=eco&mid=n0102&type=c&date=20200101&page=2
    
    url<-paste0("https://news.nate.com/recent?cate=eco&mid=n0102&type=c&date=", j, "&page=", i)
    b<-readLines(url, encoding = "euc-kr")
    nurl<-paste0("https:/", str_sub(b[str_detect(b, "class=\"lt1\">")], 14, end=-16))
    b2<-b[str_detect(b, "<strong class=\"tit\">")]
    tit <- str_sub(str_extract(b2, "(?<=tit).*(?=</strong>)"), 3, end=-2)[-c(21:22)]
    Sys.sleep(1)
    final_url<-c(final_url, nurl)
    final_tit<-c(final_tit, tit)
    final_date<-c(final_date, rep(j, length(tit)))
    cat("\n", i, "-", j)
  }
  j
}
Sys.sleep(3)

k<-1
final_con<-c()
for(k in 1 :length(final_url)){
  b<-readLines(final_url[k],encoding = "euc-kr")
  
  aindex<-which(str_detect(b,"<div id=\"realArtcContents\">"))  
  if(length(aindex) < 1){
    
    aindex<-which(str_detect(b,"<!-- 기사 내용 -->"))  
  }
  Sys.sleep(1)
  bindex<-which(str_detect(b,"<script language=\"javascript\" type=\"application/javascript\">"))  
  b2<-paste(b[aindex:bindex],collapse = " ")
  b2<-gsub("<.*?>|\t|google_ad_section_start","",b2) 
  b2<-str_sub(b2,30)
  
  final_con[k]<-b2
  cat("\n",k)
  
  
}
str(final_con)
length(final_con)

final_data<-cbind(final_url, final_tit, final_con)

getwd()

write.csv(final_data,"nate_news_79.csv",row.names = F)
save(final_data,file="nate_news_79.RData")



head(final_data)
final_data <- as.data.frame(final_data)

final_con <- as.character(final_data$final_con)
head(final_con)
str(final_con)

comments<-gsub("<.*?>","",final_con)
comments<-gsub("\t","",comments)

comments<-gsub("[][!#$%*,:;<=>@_`|‘~{}&★☆ㅋㅎ《》◈△▲▽▼○●◎◇◆□◁◀▷▶♤♠♡♥♧♣◉◈▣◐◑♨☏☎☜☞↖↘♭♩♪♬㈜]", " ",comments)

comments<-gsub("rdquo|gt|lt|nbsp|amp|quot|apos","",comments)

comments<-gsub("  "," ",comments)

comments<-gsub("\\^"," ",comments)

comments<-gsub("ㅠ|ㅜ|ㅡ"," ",comments)

comments<-gsub("\"|\n|+","",comments)

comments<-gsub("\\+","",comments)

comments<-gsub("/|!|\\*|\\+|\\@"," ",comments)

comments<-gsub("'","",comments)

comments<-gsub("\"","",comments)

comments<-gsub("\"","",comments)

comments<-gsub("=","",comments)

comments<-gsub("~|;|<|>","",comments)

comments<-gsub("\\?","",comments)

comments<-gsub("\\[.*?\\]","",comments)

comments<-gsub("\\(.*?\\)","",comments)

comments<-gsub("\\(|\\)"," ",comments)

comments<-gsub("\\]|\\[|\\(|\\)|:|-|\\,|\\."," ",comments)

comments<-gsub("\\!","",comments)

comments<-gsub("”|“|’|·|ⓒ","",comments)

head(comments)

save(comments,file="pre_pro_news_79.RData")
length(comments)
unique_date<- unique(final_date)

#불용어 stopwords

stw<-c("으로","하는","에서","입니다","합니다","있습니다","하고","에게","있는","라고","에도","이고","하게","또한","하기",
       "되는","되지","이라고","이고","라는","됩니다","않습니다","그리고","해야","때문","까지","하지","하여","해서","했습니다","부터"
       ,"있게","다시","하면","이다","있다","또는","했으며","게시","해주십시오","안녕하십니까","질문","것임","되었습니다",
       "이글","있었다","로는","하는것","않았습니다","되는데","하는","입니다","이라도","니요","에는","한다","한다고",
       "했다","없는","니까","되어","께서","인가요","아니면","이번","되고","아래","대한","있기","두고","지는","이로","으로만",
       "와중","봐도","있음에도","있을까","됐다","되고있는","하던","에선","된다면","했으면","들입니다","하면서","했지만",
       "어느","드립니다","겁니다","아닙니다","싶습니다","한다면","해주세요","인데","에서","바랍니다","이는","이라는","인데","하며","정도",
       "있도록","이나","않는","하였습니다","밖에","처럼","것으로","것은","그래서","그러니까","것이라고","말했습니다","말했다","그러면","있다고",
       "지금","그렇게","것이","때문에","앵커","재배포","이어","보면","같이","기자","앵커",
       "co","kr","com","이데일리","매일경제","관련기사","한국경제","중앙일보","조선일보","무단전재","위해","다르면","이후","위한","등을","이런",
       "무단","구독신청","hankyung","hankyung.com", "지난", "이날", "최근", "현재", "한편", "올해", "관해", "관하여", "통해서",
       "관련", "지난달", "이를", "경우", "통해", "이에", "다만", "같은", "하지만", "대해", "기준", "지난해", "특히", "가장", "것이다",
       "따라", "등이", "밝혔다", "만에", "이미", "가운데", "따르면", "추가", "각각", "그는")

stw2<-c("네이버","일보","닷컴","금지","바로가기","모바일","news","보세요","YTN", "MBN")


library(stringr)
i <- 1
for (i in 1 : length(unique_date)){
  date_index <- final_date == unique_date[i]
  date_com <- comments[date_index]
  data2<-str_split(date_com," ")
  ta <- unlist(data2)
  ta2 <- table(ta)
  sort(ta2,decreasing = T)[1:50]
  ta3 <- ta2[!names(ta2) %in% stw]
  sort(ta3,decreasing = T)[1:50]
  
  ta4 <- ta3[nchar(names(ta3)) > 1]
  sort(ta4,decreasing = T)[1:50]
  ta5 <- ta4[!str_detect(names(ta4),"\\d")]
  # ta6 <- sort(ta5,decreasing = T)[1:100]
  
  ss<-sapply(names(ta5),str_detect, stw2)
  ta6<-ta5[apply(ss,2,sum) == 0]
  ta7 <- sort(ta6,decreasing = T)[1:100]
  
  
  write.csv(ta7,paste0(unique_date[i],"nate_news.csv"),row.names=F)
  cat("\n",i) 
}


library(wordcloud)
library(extrafont)

for(i in 1:length(unique_date)){
  
  wm<-  read.csv(paste0(unique_date[i],"nate_news.csv"))
  head(wm)
  
  word_name<-as.character(wm[,1])
  freq<-as.numeric(wm[,2])
  
  
  #  good_color<-color.gradient(c(0.3176471,0.2392157,0.3176471,0.925),c(0.7098039,0.6588235,0.2392157,0.15),c(0.2392157,0.7098039,0.7098039,0.28),nslices=length(freq))
  windowsFonts(malgun=windowsFont("08SeoulHangang M"))
  
  
  png(paste0("news_word_cloud",unique_date[i],".png"),width = 500,height = 500)
  wordcloud(word_name,freq,c(8,1),random.order=FALSE,family='malgun')
  dev.off()
  
  cat("\n",i)
}

#install.packages("xlsx")

library(xlsx)

data2<-list()
for (i in 1:length(unique_date)){
  dat<-  read.csv(paste0(unique_date[i],"nate_news.csv"))
  data2[[i]]<-dat
  cat("\n",i)
}
data3<-do.call("cbind",data2)
head(data3)

dd<-data3[,seq(1,10,by=2)]
head(dd)
c(dd)
uni <- as.character(unique(unlist(dd)))

wb<-createWorkbook()
sheet <- createSheet(wb, "Sheet 1")

cs1 <- CellStyle(wb) + Alignment(horizontal="ALIGN_CENTER", vertical="VERTICAL_CENTER") + Border(color="black", position=c("TOP", "RIGHT" , "LEFT","BOTTOM"),pen=c("BORDER_MEDIUM","BORDER_MEDIUM","BORDER_MEDIUM","BORDER_MEDIUM"))
cs2 <- CellStyle(wb) + Border(color="black", position=c("LEFT","RIGHT","TOP", "BOTTOM"),pen=c("BORDER_THIN","BORDER_THIN","BORDER_THIN","BORDER_THIN"))

addDataFrame(data3, sheet, row.names = F, colnamesStyle=cs1)

for(i in 1:nrow(data3) ){ 
  Row<-getRows(sheet, rowIndex=(i+1))
  Cell<-getCells(Row,colIndex = 2)
  cs3<- CellStyle(wb) + Fill(foregroundColor="lightblue", backgroundColor="lightblue", pattern="SOLID_FOREGROUND")    
  setCellStyle(Cell[[1]], cs3)
}

saveWorkbook(wb, "newsdata_79.xlsx")

#일별 키워드-> 월별키워드
head(data2)
head(final_date)

library(stringr)
mon<-str_sub(final_date,end=-3)
mon2<-as.numeric(unique(mon))
mon2<-mon2[order(mon2)][-1]

head(data2)
length(data2)

names(data2)<-unique_date
head(data2)

j<-1

month_data<-list()
for(j in 1:length(mon2)){
  
  dd<-data2[str_detect((names(data2)),as.character(mon2[j]))]
  length(dd)
  dd2<-do.call("rbind",dd)
  ta<-tapply(dd2[,2],dd2[,1],sum)  
  head(dd2)
  ta2<-sort(ta,decreasing = T)[1:200]
  ta3<-cbind(names(ta2),ta2)
  month_data[[j]]<-ta3
  cat("\n",j)
  
}
length(month_data)


head(month_data)
class(month_data)

write.csv(month_data, "month_data_79.csv")
