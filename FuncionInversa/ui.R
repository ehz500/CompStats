
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Tarea 1 - Estadística Computacional, Distribución Exponencial"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("lambda",
                  "Seleccionar el parámetro Lambda",
                  min = 0.001,
                  max = 10000,
                  value = 1)
      #condición si lambda =0 no funcione
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      tableOutput("view")
    )
  )
))
