
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$disPlot1 <- renderPlot({

    set.seed(1909)
    a <- 0
    b <- t <- input$b
    nsim <- input$nmuestra
    m <- input$m
    #Monte Carlo crudo generando uniformes en [0,2].
    ################################################
    X1 <- runif(nsim, a, b)
    phi <- function (x) m*exp(-m*x)
    phi1<- phi(X1)
    estim1 <- mean (phi1)
    
    fun <- function(x) m*exp(-m*x)
    curve(fun(x))
    
    #gráficas
    hist(phi1, col="oldlace", main = "", ylab = "Frecuencia", xlab = "Función")
    par(new=TRUE)
    plot(fun,type="l",axes=FALSE, col="red",lwd=2, xlab="", ylab="", main="")
  })
    
  output$disPlot2 <- renderPlot({
    a <- 0
    b <- t <- input$b
    nsim <- input$nmuestra
    m <- input$m
    #Modifiquen su método de la función inversa para generar una muestra de una distribución exponencial con parámetro lambda truncada a 0,2. (HINT: calculen F(x | X \leq 2 ) = P(X\leq x |X\leq 2)=P(X \leq x)/P(X\leq 2) = P(X \leq x)/(1-exp(-2lambda)), por lo que su método de la función inversa ya creado solo se modifica por una constante).
    ############################################################################################################################################
    #los pesos
    w2 <- function(x) dunif(x, a, b)/dexp(x)
    f2 <- function(x) m*exp(-m*x)
    #FUNCIÓN EXPONENCIAL CON UNIFORMES 
    # definido con una uniforme y truncado de 0 a 2.
    fexp <- function(u, t, lam) {-log(1-u*(1-exp(-t*m)))/m}  
    #llamo a la exponencial n veces (nsim)
    callexp <- function(n, t, m) {fexp(runif(nsim), t, m)}
    #vector de exponenciales truncadas
    X2 <- callexp(nsim,t ,m)
    phi2 <- w2(X2)*f2(runif (nsim, a ,b))
    estim2 <- mean (phi2)
    
    fun <- function(x) m*exp(-m*x)
    curve(fun(x))
    
    #GRAFICAS
    hist(phi2, col = "ivory", main = "", ylab = "Frecuencia", xlab = "Función")
    par(new=TRUE)
    plot(fun,type="l",axes=FALSE, col="red",lwd=2, xlab="", ylab="", main="")
  })
  
  output$disPlot3 <- renderPlot({
    a <- 0
    b <- t <- input$b
    nsim <- input$nmuestra
    m <- input$m
    
    set.seed(1909)
    alpha <- 20
    beta <- 5
    w3 <- function(x) 1/dbeta(x,1,20)
    f3 <- function(x) m*exp(-m*x)
    X3 <- rbeta((runif (nsim, a ,b)), 1, 20)
    phi3=w3(X3)*2*mean(f3(X3))
    estim3 <- mean (phi3)
    
    fun <- function(x) m*exp(-m*x)
    curve(fun(x))
    
    #GRÁFICAS
    hist(phi3, col = "lightcyan1", main = "", ylab = "Frecuencia", xlab = "Función")
    par(new=TRUE)
    plot(fun,type="l",axes=FALSE, col="red",lwd=2, xlab="", ylab="", main="")
    
  })
  
  output$table1 <- renderTable({
    
  #PARA LOS INTERVALOS
  a <- 0
  b <- t <- input$b
  nsim <- input$nmuestra
  m <- input$m
  #Monte Carlo crudo generando uniformes en [0,2].
  ################################################
  X1 <- runif(nsim,a,b)
  phi <- function (x) m*exp(-m*x)
  phi1<- phi(X1)
  estim1 <- mean (phi1)
  
  #Modifiquen su método de la función inversa para generar una muestra de una distribución exponencial con parámetro lambda truncada a 0,2. (HINT: calculen F(x | X \leq 2 ) = P(X\leq x |X\leq 2)=P(X \leq x)/P(X\leq 2) = P(X \leq x)/(1-exp(-2lambda)), por lo que su método de la función inversa ya creado solo se modifica por una constante).
  ############################################################################################################################################
  #los pesos
  w2 <- function(x) dunif(x, a, b)/dexp(x)
  f2 <- function(x) m*exp(-m*x)
  #FUNCIÓN EXPONENCIAL CON UNIFORMES 
  # definido con una uniforme y truncado de 0 a 2.
  fexp <- function(u, t, lam) {-log(1-u*(1-exp(-t)))}  
  #llamo a la exponencial n veces (nsim)
  callexp <- function(n, t, m) {fexp(runif(nsim), t, m)}
  #vector de exponenciales truncadas
  X2 <- callexp(nsim,t ,m)
  phi2 <- w2(X2)*f2(runif (nsim, a ,b))
  estim2 <- mean (phi2)
  
  
  #incluir en la comparación la densidad beta con una elección inteligente de parámetros como en las notas.
  ##########################################################################################################
  w3 <- function(x) 1/dbeta(x,1,20)
  f3 <- function(x) m*exp(-m*x)
  X3 <- rbeta((runif (nsim, a ,b)), 1, 20)
  phi3=w3(X3)*(f3(X3))
  estim3 <- mean (phi3)
  
  intervalos <- c(estim1,estim2,estim3)
  var <- c(var(phi1),var(phi2),var(phi3))
  for (i in 1:3){
    me <- qnorm(.95)*(intervalos/sqrt(nsim))
    limsup<- intervalos + me
    liminf<- intervalos - me
  }
  
  inter <- cbind(liminf,limsup)
  
  table<- as.table(inter)
  rownames (table) [1] <- "Crudo"
  rownames (table) [2] <- "Exponencial"
  rownames (table) [3] <- "Beta"
  colnames(table) <- c("Límite inferior", "Límite superior")
  table
  })
  
  })
