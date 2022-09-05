overview_ui <- fluidRow(
    # the app
    box(
        width = 10, 
        title = "About the App",
        #collapsible = TRUE,
        #collapsed = TRUE,
        #solidHeader = TRUE,
        #status = "warning",
        includeMarkdown("./overview.Rmd")
    ),
    
    # author
    # box(
    #     title = "About the Author",
    #     collapsible = TRUE,
    #     collapsed = TRUE,
    #     solidHeader = TRUE,
    #     status = "success"
    # )
)
