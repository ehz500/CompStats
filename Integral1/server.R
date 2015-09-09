
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$disPlot1 <- renderPlot({

    # generación de uniformes
    
    montecarlo <- function(nmuestra,alpha){
      
      x<- runif(nmuestra,0,2)
      F1 <- 2*sqrt(4-x^2)
      means <- mean(F1)
      zetha <- qnorm(alpha/2,lower.tail = FALSE)
      Scuadrada <- var(F1)
      limsup <- means + zetha*sqrt(Scuadrada/nmuestra)
      liminf <- means - zetha*sqrt(Scuadrada/nmuestra)
      
      return(list(est=means, LimiteSuperior=limsup, LimiteInferior=liminf))
      
    }
    
    alpha1<-input$alpha
    
    N=seq(10,input$nmuestra,length=input$simulaciones)


    # gráficas
    a <- sapply(N,FUN=montecarlo,alpha=alpha1)
    b <- t(a)
    #c <- as.data.frame(b)
    #d <- data.frame(b)
    e <- cbind(b,col=3)
    plot(x=N,y=e[,1],type="l")
    lines(x=N,y=e[,2],col="green4")
    lines(x=N,y=e[,3],col="green4")
    abline(h=pi,col="red4",lwd=5)

  })
  
  output$disPlot2 <- renderPlot({
    
    # generación de uniformes
    
    montecarlo <- function(nmuestra,alpha){
      
      x<- runif(nmuestra,0,2)
      F1 <- 4/(1+x^2)
      means <- mean(F1)
      zetha <- qnorm(alpha/2,lower.tail = FALSE)
      Scuadrada <- var(F1)
      limsup <- means + zetha*sqrt(Scuadrada/nmuestra)
      liminf <- means - zetha*sqrt(Scuadrada/nmuestra)
      
      return(list(est=means, LimiteSuperior=limsup, LimiteInferior=liminf))
      
    }
    
    alpha1<-input$alpha
    
    N=seq(10,input$nmuestra,length=input$simulaciones)
    
    
    # gráficas
    a <- sapply(N,FUN=montecarlo,alpha=alpha1)
    b <- t(a)
    #c <- as.data.frame(b)
    #d <- data.frame(b)
    e <- cbind(b,col=3)
    plot(x=N,y=e[,1],type="l")
    lines(x=N,y=e[,2],col="green4")
    lines(x=N,y=e[,3],col="green4")
    abline(h=pi,col="red4",lwd=5)
    
  })

  output$disPlot3 <- renderPlot({
    
    # generación de uniformes
    
    montecarlo <- function(nmuestra,alpha){
      
      x<- runif(nmuestra,0,2)
      F1 <- 6/(sqrt(4-x^2))
      means <- mean(F1)
      zetha <- qnorm(alpha/2,lower.tail = FALSE)
      Scuadrada <- var(F1)
      limsup <- means + zetha*sqrt(Scuadrada/nmuestra)
      liminf <- means - zetha*sqrt(Scuadrada/nmuestra)
      
      return(list(est=means, LimiteSuperior=limsup, LimiteInferior=liminf))
      
    }
    
    alpha1<-input$alpha
    
    N=seq(10,input$nmuestra,length=input$simulaciones)
    
    
    # gráficas
    a <- sapply(N,FUN=montecarlo,alpha=alpha1)
    b <- t(a)
    #c <- as.data.frame(b)
    #d <- data.frame(b)
    e <- cbind(b,col=3)
    plot(x=N,y=e[,1],type="l")
    lines(x=N,y=e[,2],col="green4")
    lines(x=N,y=e[,3],col="green4")
    abline(h=pi,col="red4",lwd=5)
    
  }) 
})
