library(RJSONIO)
library(shiny)
library(shinyjs)
library(sass)
library(plyr)
library(leaflet)
library(stringr)
library(bitops)
library(osrm)
library(tidygeocoder)
library(tibble)
library(data.table)


# extracting data from the website
Raw <- fromJSON(
  "https://geoportal.stadt-koeln.de/arcgis/rest/services/Politik_und_Verwaltung/Stolpersteine/MapServer/2/query?where=id+is+not+null&text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=4326&havingClause=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&historicMoment=&returnDistinctValues=false&resultOffset=&resultRecordCount=&returnExtentOnly=false&datumTransformation=&parameterValues=&rangeValues=&quantizationParameters=&featureEncoding=esriDefault&f=geojson")

Raw <- fromJSON("https://geoportal.stadt-koeln.de/arcgis/rest/services/Politik_und_Verwaltung/Stolpersteine/MapServer/2/query?where=id+is+not+null&text=&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&distance=&units=esriSRUnit_Foot&relationParam=&outFields=*&returnGeometry=true&returnTrueCurves=false&maxAllowableOffset=&geometryPrecision=&outSR=4326&havingClause=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&historicMoment=&returnDistinctValues=false&resultOffset=&resultRecordCount=&returnExtentOnly=false&datumTransformation=&parameterValues=&rangeValues=&quantizationParameters=&featureEncoding=esriDefault&f=geojson", encoding = "UTF-8")


z = Raw[[2]]

z1 <- lapply(z, function(x) data.frame(t(unlist(x)),stringsAsFactors = FALSE))
data_stolpersteine <- rbindlist(z1,fill=TRUE) #we use rbindlist instead of do.call(rbind,) because of column mismatch

colnames(data_stolpersteine) <- c('type','id','Koordinatenart','Longitude','Latitude','id2', 'Strasse','Stadtteil','Name','URL')
data_stolpersteine$Latitude <- as.numeric(data_stolpersteine$Latitude)
data_stolpersteine$Longitude <- as.numeric(data_stolpersteine$Longitude)
data_stolpersteine <- data_stolpersteine[-c(996),]

css <- sass(sass_file("www/styles.scss"), cache =FALSE)

ui <- source(file.path("ui", "ui.R"), local = TRUE)$value

server <- function(input, output, session) {
  renderUI({HTML()})
  
  output$trip <- renderLeaflet({
      
    leaflet() %>% 
      addProviderTiles(providers$Stamen.Toner, group = "OSM") %>% 
      setView(lng = 8.900972, lat = 50.123611, zoom = 5.3)  %>% 
      addGraticule(interval = 2) %>% 
      addCircleMarkers(
        lat = data_stolpersteine$Latitude,
        lng = data_stolpersteine$Longitude,
        popup = paste(data_stolpersteine$Name,"<br>", data_stolpersteine$Strasse,"<br>", data_stolpersteine$Stadtteil,"<br>",data_stolpersteine$URL),
        color = "darkgrey",
        stroke = FALSE,
        fillOpacity = 0.9,
        clusterOptions = markerClusterOptions())
    }
)}

shinyApp(
  ui = ui,
  server = server
)
