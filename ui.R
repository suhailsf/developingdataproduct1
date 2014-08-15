library(shiny)

shinyUI (fluidPage(
    
    titlePanel("Mtcars dataset: simple variable exploration"),
    
    sidebarLayout(
        sidebarPanel(
            selectInput("variable","Chosse a variable",choices = c("Miles Per Gallon", "Weight","Displacement")),
            selectInput("variable1", "Choose another factor variable to compare", choices = c("Number of Cylinder","Type of Gear")),
            
            
            submitButton("Submit")
        ),
        
        mainPanel(
            h4("Summary of selected variable"),
            verbatimTextOutput("summary"),
            h4("Histogram of selected variable"),
            plotOutput("hist"),
            h4("Relationship among selected variable and factor variable"),
            plotOutput("boxplot")
        )
    )
))
