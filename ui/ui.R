fillPage(
    title = "Stolpersteine Köln",

    
    tags$head(
        tags$style(
          css
        ),
        tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0", charset = "utf-8"),
        tags$meta(name="author", content="FitzFritzData")
    ),
    useShinyjs(),
    div(
        id = "fullpage",
       source(file.path("ui", "section.R"), local = TRUE)$value,
    ),

    tags$script(
        src = "fullpage.js"
    )
    )

