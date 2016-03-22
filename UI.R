# ui.R
library(rjson)
json_file <- "house_data.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
df <- do.call("rbind", json_data)

shinyUI(fluidPage(
  titlePanel("Hamptons Hunt"),
  sidebarLayout(
    sidebarPanel(
      helpText("Check off the towns of interest and select a metric"),
      checkboxGroupInput("towns", 
                         label = h4("Choose One or More Towns"), 
                         choices = sort(rownames(df)),
                         selected = sort(rownames(df))[8]),
      selectInput("metric", 
                  label = "Choose a metric to compare",
                  choices = sort(colnames(df)),
                  selected = "Percent White")
      ),
    mainPanel(
      plotOutput("plotMetric")
    )
  )
))
