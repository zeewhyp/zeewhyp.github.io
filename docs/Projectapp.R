# Define UI
ui <- fluidPage(
  titlePanel("Number of Users Over Time"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearRange", "Select Year Range:",
                  min = min(data_users$Year), max = max(data_users$Year),
                  value = c(min(data_users$Year), max(data_users$Year)),
                  step = 1)
    ),
    mainPanel(
      plotOutput("linePlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Create a reactive subset of the data based on the selected year range
  filteredData <- reactive({
    data_users[data_users$Year >= input$yearRange[1] & data_users$Year <= input$yearRange[2], ]
  })
  
  # Create a reactive line plot
  output$linePlot <- renderPlot({
    ggplot(filteredData(), aes(x = Year, y = Users)) +
      geom_line() +
      labs(title = "Number of Users Over Time",
           x = "Year",
           y = "Number of Users (in millions)")
  })
}

# Run the application
shinyApp(ui, server)
