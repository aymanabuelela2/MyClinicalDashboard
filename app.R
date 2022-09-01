library(shiny)
library(markdown)
library(shinydashboard)
source("./mypage.R")

# UI
ui <- mypage

# Server
server <- myserver

# Run the application 
shinyApp(ui = ui, server = server)
