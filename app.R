library(shiny)

global_df <- read.csv("global_avg_data.csv")

home_panel <- fluidPage(
  h1("Welcome to the home page!"),
  p("Write some information here")
)

page1_panel <- fluidPage(
  h1("This is the first page"),
  p("Write some infomration here")
)

page2_panel <- fluidPage(
  h1("This is the second page"),
  p("Write some infomration here")
)

page3_panel <- fluidPage(
  h1("This is the third page"),
  p("Write some infomration here")
)

ui <- navbarPage(
  "Global CO2 and Population",
  tabPanel("Home", home_panel),
  tabPanel("Page 1", page1_panel),
  tabPanel("Page 2", page2_panel),
  tabPanel("Page 3", page3_panel)
)

server <- function(input, output){
  
}

shinyApp(ui = ui, server = server)