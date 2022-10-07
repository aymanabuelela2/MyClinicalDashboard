
# load libraries and source files -----------------------------------------

library(lubridate)
load("./drugs.Rds")
source("./Rx/Rx.R")
source("./patient.R")

xxx_ui <- fluidPage(
    
    # header ------------------------------------------------------------------
    h2("XXX"),

    # Patient Information -----------------------------------------------------
    fluidRow(patient),

    # Patient assessment -------------------------------------------------------
    fluidRow(
        tabBox(
            width = 12,
            title = "Patient Assessment",
            id = "xxx_patientAssessment",
            ## medical history
            tabPanel(
                "Medical History"
                
                ## Add medical hx questions
            ),

            ## medication history
            tabPanel(
                "Medication History"
                
                ## Add medication hx questions
            ),
                
            ## symptoms presentation
            tabPanel(
                "Clinical Presentation",
                
                ## Add clinical presentation questions
                checkboxGroupInput(
                    inputId = "xxx_sxs", 
                    label = "", 
                    choices = c(
                        ## add sxs here
                    ),
                    width = '800px'
                )
            ),

            ## Red flags and contraindications
            tabPanel(
                "Red flags"
                
                ## Add red flag quesitons
            ),

            ## Assessment
            tabPanel(
                "Assessment",
                radioButtons(
                    width = '800px',
                    "xxx_decision",
                    "According to the patient's clinical presentation, I decided to:",
                    c("Treat", "Refer"), selected = "Treat"
                ),
                conditionalPanel(
                    condition = "input.xxx_decision == 'Treat'",
                    textAreaInput(
                        width = '800px',
                        "xxx_rationale1",
                        "Rationale",
                        placeholder = "Patient's clinical presentation comply with XXX symptoms. Patient does not show red flags or concerning symptoms. Patient has history of XXX treatment and eligible for pharmacist prescribing for minor ailment."
                    )
                ),
                conditionalPanel(
                    condition = "input.xxx_decision == 'Refer'",
                    textAreaInput(
                        width = '800px',
                        "xxx_rationale2",
                        "Rationale",
                        placeholder = "Patient is showing one or more of red flags or concerning symmptoms and has to be referred to a physician for further assessment. Patient is not eligible at the moment for XXX self treatment or pharmacist prescribing for minor ailments."
                    )
                ),
            ),

            ## Resources
            tabPanel(
                "Resources",
                includeMarkdown("./xxx/xxx_resources.Rmd")
            )
        )
    ),

    fluidRow(

        # GOT ---------------------------------------------------------------------
        box(
            width = 4,
            title = "Goals of Therapy",
            status = "primary",
            solidHeader = TRUE,
            collapsible = TRUE,
            checkboxGroupInput(
                "xxx_got",
                "I discussed with the patient the following:",
                c(
                    ##add goals of therapy
                )
            ),
            textAreaInput(width = '800px',
                          "xxx_addgot",
                          "Additional Notes: "
            )
        ),


        # TTT ---------------------------------------------------------------------
        tabBox(
            width = 8,
            id = "xxx_ttt",
            title = "Treatment",

            # Non-pharm
            tabPanel(
                title = "Non-Pharmacologic",
                checkboxGroupInput(
                    width = '800px',
                    "xxx_nonpharm",
                    "I discussed the following with the patient:",
                    c(
                        ## Add non-pharm
                    )
                ),
                textAreaInput(
                    width = '800px',
                    "xxx_addnonpharm",
                    "Additional Notes: "
                )
            ),

            # Pharm
            tabPanel(
                title = "Pharmacologic",
                
                ## Add pharmacologic choices
                
                hr(),
                rx_ui
            )
        )
    ),

    fluidRow(

        # Follow up ---------------------------------------------------------------
        box(
            width = 4,
            title = "Monitoring & Follow up Plan",
            status = "primary",
            solidHeader = TRUE,
            collapsible = TRUE,
            fluidRow(
                column(width = 5, numericInput("xxx_fuSchedule", "Follow up in ", value = 3, min = 0, max = 99)),
                column(width = 3, selectInput("xxx_fuUOT", "_", c("minutes", "hours", "days", "weeks", "months"), selected = "days")),
                column(
                    width = 4,
                    selectInput(
                        "xxx_fuMeans",
                        "By: ",
                        c("In-peson", "By phone")
                    )
                )
            ),
            checkboxGroupInput(
                "xxx_fuItems",
                "I will follow up with the patient on the following:",
                c(
                    ## Add follow up items
                )
            )
        ),

        # DAP note & Dr letter ----------------------------------------------------

        tabBox(width = 8,
               id = "xxx_doc",
               title = "Document & Collaborate",

               # DAP note
               tabPanel(
                   title = "DAP note",
                   h4("Data:"),
                   textOutput("xxx_dataHx"),
                   textOutput("xxx_dataHx2"),
                   textOutput("xxx_dataHx3"),
                   textOutput("xxx_dataSx"),
                   textOutput("xxx_dataRedFlags"),
                   hr(),

                   # assessment
                   h4("Assessment:"),
                   textOutput("xxx_assessment"),
                   hr(),

                   # plan
                   h4("Plan:"),
                   textOutput("xxx_plan"),
                   hr(),

                   # Export DAP note
                   downloadButton(
                       "xxx_exportDAP",
                       "Export DAP note", class = "btn-success"
                   )
               ),

               # DR letter
               tabPanel(
                   title = "Dr Letter",
                   textInput("drfirst", "Dr's First Name"),
                   textInput("drlast", "Dr's Last Name"),
                   textInput("drfax", "Dr's Fax Number"),
                   downloadButton("xxx_dr", label = "Generate letter", class = 'btn-success')
               )
        )
    )
)

xxx_server <- function(input, output) {
    # allergies selection
    updateSelectizeInput(
        inputId = "xxx_allergies",
        choices = drugs,
        server = TRUE
    )

    # prior treatment to medication selection
    # updateSelectizeInput(
    #     inputId = "uti_priorMed",
    #     choices = drugs,
    #     server = TRUE,
    #     selected = "NITROFURANTOIN"
    # )

    # Rx
    rx_server(input, output)


    # Server: DAP text output -------------------------------------------------

    # Data
    ## Hx
    output$xxx_dataHx <- renderText({
        # age
        age <- trunc(as.Date(input$ptDOB) %--% Sys.Date() / years(1))

        # render text
        hx <<- paste0(input$ptName, " is a ", age, " years old ", tolower(input$ptGender),
                      " who presented to the pharmacy asking for a prescription for XXX. "
        )
        hx
    })

    output$xxx_dataHx2 <- renderText({
        # Medical Hx
        hx2 <<- paste0()
        hx2
    })

    output$xxx_dataHx3 <- renderText({
        ## Medication hx
        hx3 <<- paste0()
        hx3
    })

    ## Clinical presentation
    output$xxx_dataSx <- renderText({

        if (length(input$xxx_sxs) > 0) {
            sxs <<- paste0(tolower(input$xxx_sxs), collapse = ", ")
        } else {
            sxs <<- "no symptoms"
        }

        #render text
        dataSx <<- paste0("Patient presented with ", sxs, ". ")
        dataSx
    })

    ## Red Flags
    output$xxx_dataRedFlags <- renderText({
        

        # render text
        dataRedFlags <<- paste0()
        dataRedFlags
    })

    # DAP Assessment
    output$xxx_assessment <- renderText({
        if (input$xxx_rationale1 == "" & input$xxx_decision == "Treat") {
            assessment <<- "Treat: Patient's clinical presentation comply with XXX symptoms. Patient does not show red flags or concerning symptoms. Patient has history of XXX treatment and eligible for pharmacist prescribing for minor ailment. "
        } else {
            if (input$xxx_rationale2 == "" & input$xxx_decision == "Refer") {
                assessment <<- "Refer: Patient is showing one or more of red flags or concerning symmptoms and has to be referred to a physician for further assessment. Patient is not eligible at the moment for XXX self treatment or pharmacist prescribing for minor ailments."
            } else {
                if (input$xxx_decision == "Treat") {
                    assessment <<- paste0(input$xxx_decision, ": ", input$xxx_rationale1)
                } else {
                    assessment <<- paste0(input$xxx_decision, ": ", input$xxx_rationale2)
                }
            }
        }

        # render text
        assessment
    })

    # DAP plan
    output$xxx_plan <- renderText({
        ## Treatment
        ttt <<- paste0(
            "After discussing the possible therapeutic alternatives for XXX treatment with the patient, I prescribed ",
            input$medName, " ", input$n, " ", input$unit,
            " ", input$route, " ", input$freq, " for ",
            input$duration, " ", input$unitDuration, ". "
        )

        ## Follow up
        fu <<- paste0(
            "I will follow up with patient in ", input$xxx_fuSchedule, " ",
            input$xxx_fuUOT, " ", tolower(input$xxx_fuMeans), " on the folowing: ",
            paste0(input$xxx_fuItems, collapse = ", "), ". "
        )

        # render text
        plan <<- paste0(ttt, fu)
    })

    # Server: generate DAP note -----------------------------------------------
    output$xxx_exportDAP <- downloadHandler(
        filename = "xxx_dap.html",
        content = function(file) {
            tempReport <- file.path(tempdir(), "xxx_dap.Rmd")
            file.copy("./xxx/xxx_dap.Rmd", tempReport, overwrite = TRUE)

            # passing input parameters
            params <- list(
                pt_name = input$ptName,
                pt_dob = input$ptDOB,
                pt_phn = input$ptPHN,
                pt_gender = input$ptGender,
                pt_tel = input$ptTel,
                pt_address = input$ptAddress,
                hx = hx,
                hx2 = hx2,
                hx3 = hx3,
                dataSx = dataSx,
                dataRedFlags = dataRedFlags,
                assessment = assessment,
                plan = plan,
                prescriber_name = input$pharmacist
            )

            # render
            rmarkdown::render(tempReport, output_file = file, params = params, envir = new.env(parent = globalenv()))
        }
    )


    # Server: generate Dr letter ----------------------------------------------
    output$xxx_dr <- downloadHandler(
        filename = "xxx_dr.html",
        content = function(file) {
            tempReport <- file.path(tempdir(), "xxx_dr.Rmd")
            file.copy("./xxx/xxx_dr.Rmd", tempReport, overwrite = TRUE)

            # passing input parameters
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
                rx_refills = input$refills,
                hx = hx,
                hx2 = hx2,
                hx3 = hx3,
                dataSx = dataSx,
                dataRedFlags = dataRedFlags,
                assessment = assessment,
                plan = plan,
                drfirst = input$drfirst,
                drlast = input$drlast,
                drfax = input$drfax
            )

            # render
            rmarkdown::render(tempReport, output_file = file, params = params, envir = new.env(parent = globalenv()),)
        }
    )

}