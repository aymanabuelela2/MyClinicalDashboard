load("./drugs.Rds")

rx_ui <- fluidPage(
    fluidRow(
        column(width = 12, selectizeInput("medName","Medication", width = '100%', choices = NULL))
    ),
    fluidRow(
        column(width = 2, numericInput("n", "", value = 1, min = 0, max = 10000)),
        column(
            width = 3,
            selectInput(
                "unit",
                "",
                c(
                    "tab",
                    "cap",
                    "ovule",
                    "drop",
                    "1 cm ribbon",
                    "g",
                    "mL",
                    "mg",
                    "mcg",
                    "pouch",
                    "packet",
                    "sachet",
                    "application",
                    "puff",
                    "inhalation",
                    "spray",
                    "nebule",
                    "inj",
                    "vial",
                    "amp",
                    "IU",
                    "other"
                )
            )
        ),
        column(
            width = 3, 
            selectInput(
                "route",
                "", 
                c(
                    "PO", 
                    "PR", 
                    "PV", 
                    "OU",
                    "OS",
                    "OD",
                    "AU",
                    "AS",
                    "AD",
                    "IM",
                    "SC",
                    "ID",
                    "IV",
                    "in each nostril",
                    "intranasally",
                    "topically",
                    ""
                )
            )
        ),
        column(
            width = 2, 
            selectInput(
                "freq", 
                "", 
                c(
                    "QD", 
                    "BID", 
                    "TID", 
                    "QID", 
                    "5x/day", 
                    "1x/wk", 
                    "2x/wk", 
                    "3x/wk", 
                    "4x/w", 
                    "5x/wk", 
                    "6x/wk", 
                    "MWF", 
                    "q2wk", 
                    "q1m", 
                    "q1h",
                    "q1-2h",
                    "q2h",
                    "q2-3h",
                    "q3h",
                    "q3-4h",
                    "q4h",
                    "q4-6h",
                    "q6h",
                    "q6-8h",
                    "q8h",
                    "q12h",
                    "q24h",
                    "q48h",
                    "q72h"
                )
            )
        ),
        column(
            width = 2,
            br(),
            checkboxInput("prn", "PRN", FALSE)
        )
    ),
    fluidRow(
        column(
            width = 2,
            numericInput("duration", "for", value = 1, min = 1, max = 99)
        ),
        column(
            width = 3,
            selectInput(
                "unitDuration",
                "",
                c("Day", "Week", "Month (28)", "Month (30)", "Year")
            )
        )
    ),
    fluidRow(
        column(
            width = 3,
            numericInput(
                "rxQty", 
                "Quantity",
                value = 10,
                min = 1,
                max = 1000
            )
        ),
        column(
            width = 3,
            numericInput(
                "refills",
                "Refills",
                value = 0,
                min = 0,
                max = 99
            )
        )
    ),
    hr(),
    h4("Prescriber details"),
    fluidRow(
        column(
            width = 6,
            selectInput(
                "pharmacist",
                "Pharmacist",
                c("Ayman Abuelela, RPh")
            )
        ),
        column(
            width = 6,
            selectInput(
                "pharmacy",
                "Pharmacy",
                c(
                    "SDM Mahogany #2371",
                    "SDM Seton #2366",
                    "Other"
                )
            )
        )
    ),
    conditionalPanel(
        condition = "input.pharmacy == 'Other'",
        textInput(width = '600px', "phcyAddress", "What is the pharmacy address?", placeholder = "St address, City, Province, Postal code")
    ),
    downloadButton("rx", "Generate Rx", class = "btn-success")
)

rx_server <- function(input, output) {
    # server size medication selection
    updateSelectizeInput(inputId = "medName", choices = drugs, server = TRUE)
    
    # REACTIVE VALUES
    reactVal <<- reactive({
        if (input$prn == TRUE) {
            prn <<- "PRN"
        } else {
            prn <<- ""
        }
        if (input$pharmacy == "SDM Mahogany #2371") {
            address <<- "7 Mahogany Plaza SE, Unit 610<br>Calgary, Alberta T3M 2P8<br>Phone:403-278-3606<br>Fax: 403-278-2514"
        } else {
            if (input$pharmacy == "SDM Seton #2366") {
                address <<- "19489 Seton Crescent SE, Unit 106<br>Calgary, Alberta T3M 1T4<br>Phone: 403-279-7726<br>Fax: 403-257-8067"
            } else{
                address <<- input$phcyAddress
            }
        }
    })
    
    # DOWNLOAD RX
    output$rx <- downloadHandler(
        filename = "Rx.html",
        
        content = function(file) {
            
            tempReport <- file.path(tempdir(), "Rx.Rmd")
            file.copy("./Rx/Rx.Rmd", tempReport, overwrite = TRUE)
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
                directions_n = input$n,
                med_dosageForm = input$unit,
                directions_route = input$route,
                directions_freq = input$freq,
                directions_prn = prn,
                directions_duration = input$duration,
                directions_uot = input$unitDuration,
                rx_qty = input$rxQty,
                rx_refills = input$refills
            )
            
            # render
            rmarkdown::render(tempReport, output_file = file, params = params, envir = new.env(parent = globalenv()))
        }
    )
}
