library(shiny)

global_df <- read.csv("global_avg_data.csv")

ui <- navbarPage("Global CO2 and Population",
  tabPanel("Home"),
  tabPanel("Page 1"),
  tabPanel("Page 2"),
  tabPanel("Page 3")
)

server <- function(input, output){
  
}

shinyApp(ui = ui, server = server)