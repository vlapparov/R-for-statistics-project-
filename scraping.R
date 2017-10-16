library("rvest")
library("xml2")
library(stringr)
library("dplyr")

my_page <- read_html('https://en.wikipedia.org/wiki/President_of_Russia')
table <- html_table(my_page,fill = TRUE)
data <- table[[3]]
html_nodes(my_page)
cheese_nodes <- html_nodes(x = my_page, css = ".summary-points")
text_from_page <- html_text(cheese_nodes, trim = TRUE)
clean <- str_replace_all(text_from_page, "([\t])", "")
clean
dupl <- gsub(x = clean, pattern = "\n", replacement = "~")
dupl <- gsub(x = dupl, pattern = "~~", replacement = "~")
dupl
list <- strsplit(x = clean, split = "\n")
len <- list[[1]] %>% match("")
# t <- as.data.frame(text_from_page)
articles <- html_nodes(x = my_page, css = "[data-name]")
my_page <- read_html("https://www.cheese.com/feta/")
