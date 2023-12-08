library(shiny)
library(plotly)
source("CleanedDataset.R")

global_df <- read.csv("global_avg_data.csv")

#Home page of the App (Not yet finished)
home_panel <- fluidPage(
  h1("Welcome to the home page!"),
  p("We are anlayzing the chnage over time and the contrast of population and average co2")
)

#First page analyzing the Global CO2 and Population Growth (1990-2021)
page1_panel <- fluidPage(
  titlePanel("Global Average CO2 And Population through 1990"),
  p("Welcome to an analysis of the Global Population growth and Average CO2 Emission 
    through the years of 1990 to 2021! Since the world has grown so rapidly we wanted
    to examine wheter the rapid effects of climate change has been affected due to
    our rapid population growth and co2 intake."),
  p("Below we will analyze this through a scatterplot:"),
  p(""),
  h3("Examining the trend between 1990 and 2021"),
  sidebarLayout(
    sidebarPanel(
      h4("Controls"),
      sliderInput(
        inputId = "pop_slider",
        label = "Filter by Population",
        min = 5,
        max = 8,
        value = 8
      ),
    ),
    mainPanel(
      plotlyOutput(outputId = "co2_pop"),
    ),
  ),
  h4("Findings"),
  p("Looking at our graph, there seems to be a strong linear correlation 
    between the the global population and average co2 emissions through the past
    31 years. This could indicate that the rapid growth in population and the need 
    for co2 in our modern world has an almost 1:1 ratio. This could be a factor and possible
    indicator for rapid climate change.")
)

#Second Page of the App (Not yet finished)
page2_panel <- fluidPage(
  titlePanel("Average amount of oil through the years 1990 to 2021"),
  p("Write some infomration here"),
  p(""),
  h3("Analyzing the average amount of oil through the years 1990 to 2021"),
  sidebarLayout(
    sidebarPanel(
  selectInput(
    inputId = "Years",
    label = "Select a year",
    choices = global_df$Year
     ),
    ),
      mainPanel(
        tableOutput(outputId = "table"),
        plotOutput(outputId = "plot_oil")
      )
  ),
  h4("Findings"),
  p("Write some findings here")
)

#Third Page of the App (Not yet finished)
page3_panel <- fluidPage(
  h1("This is the third page"),
  p("Write some infomration here")
)

#Contains the pages 
ui <- navbarPage(
  "Global CO2 and Population",
  tabPanel("Home", home_panel),
  tabPanel("Page 1", page1_panel),
  tabPanel("Page 2", page2_panel),
  tabPanel("Page 3", page3_panel)
)

server <- function(input, output){
  output$co2_pop <- renderPlotly({
    co2_pop_filter <- filter(global_avg_data, global_pop <= input$pop_slider)
    co2_pop <- ggplot(co2_pop_filter, aes(x = global_pop, y = avg_co2)) +
      geom_point() +
      geom_smooth(method = lm, se = FALSE)
    plot(co2_pop)
  })
  
  output$table <- renderTable({
    year_df <- filter(oil_data, Year == input$Years)
    return(year_df)
  })
  
  output$plot_oil <- renderPlotly({
    oil_graph <- ggplot(global_avg_data, aes(x = Year, y = avg_oil)) +
      geom_line() 
    return(oil_graph)
    plot(oil_graph)
  })
}

shinyApp(ui = ui, server = server)