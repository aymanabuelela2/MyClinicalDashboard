load("./drugs.Rds")

rx_ui <- fluidPage(
    fluidRow(
        column(width = 6, selectizeInput("medName","Medication", width = '100%', choices = NULL)),
        column(width = 2, numericInput("medStrength","Strength (mg)", value = 100,min = 0,max = 1000000)),
        column(width = 4, selectInput("medDosageform","Dosage form", c("Tablet", "Capsule", "Liquid", "inhaler", "Cream", "Ointment", "Gel", "Lotion", "Injection", "Eye drops", "Ear Drops")))
    ),
    fluidRow(
        column(width = 3, numericInput("n", "N", value = 1, min = 0, max = 1000, width = '100%')),
        column(width = 3, selectInput("route","Route", c("PO", "PR", "PV", "Intranasal"), width = '100%')),
        column(width = 3, selectInput("freq", "Frequency", c("QD", "BID", "TID", "QID"), width = '100%')),
        column(width = 3, numericInput("duration", "duration (days)", value = 7, min = 1, max = 365, width = '100%'))
    ),
    numericInput(
        "rxQty", 
        "Quantity Prescribed",
        value = 10,
        min = 1,
        max = 1000
    ),
    hr(),
    h4("Prescriber details"),
    selectInput(
        "pharmacist",
        "Pharmacist",
        c("Ayman Abuelela, RPh")
    ),
    selectInput(
        "pharmacy",
        "Pharmacy",
        c(
            "SDM Mahogany #2371",
            "SDM Seton #2366",
            "SDM Mardaloop #2387"
        )
    ),
    downloadButton("rx", "Generate Rx", class = "btn-success")
)

rx_server <- function(input, output) {
    updateSelectizeInput(inputId = "medName", choices = drugs, server = TRUE)
    output$rx <- downloadHandler(
        filename = "Rx.html",
        content = function(file) {
            tempReport <- file.path(tempdir(), "Rx.Rmd")
            file.copy("Rx.Rmd", tempReport, overwrite = TRUE)
            if (input$pharmacy == "SDM Mahogany #2371") {
                address <- "7 Mahogany Plaza SE, Unit 610<br>Calgary, Alberta T3M 2P8<br>Phone:403-278-3606<br>Fax: 403-278-2514"
            } 
            if (input$pharmacy == "SDM Seton #2366") {
                address <- "19489 Seton Crescent SE, Unit 106<br>Calgary, Alberta T3M 1T4<br>Phone: 403-279-7726<br>Fax: 403-257-8067"
            }
            params <- list(
                prescriber_name = input$pharmacist,
                prescriber_address = address,
                pt_name = input$ptName,
                pt_dob = input$ptDOB,
                pt_phn = input$ptPHN,
                pt_gender = input$ptGender,
                pt_tel = input$ptTel,
                pt_address = input$ptAddress,
                med_name = input$medName,
                med_strength = input$medStrength,
                med_dosageForm = input$medDosageform,
                directions_n = input$n,
                directions_route = input$route,
                directions_freq = input$freq,
                directions_duration = input$duration,
                rx_qty = input$rxQty
            )
            rmarkdown::render(tempReport, output_file = file, params = params, envir = new.env(parent = globalenv()))
        }
    )
}
