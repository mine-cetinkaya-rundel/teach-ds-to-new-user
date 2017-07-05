library(dplyr)
library(ggplot2)
library(stringr)
library(GGally)
library(ggmap)

# Load data ---------------------------------------------------------
crash <- read.csv("data/ncdot-fatal-crashes.csv", sep = ";")

x <- str_split(crash$geo_point_2d, ",")
lat <- rep(NA, 1000)
lon <- rep(NA, 1000)
for(i in 1:1000){
  lat[i] <- as.numeric(x[[i]][1])
  lon[i] <- as.numeric(x[[i]][2])
}

crash <- cbind(crash, lat, lon)

myLocation <- "Greensboro, North Carolina"
maptype1 = c("watercolor", "toner", "watercolor")
maptype2 = c("roadmap", "terrain", "satellite", "hybrid")
myMap <- get_map(location = myLocation,
                 source = "google", maptype = "roadmap", zoom = 7, crop = FALSE)

# Begin ui definition -----------------------------------------------
ui <- fluidPage(
  
  # App title -------------------------------------------------------
  titlePanel("Modeling the Distributions of Fatal Car Crashes"),
  
  # Sidebar ---------------------------------------------------------
  sidebarLayout(
    sidebarPanel(
      # Select the categorical variable for the map
      selectInput("Var3",
                  "Select categorical variable",
                  choices = c("crash type" = "CRASH_TYPE", 
                              "alcohol involved" = "ALCOHOL_FL", 
                              "teen driver" = "TEEN_DRIVE", 
                              "older driver" = "OLDER_DRIV", 
                              "direction" = "DIR")
      )
    ),
    
    # Main panel ----------------------------------------------------
    mainPanel(
      
      # Plot population distribution
      plotOutput("crashPlot")
    )
  )
)

server <- function(input, output, session){
  output$crashPlot <- renderPlot({
    ggmap(myMap) +
      geom_point(data = crash, aes_string(x = "lon", y = "lat", color = input$Var3), 
                 alpha = .5, size = 2)
  })
}

shinyApp(ui, server)
