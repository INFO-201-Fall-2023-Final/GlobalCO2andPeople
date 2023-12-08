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
  p("This is an analysis of the Global Population growth and Average CO2 Emission 
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
  titlePanel("Average Amount of Oil Through the Years 1990-2021"),
  p("Since the world has run on oil for the past decades and large amounts of 
    people are realizing the harms of the oil-related industries, we wanted to investigate
    the amounts of oil we have used. In this analysis we will take a look at the
    average amount of oil we have used since the year 1990 and see wheter this highly
    controversial substance has been an effect in climate change. We will also take
    a look at co2 emission alongside oil."),
  p(""),
  h3("Examining the Average Oil Through the Years:"),
  p(""),
  sidebarLayout(
    sidebarPanel(
  selectInput(
    inputId = "Years",
    label = "Select a year",
    choices = global_df$Year
     ),
    ),
      mainPanel(
        h5("CO2 Table"),
        tableOutput(outputId = "table"),
        plotlyOutput(outputId = "plot_oil"),
#        plotlyOutput(outputId = "bar_oil")
        p("Now lets take a look at our CO2 emissions each year and see if it follows
          along the oil's upwards trend!"),
        plotlyOutput(outputId = "co2_oil")
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
  
#First page bubble plot
  output$co2_pop <- renderPlotly({
    co2_pop_filter <- filter(global_avg_data, global_pop <= input$pop_slider)
    co2_pop <- ggplot(co2_pop_filter, aes(x = global_pop, y = avg_co2)) +
      geom_point(size = co2_pop_filter$avg_co2 * .01, aes(col = -avg_co2, alpha = .7)) +
      geom_smooth(method = lm, se = FALSE) +
      labs(
        color = "avg_co2"
      )
    plot(co2_pop)
  })

#Second page table
  output$table <- renderTable({
    year_df <- filter(oil_data, Year == input$Years)
    return(year_df)
  })

#Second page scatterplot 
  output$plot_oil <- renderPlotly({
    oil <- ggplot(global_df, aes(x = Year, y = avg_oil)) +
      geom_line() +
      geom_point(aes(col = avg_oil)) +
      scale_color_gradient(low = "yellow", high = "red") 
    plot(oil)
  })
  
#Second page scatterplot (co2 vs oil)
  output$co2_oil <- renderPlotly({
    co2_oil_plot <- ggplot(global_df, aes(x = avg_oil, y = avg_co2)) +
      geom_point(aes(col = avg_co2)) +
      scale_color_gradient(low = "yellow", high = "red") + geom_line()
    plot(co2_oil_plot)
  })

#Second page barchart (Specify year)  
#  output$bar_oil <- renderPlotly({
#    year_df <- filter(oil_data, Year == input$Years)
#    oil_barchart <- ggplot(year_df, aes(x = Year, y = avg_oil)) +
#      geom_col(width = 0.2)
#    plot(oil_barchart)
#  })
  
  
}

shinyApp(ui = ui, server = server)