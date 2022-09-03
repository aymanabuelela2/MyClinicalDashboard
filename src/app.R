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
