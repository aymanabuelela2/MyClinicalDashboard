library(shiny)
library(markdown)
library(shinydashboard)
source("./mypage.R")

# UI
ui <- mypage


# Server
server <- function(input, output) {
    ## Prescribe servers
    uti_server(input, output)
    
    ## MedRev servers
    
    ## Travel servers
    
    ## FU servers
}

# Run the application 
shinyApp(ui = ui, server = server)
