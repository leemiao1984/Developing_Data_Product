library(shiny)
shinyUI(pageWithSidebar(
  headerPanel('Course Project for Developing Data Products'),
  sidebarPanel(
    h3('Instructions'),
    p('Enter the Gross Horsepower, Cylinder Number, Car Weight, and Transmission Type below. The predicted MPG will be shown to the right.'),
    h3('Please Enter Predictors of MPG'),
    numericInput('hp', 'Gross Horsepower:', 140, min = 50, max = 330, step = 10), # example of numeric input
    radioButtons('cyl', 'Number of Cylinders:', c('4' = 4, '6' = 6, '8' = 8), selected = '4'), # example of radio button input
    numericInput('wt', 'Weight (lbs):', 3200, min = 1500, max = 5500, step = 100),
    radioButtons('am', 'Transmission Types:', c('automatic' = 0,'manual' = 1), selected ='automatic')
    ),
  mainPanel(
    h5('by Miao'),
    h3('Estimated MPG'),
    h4('Entered:'),
    verbatimTextOutput("inputValues"),
    h4('Which resulted in a prediction of:'),
    verbatimTextOutput("prediction"),
    h4('MPG relative to cars in mtcars data set'),
    plotOutput('plots'),
    h3('Method'),
    p('The purpose of this application is to help predict the mpg of cars based on dataset of "mtcars". A linear model was created using the mtcars dataset to fit the effect of 
      horsepower, number of cylinders, weight, and transmission type on the mpg.  Since the 
      only valid possibilities for number of cylinders in the dataset were 
      4, 6, and 8, the choice was limited using radio buttons.  For the car weight,
      reactive() is used to convert the user input weight into the units 
      used by the model.  Finally, a pre-set function using the 
      linear model is used to predict the mpg based on the three variables 
      input by the user.')
    )
  ))