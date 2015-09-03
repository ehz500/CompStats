
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
  
    #generación de semilla para que empiece la uniforme
    set.seed(1)

    # genera dos uniformes
    w    <- runif(input$tamano)
    z    <- runif(input$tamano)
    
    x=rep(0,input$tamano)
    y=rep(0,input$tamano)
    
    #normal con coordenadas polares
    for (i in 1:input$tamano){
      x[i] <- sqrt(-2*log(w[i]))*cos(2*pi*z[i])
      y[i] <- sqrt(-2*log(w[i]))*sin(2*pi*z[i])
      
    }
    

    # mostrar la gráfica de de las funciones de densidad
    plot(density(c(x,y)), main ="Representación Box Muller" , ylab = "Función de Densidad", col="blue")
    #lines(density(c(w,z)), main ="Representación Box Muller", ylab = "Función de Densidad", col="blue" )

  })

})
