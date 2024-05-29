library(shiny)
library(shinydashboard)
library(tidyverse)

dogs <- read.csv('./allDogDescriptions.csv')

dogs <- dogs %>%
  mutate(Age = factor(age, levels = c("Baby", "Young", "Adult", "Senior")))

dogs$size <- as.factor(dogs$size)

dogs <- dogs %>%
  rename(Breed = breed_primary, State = contact_state, Adoptable = status)

state_abbreviations <- state.abb
dogs <- dogs %>% filter(State %in% state_abbreviations)

server <- function(input, output) {
  
  plot_type <- reactiveVal("age")
  
  observeEvent(input$age_button, {
    plot_type("age")
  })
  
  observeEvent(input$size_button, {
    plot_type("size")
  })
  
  output$adoptability_plot <- renderPlot({
    adoptability_data <- dogs %>% filter(Adoptable %in% c("adoptable", "adopted"))
    
    if (plot_type() == "age") {
      ggplot(adoptability_data, aes(x = Age, fill = Adoptable)) +
        geom_bar(position = "dodge") +
        labs(title = "Adoptability by Age")
    } else {
      ggplot(adoptability_data, aes(x = size, fill = Adoptable)) +
        geom_bar(position = "dodge") +
        labs(title = "Adoptability by Size")
    }
  })
  
  output$breed_plot <- renderPlot({
    breed_data <- dogs %>% filter(Breed == input$breed_select, Adoptable == "adoptable")
    ggplot(breed_data, aes(x = Age, fill = size)) +
      geom_bar() +
      labs(title = paste("Distribution of", input$breed_select, "by Age and Size"))
  })
  
  output$state_plot <- renderPlot({
    state_data <- dogs %>% filter(State == input$state_select)
    ggplot(state_data, aes(x = Breed, fill = size)) +
      geom_bar(position = "dodge") +
      labs(title = paste("Distribution of Breeds in", input$state_select)) +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  })
}
