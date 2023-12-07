library(shiny)

global_df <- read.csv("global_avg_data.csv")

ui <- fluidPage()

server <- function(input, output){
  
}

shinyApp(ui = ui, server = server)