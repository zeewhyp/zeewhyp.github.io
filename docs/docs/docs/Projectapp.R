# Load necessary libraries
library(shiny)
library(plotly)

# Define the user data
user_data <- data.frame(
  Year = c(2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028),
  Users = c(4.43, 4.75, 4.89, 5.14, 5.33, 5.51, 5.67, 5.81, 5.95, 6.06, 6.11, 6.15)
)

# Define the social platform data
platform_data <- data.frame(
  Platform = c("Twitter", "YouTube", "LinkedIn", "Facebook", "Instagram", "TikTok", "Facebook Messenger", "Snapchat"),
  Audience = c(5.50, 5.08, 3.70, 3.30, 2.70, 2.39, 1.95, 1.45)
)

# Define UI
ui <- fluidPage(
  titlePanel("Interactive Plotly Graphs"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      plotlyOutput("userPlot"),
      plotlyOutput("platformPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Create the interactive user data Plotly graph
  output$userPlot <- renderPlotly({
    plot_ly(user_data, x = ~Year, y = ~Users, type = "scatter", mode = "lines+markers") %>%
      layout(title = "Number of Users Over Time",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Number of Users (in millions)"))
  })
  
  # Create the interactive social platform data Plotly graph
  output$platformPlot <- renderPlotly({
    plot_ly(platform_data, x = ~Platform, y = ~Audience, type = "bar", marker = list(color = "skyblue")) %>%
      layout(title = "Advertising Audience on Social Platforms",
             xaxis = list(title = "Social Platform"),
             yaxis = list(title = "Advertising Audience (in millions)"))
  })
}

# Run the application
shinyApp(ui, server)