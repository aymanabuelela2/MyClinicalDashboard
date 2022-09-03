library(shinyCleave)

patient <- box(
    width = 12,
    title = "Patient Information",
    includeCleave(country = "ca"),
    fluidRow(
        column(width = 3, textInput("ptName", "Patient Name", placeholder = "First Last")),
        column(width = 3, dateInput("ptDOB", "DOB", format = "yyyy-mm-dd")),
        column(width = 3, textInput("ptPHN", "PHN", placeholder = "9 digit number")),
        column(width = 3, phoneInput("ptTel", "Telephone", placeholder = "10 digit number"))
    ),
    fluidRow(
        column(width = 3, selectInput("ptGender", "Gender", c("Male", "Female"))),
        column(width = 9, textInput("ptAddress", "Address", width = '100%', placeholder = "St address, City, Province, Postal code"))
    )
)
