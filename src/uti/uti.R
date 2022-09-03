load("./drugs.Rds")
source("./Rx/Rx.R")
source("./patient.R")

uti_ui <- conditionalPanel(
    condition = "input.prescribe_condition == 'Urinary Tract Infection'", 
    h2("Uncomplicated Urinary Tract Infection"),
    fluidRow(
        # patient information
        patient
    ),
    fluidRow(
        
        # Patient Assessment
        tabBox(
            width = 12,
            title = "Patient Assessment",
            id = "uti_patientAssessment",
            ## medical history
            tabPanel(
                "Medical History",
                radioButtons(
                    "uti_pbf",
                    "Pregnant or Breastfeeding",
                    c("Pregnant", "Breastfeeding", "No", "N/A")
                ),
                radioButtons(
                    "uti_ckd",
                    "Does the patient have CKD?",
                    c("No", "Yes")
                ),
                conditionalPanel(
                    condition = "input.uti_ckd == 'Yes'",
                    sliderInput(
                        "uti_crcl",
                        "CrCl/eGFR",
                        min = 0,
                        max = 180,
                        value = 120
                    )
                ),
                radioButtons(
                    "uti_prevEpisodes",
                    "Previous episodes of UTI diagnosed?",
                    c("No", "Yes")
                ),
                radioButtons(
                    "uti_recentEpisode",
                    "Previoius episode of UTI within 14 days: ",
                    c("No", "Yes")
                ),
                radioButtons(width = '800px',
                             "uti_immunocomp",
                             "Does the patient have immunocomprimising condition including uncontrolled diabetes?",
                             c("No", "Yes")
                ),
                radioButtons(width = '800px',
                             "uti_abnormalStructure",
                             "Does the patient have abnormal urinary tract function or structure? (indwelling catherter, neurogenic bladder, renal stones, renal dysfunction, etc.)",
                             c("No", "Yes")
                ),
                radioButtons(
                    "uti_maleOrChild",
                    "Is the patient male or < 16 years of age?",
                    c("No", "Yes")
                ),
                textAreaInput(width = '800px',
                              "uti_addhx",
                              "Additional Notes: "
                ),
            ),
            
            ## medication history
            tabPanel(
                "Medication History",
                radioButtons(width = '800px',
                             "uti_immunosuppressors",
                             "Does the patient take a medication which supresses the immune system?",
                             c("Yes", "No"), selected = "No"
                ),
                radioButtons(width = '800px',
                             "uti_cysititisMed",
                             "Does the patient take a medication which can cause cyctitis? (cyclophosphamide, allopurinol, tiaprofenic acid)",
                             c("Yes", "No"), selected = "No"
                ),
                selectizeInput(
                    inputId = "uti_allergies",
                    label = "Allergies:",
                    choices = NULL,
                    multiple = TRUE
                ),
                h4("Prior treatment for UTI:"),
                selectizeInput("uti_prior","Medication", choices = NULL),
                textInput("uti_effect", "Effect", placeholder = "Effective/Not effective"),
                textInput("uti_tolerance", "Tolerance", placeholder = "Tolerable/Not tolerable")
            ),
            
            ## symptoms presentation
            tabPanel(
                "Clinical Presentation",
                radioButtons(
                    width = '800px',
                    "uti_sxs",
                    "Does the patient have two or more of the following:",
                    c("Dysuria", "Frequency/Urgency", "Suprapubic disccomfort", "No vaginal symptoms", "None")
                )
            ),
            
            ## Red flags and contraindications
            tabPanel(
                "Red flags",
                
                radioButtons(
                    width = '800px',
                    "uti-pyelo",
                    "Are any signs of pyelonephritis present?",
                    c("Fever", "Chills", "Nausea and vomiting", "Flank or Back pain", "Significant malaise", "None")
                ),
                radioButtons(
                    width = '800px',
                    "uti_othersxs",
                    "Are any other unusual symptoms present?",
                    c("Vaginal discharge or itch", "Dyspareunia", "Other significan symptoms", "None")
                )
            ),
            
            ## Assessment
            tabPanel(
                "Assessment",
                radioButtons(
                    width = '800px',
                    "uti_assessment",
                    "According to the patient's clinical presentation, I decided to:",
                    c("Treat", "Refer"), selected = "Treat"
                ),
                textAreaInput(
                    width = '800px',
                    "uti_rationale",
                    "Rationale"
                )
            ),
            
            ## Resources
            tabPanel(
                "Resources",
                includeMarkdown("./uti/uti_resources.Rmd")
            )
        )
    ),
    
    fluidRow(
        
        # GOT
        box(
            width = 4,
            title = "Goals of Therapy",
            status = "primary", 
            solidHeader = TRUE,
            collapsible = TRUE,
            checkboxGroupInput(
                "uti_got",
                "I discussed with the patient the following:",
                c(
                    "Relieve symptoms in acute infection",
                    "Prevent complications of untreated acute infection",
                    "Prevent recurrent infection",
                    "Prevent pyelonephritis in pregnancy"
                )
            ),
                textAreaInput(width = '800px',
                              "uti_addgot",
                              "Additional Notes: "
                )
        ),
        
        # ttt
        tabBox(
            width = 8,
            id = "uti_ttt", 
            title = "Treatment",
            
            # Non-pharm
            tabPanel(
                title = "Non-Pharmacologic",
                checkboxGroupInput(
                    width = '800px',
                    "uti_nonpharm",
                    "I discussed the following with the patient:",
                    c(
                        "increased water intake may decrease the risk of UTI recurrence (low quality evidence)",
                        "The use of spermicidal products is associated with recurrent UTI in women and should be avoided in those at risk of recurrence."
                    )
                ),
                    textAreaInput(
                        width = '800px',
                        "uti_addnonpharm",
                        "Additional Notes: "
                )
            ),
            
            # Pharm
            tabPanel(
                title = "Pharmacologic",
                h4("First Line:"),
                h5("Nitrofurantoin (Macrobid) 100mg PO BID x 5 days"),
                h4("Second Line:"),
                h5("Sulfamethoxazole/trimethoprim 800mg/160mg PO BID x 3 days"),
                h5("Trimethoprim 100mg PO BID x 3 days"),
                h5("Trimethoprim 200mg PO QD x 3 days"),
                h5("Fosfomycin 3g dissolve in 1/2 cup of cold water PO QD x 1 day"),
                hr(),
                rx_ui
            )
        )
    ),
    
    fluidRow(
        
        # FU
        box(
            width = 4,
            title = "Monitoring & Follow up Plan",
            status = "primary",
            solidHeader = TRUE,
            collapsible = TRUE,
            fluidRow(
                column(width = 5, numericInput("uti_fuSchedule", "Follow up in ", value = 3, min = 0, max = 99)),
                column(width = 3, selectInput("uti_fuUOT", "_", c("minutes", "hours", "days", "weeks", "months"), selected = "days")),
                column(
                    width = 4, 
                    selectInput(
                        "uti_fuMeans",
                        "By: ",
                        c("In-peson", "By phone")
                    )
                )
            ),
            checkboxGroupInput(
                "uti_fuItems",
                "I will follow up with the patient on the following:",
                c(
                    "Assess for significant improvement in all symptoms",
                    "Determine if side effects are occurring (esp. severe diarrhea or rash)",
                    "If worsening or not improving, refer to MD",
                    "If improving, encourage continued use until the end of therapy if greater than 3 days"
                )
            )
        ),
        
        # DAP & Dr Letter
        tabBox(width = 8,
            id = "uti_doc",
            title = "Document & Collaborate",
            
            # DAP note
            tabPanel(
                title = "DAP note",
                h4("Data:"),
                h5("*Medical history: "),
                textOutput("uti_pbf"),
                textOutput("uti_ckd"),
                conditionalPanel(
                    condition = "input.uti_ckd == 'Yes'",
                    textOutput("uti_crcl")
                ),
                textOutput("uti_prevEpisodes"),
                textOutput("uti_recentEpisode"),
                textOutput("uti_immunocomp"),
                textOutput("uti_abnormalStructure"),
                textOutput("uti_maleOrChild"),
                textOutput("uti_addhx"),
                
                h5("*Medication hitory:"),
                textOutput("uti_immunosupressors"),
                textOutput("uti_cysititisMed"),
                
                h5("Prior treatment for UTI: "),
                
                h5("*Clinical Presentation:"),
                
                h5 ("*Red Flags"),
                hr(),
                
                # assessment
                h4("Assessment:"),
                hr(),
                
                # plan
                h4("Plan:"),
                hr(),
                
                # Export DAP note
                downloadButton(
                    "uti_exportDAP",
                    "Export DAP note", class = "btn-success"
                )
            ),
            
            # DR letter
            tabPanel(
                title = "Dr Letter",
                textInput("drfirst", "Dr's First Name"),
                textInput("drlast", "Dr's Last Name"),
                textInput("drfax", "Dr's Fax Number"),
                checkboxGroupInput(
                    "drelements",
                    "What to include in the Dr's letter?",
                    c(
                        "Patient Assessment",
                        "Goals of therapy",
                        "Pharmacologic therapy",
                        "Non-pharmacologic therapy",
                        "Monitoring & Follow up plan"
                    )
                ),
                downloadButton("uti_dr", label = "Generate letter", class = 'btn-success')
            )
        )
    )
)

uti_server <- function(input, output) {
    # allergies selection
    updateSelectizeInput(
        inputId = "uti_allergies",
        choices = drugs,
        server = TRUE
    )
    
    # prior treatment to uti medication selection
    updateSelectizeInput(
        inputId = "uti_prior",
        choices = drugs,
        server = TRUE,
        selected = "PMS-NITROFURANTOIN BID"
    )
    
    # Rx
    rx_server(input, output)
    
    # Dap Data
    ## Medical hx
    output$uti_pbf <- renderText({
        if (input$uti_pbf == "No") {
            paste0("- Patient is not pregnant or breastfeeding.")
        } else {if (input$uti_pbf != "N/A") {
            paste0("- Patient is ", input$uti_pbf)
        }}
    })
    output$uti_ckd <- renderText({
        paste0("- Chronic Kidney Disease: ", input$uti_ckd)
    })
    output$uti_crcl <- renderText({
        paste0("- CrCl: ", input$uti_crcl)
    })
    output$uti_prevEpisodes <- renderText({
        paste0("- Previous epsiodes of diagnosed UTI: ", input$uti_prevEpisodes)
    })
    output$uti_recentEpisode <- renderText({
        paste0("- Recent episode within 14 days: ", input$uti_recentEpisode)
    })
    output$uti_immunocomp <- renderText({
        paste0("- Immunocompromising conditions including uncontrolled diabetes: ", input$uti_immunocomp)
    })
    output$uti_abnormalStructure <- renderText({
        paste0("- Abnormal UTI function or structure (indewiling catheter, neurogenic bladder, renal stones, etc.): ", input$uti_abnormalStructure)
    })
    output$uti_maleOrChild <- renderText({
        paste0("- Male or child < 16 years old: ", input$uti_maleOrChild)
    })
    output$uti_addhx <- renderText({
        if (input$uti_addhx != "") {
            paste0("- Additional notes: ", input$uti_addhx)
        }
    })
    
    ## Medication hx
    output$uti_immunosupressors <- renderText({
        if (input$uti_immunosuppressors == "Yes") {
            paste0("- The patient is on immunosupressant medication--REFER")
        } else {
            paste0("- Patient is NOT on immunosuppresant medication.")
        }
    })
    output$uti_cysititisMed <- renderText({
        if (input$uti_cysititisMed == "Yes") {
            paste0("- Patient is on cystitis-inducing medication--REFER")
        } else {
            paste0("- Patient is NOT on cystititis-induding medication.")
        }
    })
    
    ## Clinical presentation
    
    ## Red Flags
    
    # DAP Assessment
    
    # DAP plan
    
    # Dr letter
    
}