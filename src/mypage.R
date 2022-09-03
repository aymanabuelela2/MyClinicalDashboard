source("./uti/uti.R")
source("./overview.R")
load("./prescribe_conditions.Rds")

mypage <- dashboardPage(
    # skin
    skin = 'blue',
    
    # header
    dashboardHeader(title = "My Clinical Dashboard", titleWidth = '300px'),
    
    # sidebar
    dashboardSidebar(
        width = '300px',
        sidebarMenu(
            ## Home
            menuItem(
                "Overview",
                tabName = "overview",
                icon = icon("fa-thin fa-mortar-pestle"),
                selected = TRUE
            ),
            
            ## Prescribe
            menuItem(
                "ClinDoc-Prescribe", 
                tabName = "prescribe", 
                icon = icon("fa-thin fa-prescription"),
                menuSubItem(
                    tabName = "prescribe1",
                    selectInput(
                        inputId = "prescribe_condition",
                        label = "Medical Condition",
                        prescribe_conditions
                    )
                )
            ),
            
            ## MedRev
            menuItem(
                "ClinDoc-MedRev", 
                tabName = "medrev", 
                icon = icon("fa-light fa-capsules"),
                badgeLabel = "Coming Soon!", badgeColor = "red"
            ),
            
            ## Travel
            menuItem(
                "ClinDoc-Travel", 
                tabName = "travel", 
                icon = icon("fa-light fa-syringe"),
                badgeLabel = "Coming Soon!", badgeColor = "red"
            ),
            
            ## Follow up
            menuItem("ClinDoc-FollowUp", 
                tabName = "fu", 
                icon = icon("fa-light fa-briefcase-medical"),
                badgeLabel = "Coming Soon!", badgeColor = "red"
            )
        )
    ),
    
    # Body
    dashboardBody(
        tabItems(
            ## Overview
            tabItem(
                tabName = "overview",
                overview_ui
            ),
            
            ## Prescribe
            tabItem(tabName = "prescribe"),
            tabItem(
                tabName = "prescribe1",
                uti_ui
            ),
            
            ## MedRev
            tabItem(
                tabName = "medrev"
            ),
            
            ## Travel
            tabItem(
                tabName = "travel"
            ),
            
            ## Follow up
            tabItem(
                tabName = "fu"
            )
        )
    )
)

myserver <- function(input, output) {
    ## Prescribe servers
    uti_server(input, output)
    
    ## MedRev servers
    
    ## Travel servers
    
    ## FU servers
    
    ## 
    shiny::addResourcePath("src/ext_files", here::here("src/ext_files"))
    
}