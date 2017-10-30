# Exercice :

ui <- fluidPage(
  sliderInput(inputId = "bins", "Average alcohol consumption rate", min = 1, 
              max =5, value = 3, step = 0.1),
  plotOutput("the_plot"), 
  checkboxInput(inputId = "check1", label = "Absences", value = FALSE),
  numericInput(inputId = "per_1", label = "Choose a period", 
               value = 1, min = 1, max = 3, step = 1),
  numericInput(inputId = "per_2", label = "Choose a period", 
               value = 2, min = 1, max = 3, step = 1)
)
server <- function(input, output) {
  data <- read.csv("student-mat.csv")
  res1 <- data %>% 
    select("Dalc", "Walc", "absences", "G1", "G2", "G3") %>% 
    mutate(av_alc = (Dalc + Walc)/2) %>% 
    select("av_alc", "absences", "G1", "G2", "G3") 
  
 
  
    output$the_plot <- renderPlot({
      if(input$check1){
    res1[res1$av_alc <= input$bins,] %>% 
      ggplot(aes(x = G1, y = G2, size = absences, color = av_alc)) +
      geom_point() +
      xlab("Marks in the 1st period")+
      ylab("Marks in the 2nd period")+
      ggtitle("Dependence of Academic Results on Absences and Average Alcohol consumption")+
      geom_smooth(method = "lm", se = FALSE) + 
      scale_colour_gradientn(colours=rainbow(4))
      }
    else{
      res1[res1$av_alc <= input$bins,] %>% 
        ggplot(aes(x = G1, y = G2, color = av_alc)) +
        geom_point() +
        xlab("Marks in the 1st period")+
        ylab("Marks in the 2nd period")+
        ggtitle("Dependence of Academic Results on Average Alcohol consumption")+
        geom_smooth(method = "lm", se = FALSE) + 
        scale_colour_gradientn(colours=rainbow(4))
    }
    })
    
  
}
shinyApp(ui = ui, server = server)