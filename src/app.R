library(shiny)
library(markdown)
library(shinydashboard)
library(here)
source("./mypage.R")

# UI
ui <- mypage

# Server
server <- myserver

# Run the application 
shinyApp(ui = ui, server = server)

# To do:
## UTI resources panel
## DAP note textoutput
## DAP note HTML Report
## Dr letter
