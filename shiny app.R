# Exercice :

ui <- fluidPage(
  sliderInput(inputId = "bins", "Average alcohol consumption rate", min = 1, 
              max =5, value = c(2,3), step = 0.1),
  plotOutput("the_plot"), 
  checkboxInput(inputId = "check1", label = "Absences", value = FALSE),
  numericInput(inputId = "per_1", label = "Choose a period for 1st axis", 
               value = 1, min = 1, max = 3, step = 1),
  numericInput(inputId = "per_2", label = "Choose a period for 2nd axis", 
               value = 2, min = 1, max = 3, step = 1),
  textOutput("interv")
)
server <- function(input, output) {
  data <- read.csv("student-mat.csv")
  
  res1 <- data %>% 
    select("Dalc", "Walc", "absences", "G1", "G2", "G3") %>% 
    mutate(av_alc = (Dalc + Walc)/2) %>% 
    select("av_alc", "absences", "G1", "G2", "G3") 
  
    output$the_plot <- renderPlot({
      if(input$check1){
    temp <- res1[res1$av_alc %in% seq(input$bins[1], input$bins[2], 0.1),] 
    
      ggplot(data= temp, aes(temp[[input$per_1+2]], temp[[input$per_2+2]], size = absences, color = av_alc)) +
      geom_point() +
      xlab(paste("Marks in the period", input$per_1))+
      ylab(paste("Marks in the period", input$per_2))+
      ggtitle("Dependence of Academic Results on Absences and Average Alcohol consumption")+
      geom_smooth(method = "lm", se = FALSE) + 
      scale_colour_gradientn(colours=rainbow(4))
      }
    else{
      temp <- res1[res1$av_alc %in% seq(input$bins[1], input$bins[2], 0.1),]
      
        ggplot(data= temp, aes(temp[[input$per_1+2]], temp[[input$per_2+2]], color = av_alc)) +
        geom_point() +
        xlab(paste("Marks in the period", input$per_1))+
        ylab(paste("Marks in the period", input$per_2))+
        ggtitle("Dependence of Academic Results on Average Alcohol consumption")+
        geom_smooth(method = "lm", se = FALSE) + 
        scale_colour_gradientn(colours=rainbow(4))
    }
    })
    
  
}
shinyApp(ui = ui, server = server)