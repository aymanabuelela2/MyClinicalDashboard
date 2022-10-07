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
# cold sore
# conjunctivitis
# TDaP in pregnancy
# HPV
# remove non-unique entries in drugs.rds
# switch allergy list to unique medication names without strength or dosage form information, filter unique 
