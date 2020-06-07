library(shiny)
library(datasets)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Car Mileage Data"),
    
    # Sidebar with controls to provide a caption, select a dataset, and 
    # specify the number of observations to view. Note that changes made
    # to the caption in the textInput control are updated in the output
    # area immediately as you type
    sidebarPanel(
        
        selectInput("dataset", "Choose a variable:", 
                    choices = c(
                        "cyl", "disp", "hp", "drat", "wt", "qsec",
                        "vs", "am", "gear", "carb")),
    ),
    
    
    # Show the caption, a summary of the dataset and an HTML table with
    # the requested number of observations
    mainPanel(
        tabsetPanel(type = "tab",
            tabPanel("Data", verbatimTextOutput("data")),
            tabPanel("Summary", verbatimTextOutput("summary")),
            tabPanel("Correlation", verbatimTextOutput("corr")), 
            tabPanel("Plot", plotOutput("varPlot"))
                    )
             )
))