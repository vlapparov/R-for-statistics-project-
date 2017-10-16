library("rvest")
library("xml2")

my_page <- read_html('https://en.wikipedia.org/wiki/President_of_Russia')
table <- html_table(my_page,fill = TRUE)
data <- table[[3]]
html_nodes(my_page)
# html_nodes(x = my_page, css = ".dt-blog-shortcode > .wf-cell")
articles <- html_nodes(x = my_page, css = "[data-name]")
# my_page <- read_html("http://thinkr.fr")
