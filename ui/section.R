tags$section(id = "overview",
  class = "content_page",
  div(
    id = "content_header_id",
    class = "content_header",
    tags$style(type = "text/css", "#trip {height: calc(100vh) !important;}"),
  leafletOutput("trip", width="100%", height="100%")),
 absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
               draggable = TRUE, top = 10.5, left = 53 , right = "auto", bottom = "auto", opacity = 0.6,
               width = "20.5%", height = "auto", 
  h6("A Visualisation by FitzFritzData", tags$a(href="https://twitter.com/fitzfritzdata", icon("twitter")), tags$a(href="https://linkedin.com/in/pascalfrick", icon("linkedin")), tags$a(href="https://github.com/fitz-fritz", icon("github")),
                            h2("Stolpersteine K\u00F6ln"),
   
   h6(tags$br(),""),
   h6("Disclaimer:", tags$br(), "Bitte beachten Sie, dass die Datenbank keineswegs eine Aufstellung aller Opfer des Nationalsozialismus in K\u00F6ln ist!",tags$a(href="https://museenkoeln.de/ns-dokumentationszentrum/default.aspx?s=1194", "(Link zur Datenbasis)"),))
))


