library(shiny)
library(ggplot2)
library(tidyverse)
library(datasets)
attach(mtcars)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
    
    # By declaring datasetInput as a reactive expression we ensure that:
    #
    #  1) It is only called when the inputs it depends on changes
    #  2) The computation and result are shared by all the callers (it 
    #     only executes a single time)
    #
    datasetInput <- reactive({
        switch(input$dataset,
               "cyl" = cyl,
               "disp" = disp,
               "hp" = hp,
               "drat" = drat,
               "wt" = wt,
               "qsec" = qsec,
               "vs" = vs,
               "am" = am,
               "gear" = gear,
               "carb" = carb)
    })
    
    # The output$summary depends on the datasetInput reactive expression, 
    # so will be re-executed whenever datasetInput is invalidated
    # (i.e. whenever the input$dataset changes)
    
    output$data <- renderPrint({
        dataset <- datasetInput()
        MPG <- mtcars[,c("mpg", paste(input$dataset)),]
        MPG
    })
    
    output$summary <- renderPrint({
        dataset <- datasetInput()
        summary(dataset)
    })

    output$corr <- renderPrint({
        dataset <- datasetInput()
        cor(mpg, dataset)
    })
        
    output$varPlot <- renderPlot({
        dataset <- datasetInput()
        if((paste(input$dataset) == "cyl") | (paste(input$dataset) == "am") | (paste(input$dataset) == "gear") | (paste(input$dataset) == "vs") | (paste(input$dataset) == "carb")){
        boxplot(mpg~dataset, 
                xlab = paste(input$dataset),
                ylab = "mpg",
                main = paste("Boxplot: mpg vs", input$dataset),
                col = c("green", "blue", "red", "gray50"))
        } else {
        plot(mpg~dataset, 
             xlab = paste(input$dataset),
             ylab = "mpg",
             main = paste("Scatterplot: mpg vs", input$dataset),
             pch = 19)    
        }
        
    })
    
})