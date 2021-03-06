Developing data product: Shiny app 
========================================================
author: Suhail 
date: 8/18/2014

Shiny app: Mtcars dataset - simple variable exploration tool
========================================================

The link to the app is provided below:

http://suhailsf.shinyapps.io/developingdataproduct1/

Github code:

https://github.com/suhailsf/developingdataproduct1/tree/master


Shiny app: Mtcars dataset - simple variable exploration tool
========================================================

Objective:

To build a simple point and click app that allows an end user to explore
listed variable and compare the selected variable with the listed factor variable

Shiny app: Mtcars dataset - simple variable exploration tool
========================================================

Features of the app
- Simple point and click
- Drop down menu to select variable
- Summary and plots available to visualize the variable and relationship distribution

Shiny app : ui.R code
========================================================


```r
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
```

<!--html_preserve--><div class="container-fluid">
<h2 style="padding: 10px 0px;">Mtcars dataset: simple variable exploration</h2>
<div class="row-fluid">
<div class="span4">
<form class="well">
<label class="control-label" for="variable">Chosse a variable</label>
<select id="variable"><option value="Miles Per Gallon" selected>Miles Per Gallon</option>
<option value="Weight">Weight</option>
<option value="Displacement">Displacement</option></select>
<script type="application/json" data-for="variable" data-nonempty="">{}</script>
<label class="control-label" for="variable1">Choose another factor variable to compare</label>
<select id="variable1"><option value="Number of Cylinder" selected>Number of Cylinder</option>
<option value="Type of Gear">Type of Gear</option></select>
<script type="application/json" data-for="variable1" data-nonempty="">{}</script>
<div>
<button type="submit" class="btn btn-primary">Submit</button>
</div>
</form>
</div>
<div class="span8">
<h4>Summary of selected variable</h4>
<pre id="summary" class="shiny-text-output"></pre>
<h4>Histogram of selected variable</h4>
<div id="hist" class="shiny-plot-output" style="width: 100% ; height: 400px"></div>
<h4>Relationship among selected variable and factor variable</h4>
<div id="boxplot" class="shiny-plot-output" style="width: 100% ; height: 400px"></div>
</div>
</div>
</div><!--/html_preserve-->

Shiny app: server.R code
========================================================


```r
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
```
