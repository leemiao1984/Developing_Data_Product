library(shiny)
data(mtcars)

ModelFit <- lm(mpg ~ hp + cyl + wt + am, data=mtcars)

mpg <- function(hp, cyl, wt, am) {
  ModelFit$coefficients[1] + ModelFit$coefficients[2] * hp + 
    ModelFit$coefficients[3] * cyl + ModelFit$coefficients[4] * wt + ModelFit$coefficients[5]* am
}

shinyServer(
  function(input, output) {
    adjusted_weight <- reactive({input$wt/1000})
    predicted_mpg <- reactive({mpg(input$hp, as.numeric(input$cyl), adjusted_weight(),as.numeric(input$am))})
    output$inputValues <- renderPrint({paste(input$cyl, "cylinders, ",
                                             input$hp, "horsepower, ",
                                             input$wt, "lbs, ",
                                             input$am, "transmission")})
    output$prediction <- renderPrint({paste(round(predicted_mpg(), 2), "miles per gallon")})
    output$plots <- renderPlot({
      par(mfrow = c(2, 2))
      # (1, 1)
      with(mtcars, plot(hp, mpg,
                        xlab='Gross Horsepower',
                        ylab='MPG',
                        main='MPG vs Horsepower'))
      points(input$hp, predicted_mpg(), col='red', cex=3)                 
      # (1, 2)
      with(mtcars, plot(cyl, mpg,
                        xlab='Number of Cylinders',
                        ylab='MPG',
                        main='MPG vs Cylinders'))
      points(as.numeric(input$cyl), predicted_mpg(), col='red', cex=3)  
      # (2, 1)
      with(mtcars, plot(wt, mpg,
                        xlab='Weight (lb/1000)',
                        ylab='MPG',
                        main='MPG vs Weight'))
      points(adjusted_weight(), predicted_mpg(), col='red', cex=3)
      # (2, 2)
      with(mtcars, plot(wt, am,
                        xlab='Transmission',
                        ylab='MPG',
                        main='MPG vs Transmission'))
      points(as.numeric(input$am), predicted_mpg(), col='red', cex=3)  
    })
  }
)