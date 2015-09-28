
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny) 

shinyUI(fluidPage(
  # Application title
  titlePanel("Muestreo Prioritario (Importance Sampling)"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("nmuestra",
                  "Elige el tamaño de muestra:",
                  min = 1,
                  max = 100000,
                  value = 100),
      
      sliderInput("b",
                  "Elige b:",
                  min = 1,
                  max = 5,
                  value = 2),
      
      sliderInput("m",
                  "Elige lambda:",
                  min = .5,
                  max = 2,
                  value = 1)
    ),

      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel("Crudo", plotOutput("disPlot1")), 
          tabPanel("Con Exponencial", plotOutput("disPlot2")), 
          tabPanel("Con Beta", plotOutput("disPlot3"))
        
          ),
        #plotOutput("distPlot"),
        strong("Calculo de intervalos"),
        tableOutput("table1")
      )
    )
  ))