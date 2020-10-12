# R-miniproject

# `경제 뉴스의 핵심 키워드는 주식 시장에 영향을 미칠까?`

### 1. 프로젝트 주제 및 내용

- 경제 뉴스 데이터 크롤링을 통하여 2020년 1월부터 9월까지 월별 핵심 키워드를 추출한다. 추출한 핵심 키워드가 주식 시장과 상관관계가 있는지 알아본다.

### 2. 주제 선정 배경

- 주제 선정 배경: 

  경제뉴스를 보면 주식에 대한 이야기가 빠지지 않고 등장하며 더 나아가 실시간 검색어도 주식 관련 용어로 넘쳐난다. 금융공부를 시작하며 주식에 대한 지식을 쌓고 언론 보도와 주가 정보의 상관관계를 분석함으로써 두 데이터 사이의 객관적인 판단을 할 수 있는 지표를 제시하고자 주제를 정하게 되었다.

- 일정:

  - 9/25 ~ 9/28: 주제 선정 및 기능 분담, 일정 수립
  - 9/29 ~ 10/6: 자료 수집 및 전처리, 데이터 분석
  - 10/7 ~ 10/8: 분석 피드백 및 결과 도출
  - 10/9 ~ 10/11: ppt 제작 및 발표 준비, 최종 리뷰
  - 10/12: 프로젝트 발표


### 프로젝트 수행 방향

- R을 활용한 데이터분석 및 시각화
  - 데이터: 네이트(www.nate.com) 경제 뉴스 기사 데이터와 주가 정보 데이터 크롤링, 텍스트 마이닝, quantmod 패키지를 활용한 데이터
  - 그 외 MS-excel도 사용함
  - 데이터를 가공하고 분석하여 그에 맞는 인사이트 도출
  - 언론의 보도가 주식 시장에 미치는지 상관관계를 객관적으로 알아볼 수 있음

---

### R을 활용한 단기간 분석 미니 프로젝트

- 네이트 경제 뉴스 기사 (2020년 1월 1일 ~ 2020년 9월 30일) 까지 총 9개월의 뉴스 데이터를 크롤링하여 일별 키워드를 전처리/분석하였다.

- 각 일별 데이터의 키워드를 모아 각 월로 통합하여 해당 월의 뉴스 데이터 키워드와 주식 데이터를 비교한다. 

​           **한페이지(20개) x 3페이지 크롤링 x 총272일(결측치가 많은 2일치 데이터 제거) = 16,320개**

- 데이터의 양이 너무 많아 크롤링에 어려움을 겪어(속도가..), *1월-3월, 4월-6월, 7월-9월* 3개로 나누어 코드를 작성하고 크롤링하였다. 
- 일별로 경제 뉴스 기사를 크롤링하여 월 단위로 묶어 많이 나오는 키워드 순서로 저장하였다. (month_data_13_new.csv, month_data_46_new.csv, month_data_79_new.csv)
- 각 월별 키워드에서 주가 정보와 관련된 키워드 2개씩 뽑아 주가 정보의 상승/하락과 비교한다.
<<<<<<< HEAD
- 크롤링한 경제 뉴스 데이터 키워드와 KOSPI에 있는 관련 주식 정보를 분석한다.(Stock_market_data.R)
- 각 월별(2월, 6월, 9월의 워드클라우드) 파일 첨부 
- 각 월별 경제 뉴스 키워드가 정리된 파일(Test.xlsx)

![슬라이드1](C:\Users\juhee\miniproject\슬라이드1.JPG)

![슬라이드2](C:\Users\juhee\miniproject\슬라이드2.JPG)

![슬라이드3](C:\Users\juhee\miniproject\슬라이드3.JPG)

![슬라이드4](C:\Users\juhee\miniproject\슬라이드4.JPG)![슬라이드5](C:\Users\juhee\miniproject\슬라이드5.JPG)

![슬라이드6](C:\Users\juhee\miniproject\슬라이드6.JPG)

![슬라이드7](C:\Users\juhee\miniproject\슬라이드7.JPG)

![슬라이드8](C:\Users\juhee\miniproject\슬라이드8.JPG)

![슬라이드9](C:\Users\juhee\miniproject\슬라이드9.JPG)![슬라이드10](C:\Users\juhee\miniproject\슬라이드10.JPG)

![슬라이드11](C:\Users\juhee\miniproject\슬라이드11.JPG)

![슬라이드12](C:\Users\juhee\miniproject\슬라이드12.JPG)



![슬라이드13](C:\Users\juhee\miniproject\슬라이드13.JPG)



![슬라이드14](C:\Users\juhee\miniproject\슬라이드14.JPG)



![슬라이드15](C:\Users\juhee\miniproject\슬라이드15.JPG)



![슬라이드16](C:\Users\juhee\miniproject\슬라이드16.JPG)



![슬라이드17](C:\Users\juhee\miniproject\슬라이드17.JPG)



![슬라이드18](C:\Users\juhee\miniproject\슬라이드18.JPG)



![슬라이드19](C:\Users\juhee\miniproject\슬라이드19.JPG)



![슬라이드20](C:\Users\juhee\miniproject\슬라이드20.JPG)

![슬라이드21](C:\Users\juhee\miniproject\슬라이드21.JPG)

![슬라이드22](C:\Users\juhee\miniproject\슬라이드22.JPG)

![슬라이드23](C:\Users\juhee\miniproject\슬라이드23.JPG)

![슬라이드24](C:\Users\juhee\miniproject\슬라이드24.JPG)

![슬라이드25](C:\Users\juhee\miniproject\슬라이드25.JPG)

![슬라이드26](C:\Users\juhee\miniproject\슬라이드26.JPG)

![슬라이드27](C:\Users\juhee\miniproject\슬라이드27.JPG)

![슬라이드28](C:\Users\juhee\miniproject\슬라이드28.JPG)

![슬라이드29](C:\Users\juhee\miniproject\슬라이드29.JPG)