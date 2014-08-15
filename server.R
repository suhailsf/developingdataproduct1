library(shiny)
library(datasets)



shinyServer(function(input, output)
{
    variable_input <- reactive({
        switch(input$variable, "Miles Per Gallon" = mtcars$mpg, "Weight" = mtcars$wt, "Displacement" = mtcars$disp)
    })
    
    variable_input1 <- reactive ({
        switch(input$variable1, "Number of Cylinder" = mtcars$cyl, "Type of Gear" = mtcars$gear)
    }
    )
    output$summary <- renderPrint({
        variable <- variable_input()
        summary(variable)
    })
    output$hist <- renderPlot({
        hist(variable_input(),xlab = "Distribution",ylab="Count", col = "dark blue", main = "", breaks = 10)
    }
    )
    
    output$boxplot <- renderPlot({
        boxplot(variable_input() ~ variable_input1(), xlab = "Factor variable", ylab = "Selected variable", col = "dark blue")
    }
    )
    
})