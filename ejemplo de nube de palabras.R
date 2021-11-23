install.packages("devtools")

library(devtools)

devtools::install_github("Ichiffon/wordcloud2")

install.packages("wordcloud2")
library(wordcloud2)
library(tm)

wordcloud2(data=demoFreq, size=0.7)
wordcloud2(data=demoFreq, size=0.7, color=rep_len(c("pink", "green"), nrow(demoFreq)))
wordcloud2(data=demoFreq, size=0.7, color="random-light", backgroundColor="Black")
wordcloud2(data=demoFreq, size=0.7, shape="star",backgroundColor="Black")
