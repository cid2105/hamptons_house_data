library("shiny")
library("RJSONIO")

# server.R

json_file <- "all_metrics.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
df <- do.call("rbind", json_data)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should
  #     re-execute automatically when inputs change
  #  2) Its output type is a plot

  output$plotMetric <- renderPlot({
    metric <- input$metric
    towns <- input$towns
    data <- sapply(json_data[towns], function(x) x[[metric]])
    town_dfs <- c()
    #plot(data)
    for(town in towns) {
      if(!is.na(town)) {
        town_df <- data.frame(data[town])
        x <- sort(row.names(town_df)) 
        y <- town_df[x,]
        if(!any(is.na(x)) && !any(is.na(y))) {
          town_dfs.append(y)
          #par(new=T)
          #plot(as.Date(x), y, col.main="red", xlab="Date", ylab="Percent") 
          #lines(as.Date(x), y, col.main="red", xlab="Date", ylab="Percent") 
        }
      }
      
      #ggplot() + 
       # geom_line(data=Data1, aes(x=A, y=B), color='green') + 
        #geom_line(data=Data2, aes(x=C, y=D), color='red')
      
      
      #title(main=metric, xlab="Date", ylab="Percent", col.main="red", font.main=4)
      
      
      # y <- town_df[x,]
      #
    }
  
    #plot(d)
    #plot
    #x    <- faithful[, 2]  # Old Faithful Geyser data
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'skyblue', border = 'white', label=input$checkbox)
  })
})