
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Cálculo de Integrales por el método de Monte-Carlo"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("simulaciones",
                  "Número de simulaciones:",
                  min = 1,
                  max = 10000,
                  value = 30),
      
      sliderInput("alpha",
                  "Valor de alpha:",
                  min = .001,
                  max = .1,
                  value = .05),
    
      sliderInput("nmuestra",
                "Tamaño de la muestra:",
                min = 10,
                max = 10000,
                value = 500)
  ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Integral 1", plotOutput("disPlot1")), 
        tabPanel("Integral 2", plotOutput("disPlot2")), 
        tabPanel("Integral 3", plotOutput("disPlot3"))
      ),
      #plotOutput("distPlot"),
      strong("Tarea 3")
    )
  )
))
