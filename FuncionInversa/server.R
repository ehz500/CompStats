
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(datasets)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    set.seed(22)
    u    <- runif(10000)
    #head(x) primeros 6 valores
    #tail(x) ultimos 6 valores
    X <- (1/input$lambda)*log(1/(1-u))
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(X, breaks = 100, col = 'darkgray', border = 'white')
    #plot(X,u)
    
  })
  
  output$view <- renderTable({
    set.seed(22)
    u <- runif(10000)#Creo 
    #head(x,10)
    #tail(x)
    X <- (1/input$lambda)*log(1/(1-u))
    data <- as.data.frame(cbind(X,u))
    names(data) <- c("X","Probabilidad Acumulada")
    
    data
  })
})
