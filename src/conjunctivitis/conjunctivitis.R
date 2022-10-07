
# load libraries and source files -----------------------------------------

library(lubridate)
load("./drugs.Rds")
source("./Rx/Rx.R")
source("./patient.R")

conj_ui <- fluidPage(
    
    # header ------------------------------------------------------------------
    h2("Conjunctivitis"),

    # Patient Information -----------------------------------------------------
    fluidRow(patient),
#     
#     # Patient assessment -------------------------------------------------------
#     fluidRow(
#         tabBox(
#             width = 12,
#             title = "Patient Assessment",
#             id = "uti_patientAssessment",
#             ## medical history
#             tabPanel(
#                 "Medical History",
#                 radioButtons(
#                     "uti_pbf",
#                     "Pregnant or Breastfeeding",
#                     c("Pregnant", "Breastfeeding", "No", "N/A")
#                 ),
#                 conditionalPanel(
#                     condition = "input.uti_pbf == 'Pregnant'",
#                     sliderInput(
#                         "uti_pregWks",
#                         "Weeks: ",
#                         min = 1, max = 42, value = 12
#                     )
#                 ),
#                 radioButtons(
#                     "uti_ckd",
#                     "Does the patient have CKD?",
#                     c("No", "Yes")
#                 ),
#                 conditionalPanel(
#                     condition = "input.uti_ckd == 'Yes'",
#                     sliderInput(
#                         "uti_crcl",
#                         "CrCl/eGFR",
#                         min = 0,
#                         max = 180,
#                         value = 120
#                     )
#                 ),
#                 radioButtons(
#                     "uti_prevEpisodes",
#                     "Previous episodes of UTI diagnosed?",
#                     c("No", "Yes")
#                 ),
#                 radioButtons(
#                     width = '800px',
#                     "uti_recentEpisode",
#                     "Previoius episode of UTI within the past 4 weeks: ",
#                     c("No", "Yes")
#                 ),
#                 radioButtons(
#                     width = '800px',
#                     "uti_recurrent",
#                     "Two or more episodes of UTI within last 6 months or three or more episodes within last 12 months?",
#                     c("No", "Yes")
#                 ),
#                 radioButtons(width = '800px',
#                              "uti_immunocomp",
#                              "Does the patient have immunocomprimising condition including uncontrolled diabetes?",
#                              c("No", "Yes")
#                 ),
#                 radioButtons(width = '800px',
#                              "uti_abnormalStructure",
#                              "Does the patient have abnormal urinary tract function or structure? (indwelling catheter, neurogenic bladder, renal stones, renal dysfunction, etc.)",
#                              c("No", "Yes")
#                 ),
#                 radioButtons(
#                     "uti_maleOrChild",
#                     "Is the patient male or < 16 years of age?",
#                     c("No", "Yes")
#                 ),
#                 textAreaInput(width = '800px',
#                               "uti_addhx",
#                               "Additional Notes: "
#                 ),
#             ),
#             
#             ## medication history
#             tabPanel(
#                 "Medication History",
#                 radioButtons(width = '800px',
#                              "uti_immunosuppressors",
#                              "Does the patient take a medication which supresses the immune system?",
#                              c("Yes", "No"), selected = "No"
#                 ),
#                 radioButtons(width = '800px',
#                              "uti_cysititisMed",
#                              "Does the patient take a medication which can cause cyctitis? (cyclophosphamide, allopurinol, tiaprofenic acid)",
#                              c("Yes", "No"), selected = "No"
#                 ),
#                 selectizeInput(
#                     inputId = "uti_allergies",
#                     label = "Allergies:",
#                     choices = NULL,
#                     multiple = TRUE
#                 ),
#                 radioButtons("uti_prior", "Prior treatment for UTI", c("Yes", "No", "other")),
#                 conditionalPanel(
#                     condition = "input.uti_prior == 'Yes'",
#                     selectizeInput("uti_priorMed","Medication", choices = NULL),
#                     textInput("uti_effect", "Effect", placeholder = "Effective/Not effective"),
#                     textInput("uti_tolerance", "Tolerance", placeholder = "Tolerable/Not tolerable")
#                 ),
#                 conditionalPanel(
#                     condition = "input.uti_prior == 'other'",
#                     textAreaInput("uti_priorOther", "Upon asking patient indicated that: ")
#                 )
#             ),
#             
#             ## symptoms presentation
#             tabPanel(
#                 "Clinical Presentation",
#                 checkboxGroupInput(
#                     width = '800px',
#                     "uti_sxs",
#                     "Does the patient have two or more of the following:",
#                     c("Dysuria", "Frequency/Urgency", "Suprapubic disccomfort", "No vaginal symptoms")
#                 )
#             ),
#             
#             ## Red flags and contraindications
#             tabPanel(
#                 "Red flags",
#                 
#                 checkboxGroupInput(
#                     width = '800px',
#                     "uti_pyelo",
#                     "Are any signs of pyelonephritis present?",
#                     c("Fever", "Chills", "Nausea and vomiting", "Flank or Back pain", "Significant malaise")
#                 ),
#                 checkboxGroupInput(
#                     width = '800px',
#                     "uti_othersxs",
#                     "Are any other unusual symptoms present?",
#                     c("Vaginal discharge or itch", "Dyspareunia", "Other significant symptoms")
#                 )
#             ),
#             
#             ## Assessment
#             tabPanel(
#                 "Assessment",
#                 radioButtons(
#                     width = '800px',
#                     "uti_decision",
#                     "According to the patient's clinical presentation, I decided to:",
#                     c("Treat", "Refer"), selected = "Treat"
#                 ),
#                 conditionalPanel(
#                     condition = "input.uti_decision == 'Treat'",
#                     textAreaInput(
#                         width = '800px',
#                         "uti_rationale1",
#                         "Rationale", 
#                         placeholder = "Patient's clinical presentation comply with uncomplicated urinary tract infection symptoms. Patient does not show red flags or concerning symptoms. Patient has history of UTI treatment and eligible for pharmacist prescribing for minor ailment."
#                     )
#                 ),
#                 conditionalPanel(
#                     condition = "input.uti_decision == 'Refer'",
#                     textAreaInput(
#                         width = '800px',
#                         "uti_rationale2",
#                         "Rationale", 
#                         placeholder = "Patient is showing one or more of red flags or concerning symmptoms and has to be referred to a physician for further assessment. Patient is not eligible at the moment for UTI self treatment or pharmacist prescribing for minor ailments."
#                     )
#                 ),
#             ),
#             
#             ## Resources
#             tabPanel(
#                 "Resources",
#                 includeMarkdown("./uti/uti_resources.Rmd")
#             )
#         )
#     ),
#     
#     fluidRow(
#         
#         # GOT ---------------------------------------------------------------------
#         box(
#             width = 4,
#             title = "Goals of Therapy",
#             status = "primary", 
#             solidHeader = TRUE,
#             collapsible = TRUE,
#             checkboxGroupInput(
#                 "uti_got",
#                 "I discussed with the patient the following:",
#                 c(
#                     "Relieve symptoms in acute infection",
#                     "Prevent complications of untreated acute infection",
#                     "Prevent recurrent infection",
#                     "Prevent pyelonephritis in pregnancy"
#                 )
#             ),
#             textAreaInput(width = '800px',
#                           "uti_addgot",
#                           "Additional Notes: "
#             )
#         ),
#         
#         
#         # TTT ---------------------------------------------------------------------
#         tabBox(
#             width = 8,
#             id = "uti_ttt", 
#             title = "Treatment",
#             
#             # Non-pharm
#             tabPanel(
#                 title = "Non-Pharmacologic",
#                 checkboxGroupInput(
#                     width = '800px',
#                     "uti_nonpharm",
#                     "I discussed the following with the patient:",
#                     c(
#                         "increased water intake may decrease the risk of UTI recurrence (low quality evidence)",
#                         "The use of spermicidal products is associated with recurrent UTI in women and should be avoided in those at risk of recurrence."
#                     )
#                 ),
#                 textAreaInput(
#                     width = '800px',
#                     "uti_addnonpharm",
#                     "Additional Notes: "
#                 )
#             ),
#             
#             # Pharm
#             tabPanel(
#                 title = "Pharmacologic",
#                 h4("First Line:"),
#                 h5("Nitrofurantoin (Macrobid) 100mg PO BID x 5 days"),
#                 h4("Second Line:"),
#                 h5("Sulfamethoxazole/trimethoprim 800mg/160mg PO BID x 3 days"),
#                 h5("Trimethoprim 100mg PO BID x 3 days"),
#                 h5("Trimethoprim 200mg PO QD x 3 days"),
#                 h5("Fosfomycin 3g dissolve in 1/2 cup of cold water PO QD x 1 day"),
#                 hr(),
#                 rx_ui
#             )
#         )
#     ),
#     
#     fluidRow(
#         
#         # Follow up ---------------------------------------------------------------
#         box(
#             width = 4,
#             title = "Monitoring & Follow up Plan",
#             status = "primary",
#             solidHeader = TRUE,
#             collapsible = TRUE,
#             fluidRow(
#                 column(width = 5, numericInput("uti_fuSchedule", "Follow up in ", value = 3, min = 0, max = 99)),
#                 column(width = 3, selectInput("uti_fuUOT", "_", c("minutes", "hours", "days", "weeks", "months"), selected = "days")),
#                 column(
#                     width = 4, 
#                     selectInput(
#                         "uti_fuMeans",
#                         "By: ",
#                         c("In-peson", "By phone")
#                     )
#                 )
#             ),
#             checkboxGroupInput(
#                 "uti_fuItems",
#                 "I will follow up with the patient on the following:",
#                 c(
#                     "Assess for significant improvement in all symptoms",
#                     "Determine if side effects are occurring (esp. severe diarrhea or rash)",
#                     "If worsening or not improving, refer to MD",
#                     "If improving, encourage continued use until the end of therapy if greater than 3 days"
#                 )
#             )
#         ),
#         
#         # DAP note & Dr letter ----------------------------------------------------
#         
#         tabBox(width = 8,
#                id = "uti_doc",
#                title = "Document & Collaborate",
#                
#                # DAP note
#                tabPanel(
#                    title = "DAP note",
#                    h4("Data:"),
#                    textOutput("uti_dataHx"),
#                    textOutput("uti_dataHx2"),
#                    textOutput("uti_dataHx3"),
#                    textOutput("uti_dataSx"),
#                    textOutput("uti_dataRedFlags"),
#                    hr(),
#                    
#                    # assessment
#                    h4("Assessment:"),
#                    textOutput("uti_assessment"),
#                    hr(),
#                    
#                    # plan
#                    h4("Plan:"),
#                    textOutput("uti_plan"),
#                    hr(),
#                    
#                    # Export DAP note
#                    downloadButton(
#                        "uti_exportDAP",
#                        "Export DAP note", class = "btn-success"
#                    )
#                ),
#                
#                # DR letter
#                tabPanel(
#                    title = "Dr Letter",
#                    textInput("drfirst", "Dr's First Name"),
#                    textInput("drlast", "Dr's Last Name"),
#                    textInput("drfax", "Dr's Fax Number"),
#                    downloadButton("uti_dr", label = "Generate letter", class = 'btn-success')
#                )
#         )
#     )
)
# 
# uti_server <- function(input, output) {
#     # allergies selection
#     updateSelectizeInput(
#         inputId = "uti_allergies",
#         choices = drugs,
#         server = TRUE
#     )
#     
#     # prior treatment to uti medication selection
#     updateSelectizeInput(
#         inputId = "uti_priorMed",
#         choices = drugs,
#         server = TRUE,
#         selected = "NITROFURANTOIN"
#     )
#     
#     # Rx
#     rx_server(input, output)
#     
#     
#     # Server: DAP text output -------------------------------------------------
#     
#     # Data
#     ## Hx
#     output$uti_dataHx <- renderText({
#         # age
#         age <- trunc(as.Date(input$ptDOB) %--% Sys.Date() / years(1))
#         
#         # Preg & breastfeeding
#         if (input$uti_pbf == "No") {
#             pbf <<- "Patient is not pregnant or breastfeeding. "
#         } else {
#             if (input$uti_pbf == "Pregnant") {
#                 pbf <<- paste0("Patient is ", input$uti_pregWks, " weeks pregnant (REFER). ")
#             } else {
#                 pbf <<- "Patient is breastfeeding. "
#             }
#         }
#         
#         # CKD
#         if (input$uti_ckd == "No") {
#             ckd <<- "Patient does not have history of chronic kidney disease. "
#         } else {
#             ckd <<- paste0("Patient has history of chronic kidney disease and her current eGFR is ",
#                            input$uti_crcl, " ml/min. "
#             )
#         }
#         
#         # render text
#         hx <<- paste0(input$ptName, " is a ", age, " years old ", tolower(input$ptGender),
#                       " who presented to the pharmacy asking for a prescription for urinary tract infection. ",
#                       pbf, ckd
#         )
#         hx
#     })
#     
#     output$uti_dataHx2 <- renderText({
#         # Previous episodes
#         if (input$uti_prevEpisodes == "No") {
#             prevEpisodes <<- "This is the first time the patient experiences UTI (REFER). "
#         } else {
#             prevEpisodes <<- "Patient had one or more previoius episodes of UTI. "
#         }
#         
#         # Recent epidoses within 4 weeks
#         if (input$uti_recentEpisode == "No") {
#             recentEpisode <<- "No recent episodes within the past 4 weeks. "
#         } else {
#             recentEpisode <<- "Patient had an episode or more in the past 4 weeks (REFER). "
#         }
#         
#         # Recurrent infection
#         if (input$uti_recurrent == "No") {
#             recurrent <- "No recurrent infection (2 or more in the past 6 months, 3 or more in the past 12 months). "
#         } else {
#             recurrent <- "Patient had recurrent episodes of UTI (2 or more in the past 6 months, 3 or more in the past 12 months, REFER). "
#         } 
#         
#         # Immunocompromised
#         if (input$uti_immunocomp == "No") {
#             immunocomp <<- "No immunocompromising medical conditions. "
#         } else {
#             immunocomp <<- "Patient has an immunocompromising condition (REFFER). "
#         }
#         
#         # Structural abnormality
#         if (input$uti_abnormalStructure == "No") {
#             abSt <<- "No abnormal urinary structure or function. "
#         } else {
#             abSt <<- "Patient has abnormal urinay structure or function (REFER). "
#         }
#         
#         #render text
#         hx2 <<- paste0(prevEpisodes, recentEpisode, recurrent, immunocomp, abSt)
#         hx2
#     })
#     
#     output$uti_dataHx3 <- renderText({
#         ## Medication hx
#         if (input$uti_immunosuppressors == "No") {
#             immunoCompMed <<- "No immunocompromising medications. "
#         } else {
#             immunoCompMed <<- "Patient is currently on an immunocomopromising condition (REFER). "
#         }
#         
#         if (input$uti_cysititisMed == "No") {
#             cystitisMeds <<- "No Cystitis-inducing medications. "
#         } else {
#             cystitisMeds <<- "Patient is currently on one or more cystitis-inducing medication. "
#         }
#         
#         if (length(input$uti_allergies) > 0) {
#             allergies <<- paste0("Patient is allergic to ", paste0(tolower(input$uti_allergies), collapse = ", "), ". ")
#         } else {
#             allergies <<- "Patinet reported no known allergies. "
#         }
#         
#         if (input$uti_prior == "No") {
#             prior <<- "Patietn did not use drug therapy for UTI before. "
#         }
#         if (input$uti_prior == "other") {
#             prior <<- paste0(
#                 "Upon asking about the prior treatment of UTI, patient indicated that",
#                 input$uti_priorOther, ". "
#             )
#             
#         } else {
#             prior <<- paste0("Patient used ", tolower(input$uti_priorMed), 
#                              " for UTI before where it was ", input$uti_effect,
#                              " and ", input$uti_tolerance, ". "
#             )
#         }
#         
#         hx3 <<- paste0(immunoCompMed, cystitisMeds, allergies, prior)
#         hx3
#     })
#     
#     ## Clinical presentation
#     output$uti_dataSx <- renderText({
#         
#         if (length(input$uti_sxs) > 0) {
#             sxs <<- paste0(tolower(input$uti_sxs), collapse = ", ")
#         } else {
#             sxs <<- "no symptoms"
#         }
#         
#         #render text
#         dataSx <<- paste0("Patient presented with ", sxs, ". ")
#         dataSx
#     })
#     
#     ## Red Flags
#     output$uti_dataRedFlags <- renderText({
#         pyeloSxs <<- c("Fever", "Chills", "Nausea and vomiting", "Flank or Back pain", "Significant malaise") 
#         if (length(input$uti_pyelo) == 0) {
#             pyelo <<- paste0("Patient does not experience any pyelonephritis symptoms (",
#                              paste0(tolower(pyeloSxs), collapse = ", "), "). ")
#         } else {
#             pyelo <<- paste0("Patient presented with the following pyelonephritits symptoms: ", 
#                              paste0(tolower(input$uti_pyelo), collapse = ", "), " (REFER). "
#             )
#         }
#         
#         if (length(input$uti_othersxs) == 0){
#             othersxsAll <<- c("Vaginal discharge or itch", "Dyspareunia", "Other significant symptoms")
#             othersxs <<- paste0("Patient does not show any other red flag symtoms (",
#                                 paste0(tolower(othersxsAll), collapse = ", "), "). "
#             )
#         } else {
#             othersxs <<- paste0("Patient presented with the following red flag symptoms: ",
#                                 paste0(tolower(input$uti_othersxs), collapse = ", "), " (REFER). "
#             )
#         }
#         
#         # render text
#         dataRedFlags <<- paste0(pyelo, othersxs)
#         dataRedFlags
#     })
#     
#     # DAP Assessment
#     output$uti_assessment <- renderText({
#         if (input$uti_rationale1 == "" & input$uti_decision == "Treat") {
#             assessment <<- "Treat: Patient's clinical presentation comply with uncomplicated urinary tract infection symptoms. Patient does not show red flags or concerning symptoms. Patient has history of UTI treatment and eligible for pharmacist prescribing for minor ailment. "
#         } else {
#             if (input$uti_rationale2 == "" & input$uti_decision == "Refer") {
#                 assessment <<- "Refer: Patient is showing one or more of red flags or concerning symmptoms and has to be referred to a physician for further assessment. Patient is not eligible at the moment for UTI self treatment or pharmacist prescribing for minor ailments."
#             } else {
#                 if (input$uti_decision == "Treat") {
#                     assessment <<- paste0(input$uti_decision, ": ", input$uti_rationale1)
#                 } else {
#                     assessment <<- paste0(input$uti_decision, ": ", input$uti_rationale2)
#                 }
#             }
#         }
#         
#         # render text
#         assessment
#     })
#     
#     # DAP plan
#     output$uti_plan <- renderText({
#         ## Treatment
#         ttt <<- paste0(
#             "After discussing the possible therapeutic alternatives for UTI treatment with the patient, I prescribed ", 
#             input$medName, " ", input$n, " ", input$unit,
#             " ", input$route, " ", input$freq, " for ", 
#             input$duration, " ", input$unitDuration, ". "
#         )
#         
#         ## Follow up
#         fu <<- paste0(
#             "I will follow up with patient in ", input$uti_fuSchedule, " ",
#             input$uti_fuUOT, " ", tolower(input$uti_fuMeans), " on the folowing: ",
#             paste0(input$uti_fuItems, collapse = ", "), ". "
#         )
#         
#         # render text
#         plan <<- paste0(ttt, fu)
#     })
#     
#     # Server: generate DAP note -----------------------------------------------
#     output$uti_exportDAP <- downloadHandler(
#         filename = "uti_dap.html",
#         content = function(file) {
#             tempReport <- file.path(tempdir(), "uti_dap.Rmd")
#             file.copy("./uti/uti_dap.Rmd", tempReport, overwrite = TRUE)
#             
#             # passing input parameters
#             params <- list(
#                 pt_name = input$ptName,
#                 pt_dob = input$ptDOB,
#                 pt_phn = input$ptPHN,
#                 pt_gender = input$ptGender,
#                 pt_tel = input$ptTel,
#                 pt_address = input$ptAddress,
#                 hx = hx,
#                 hx2 = hx2,
#                 hx3 = hx3,
#                 dataSx = dataSx,
#                 dataRedFlags = dataRedFlags,
#                 assessment = assessment,
#                 plan = plan,
#                 prescriber_name = input$pharmacist
#             )
#             
#             # render
#             rmarkdown::render(tempReport, output_file = file, params = params, envir = new.env(parent = globalenv()))
#         }
#     )
#     
#     
#     # Server: generate Dr letter ----------------------------------------------
#     output$uti_dr <- downloadHandler(
#         filename = "uti_dr.html",
#         content = function(file) {
#             tempReport <- file.path(tempdir(), "uti_dr.Rmd")
#             file.copy("./uti/uti_dr.Rmd", tempReport, overwrite = TRUE)
#             
#             # passing input parameters
#             params <- list(
#                 prescriber_name = input$pharmacist,
#                 prescriber_address = address,
#                 pt_name = input$ptName,
#                 pt_dob = input$ptDOB,
#                 pt_phn = input$ptPHN,
#                 pt_gender = input$ptGender,
#                 pt_tel = input$ptTel,
#                 pt_address = input$ptAddress,
#                 med_name = input$medName,
#                 directions_n = input$n,
#                 med_dosageForm = input$unit,
#                 directions_route = input$route,
#                 directions_freq = input$freq,
#                 directions_prn = prn,
#                 directions_duration = input$duration,
#                 directions_uot = input$unitDuration,
#                 rx_qty = input$rxQty,
#                 rx_refills = input$refills,
#                 hx = hx,
#                 hx2 = hx2,
#                 hx3 = hx3,
#                 dataSx = dataSx,
#                 dataRedFlags = dataRedFlags,
#                 assessment = assessment,
#                 plan = plan,
#                 drfirst = input$drfirst,
#                 drlast = input$drlast,
#                 drfax = input$drfax
#             )
#             
#             # render
#             rmarkdown::render(tempReport, output_file = file, params = params, envir = new.env(parent = globalenv()),)
#         }
#     )
#     
# }