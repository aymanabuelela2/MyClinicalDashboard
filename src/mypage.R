source("./prescriber_container.R")
source("./conjunctivitis/conjunctivitis.R")
source("./uti/uti.R")
source("./tdap/tdap.R")
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
                icon = icon("fa-thin fa-mortar-pestle", verify_fa = FALSE),
                selected = TRUE
            ),
            
            ## Prescribe
            menuItem(
                "ClinDoc-Prescribe", 
                tabName = "prescribe", 
                icon = icon("fa-thin fa-prescription", verify_fa = FALSE),
                menuSubItem(tabName = "acne", text = "Acne", icon = icon("fa-solid fa-circle-dot", verify_fa = FALSE)),
                menuSubItem(tabName = "rhinitis", text = "Allergic Rhinitis", icon = icon("fa-solid fa-head-side-cough", verify_fa = FALSE)),
                menuSubItem(tabName = "dermatitis", text = "Atopic Dermatitis", icon = icon("fa-solid fa-hand-dots", verify_fa = FALSE)),
                menuSubItem(tabName = "canker", text = "Canker Sore", icon = icon("fa-solid fa-teeth-open", verify_fa = FALSE)),
                menuSubItem(tabName = "coldsore", text = "Cold Sore", icon = icon("fa-solid fa-viruses", verify_fa = FALSE)),
                menuSubItem(tabName = "conjunctivitis", text = "Conjunctivitis", icon = icon("fa-solid fa-eye", verify_fa = FALSE)),
                menuSubItem(tabName = "covid", text = "COVID-19", icon = icon("fa-solid fa-virus-covid", verify_fa = FALSE)),
                menuSubItem(tabName = "diaper", text = "Diaper Dermatitis", icon = icon("fa-solid fa-baby", verify_fa = FALSE)),
                menuSubItem(tabName = "dysmenorrhea", text = "Dysmenorrhea", icon = icon("fa-solid fa-venus", verify_fa = FALSE)),
                menuSubItem(tabName = "ec", text = "Emergency Contraception", icon = icon("fa-regular fa-clock", verify_fa = FALSE)),
                menuSubItem(tabName = "ed", text = "Erectile dysfunction", icon = icon("fa-solid fa-mars", verify_fa = FALSE)),
                menuSubItem(tabName = "gerd", text = "GERD", icon = icon("fa-solid fa-fire", verify_fa = FALSE)),
                menuSubItem(tabName = "hemorrhoids", text = "Hemorrhoids", icon = icon("fa-solid fa-chair", verify_fa = FALSE)),
                menuSubItem(tabName = "headache", text = "Headache", icon = icon("fa-solid fa-brain", verify_fa = FALSE)),
                menuSubItem(tabName = "hc", text = "Hormonal Contraceptive", icon = icon("fa-solid fa-tablets", verify_fa = FALSE)),
                menuSubItem(tabName = "impetigo", text = "Impetigo/Folliculitis", icon = icon("fa-solid fa-bacterium", verify_fa = FALSE)),
                menuSubItem(tabName = "influenza", text = "Influenza", icon = icon("fa-solid fa-lungs-virus", verify_fa = FALSE)),
                menuSubItem(tabName = "insect", text = "Insect Bites", icon = icon("fa-solid fa-mosquito", verify_fa = FALSE)),
                menuSubItem(tabName = "msk", text = "Muscloskeletal Sprains", icon = icon("fa-solid fa-dumbbell", verify_fa = FALSE)),
                menuSubItem(tabName = "onycho", text = "Onychomycosis", icon = icon("fa-solid fa-shoe-prints", verify_fa = FALSE)),
                menuSubItem(tabName = "oralthrush", text = "Oral Thrush", icon = icon("fa-solid fa-face-grin-tongue", verify_fa = FALSE)),
                menuSubItem(tabName = "shingles", text = "Shingles", icon = icon("fa-solid fa-virus", verify_fa = FALSE)),
                menuSubItem(tabName = "smoking", text = "Smoking Cessation", icon = icon("fa-solid fa-smoking", verify_fa = FALSE)),
                menuSubItem(tabName = "tdap", text = "TDaP for Pregnancy", icon = icon("fa-thin fa-person-pregnant", verify_fa = FALSE)),
                menuSubItem(tabName = "uti", text = "Urinary Tract Infection", icon = icon("fa-solid fa-toilet", verify_fa = FALSE))
            ),
            
            ## MedRev
            menuItem(
                "ClinDoc-MedRev", 
                tabName = "medrev", 
                icon = icon("fa-light fa-capsules", verify_fa = FALSE),
                badgeLabel = "Coming Soon!", badgeColor = "red"
            ),
            
            ## Travel
            menuItem(
                "ClinDoc-Travel", 
                tabName = "travel", 
                icon = icon("fa-light fa-syringe", verify_fa = FALSE),
                badgeLabel = "Coming Soon!", badgeColor = "red"
            ),
            
            ## Follow up
            menuItem("ClinDoc-FollowUp", 
                tabName = "fu", 
                icon = icon("fa-light fa-briefcase-medical", verify_fa = FALSE),
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
            tabItem(tabName = "coldsore"),
            tabItem(tabName = "conjunctivitis"),
            tabItem(tabName = "tdap", tdap_ui),
            tabItem(tabName = "uti",uti_ui),
            
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
    tdap_server(input, output)
    
    ## MedRev servers
    
    ## Travel servers
    
    ## FU servers
    
    ## resource path (to link external files)
    shiny::addResourcePath(prefix = "www", directoryPath = here::here("www"))
    
}