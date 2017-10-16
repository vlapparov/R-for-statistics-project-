library("rvest")
library("xml2")
library("stringr")
library("dplyr")

# my_page <- read_html('https://en.wikipedia.org/wiki/President_of_Russia')
# table <- html_table(my_page,fill = TRUE)
# data <- table[[3]]
# html_nodes(my_page)
my_page <- read.csv("https://www.kaggle.com/uciml/student-alcohol-consumption/downloads/student-mat.csv")
cheese_nodes <- html_nodes(x = my_page, css = ".data-view__button-download")
text_from_page <- html_text(cheese_nodes, trim = TRUE)
clean <- str_replace_all(text_from_page, "([\t])", "")
clean
# dupl <- gsub(x = clean, pattern = "\n", replacement = "~")
# dupl
list <- strsplit(x = clean, split = "\n")
t <- as.data.frame(list)

