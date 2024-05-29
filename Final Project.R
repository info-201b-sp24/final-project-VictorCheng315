# Load necessary libraries
library(shiny)
library(shinydashboard)
library(tidyverse)

# Load the dataset
dogs <- read.csv('./allDogDescriptions.csv')

# Clean the dataset
dogs <- dogs %>%
  mutate(Age = factor(age, levels = c("Baby", "Young", "Adult", "Senior")))

# Ensure 'size' is a factor
dogs$size <- as.factor(dogs$size)

# Rename columns for consistency
dogs <- dogs %>%
  rename(Breed = breed_primary, State = contact_state, Adoptable = status)

# Filter out rows where State is not a valid state abbreviation (e.g., zip codes)
state_abbreviations <- state.abb
dogs <- dogs %>% filter(State %in% state_abbreviations)

# Custom CSS for better styling
custom_css <- "
  body, .content-wrapper, .right-side {
    background-color: #f8f9fa;
  }
  .main-header .logo {
    font-size: 18px;
    white-space: normal;
    text-align: center;
    background-color: #343a40;
    color: #ffffff;
  }
  .main-header .navbar {
    background-color: #343a40;
    color: #ffffff;
  }
  .sidebar-menu > li > a {
    font-size: 16px;
    padding: 10px 5px;
  }
  .sidebar-menu .treeview-menu > li > a {
    font-size: 14px;
    padding: 5px 10px;
  }
  .box {
    background-color: #ffffff;
    border: 1px solid #dddddd;
    border-radius: 5px;
    padding: 20px;
    margin: 20px 0;
  }
  .content-header h2 {
    margin: 20px 0;
  }
  .content p, .content img {
    margin: 10px 0;
  }
  .btn {
    margin: 5px;
    background-color: #007bff;
    color: #ffffff;
  }
  .btn:hover {
    background-color: #0056b3;
  }
  .selectize-input {
    padding: 5px;
    font-size: 14px;
  }
  .plot-output {
    margin: 20px 0;
  }
"

# UI
ui <- dashboardPage(
  dashboardHeader(title = span("Analysis of Animal Shelter", style = "font-size: 16px;")),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction", tabName = "intro", icon = icon("info-circle")),
      menuItem("Common Breeds", tabName = "breeds", icon = icon("dog")),
      menuItem("Adoptability Analysis", tabName = "adoptability", icon = icon("heart")),
      menuItem("State Analysis", tabName = "state", icon = icon("map")),
      menuItem("Conclusion", tabName = "conclusion", icon = icon("check"))
    )
  ),
  dashboardBody(
    tags$head(tags$style(HTML(custom_css))),
    tabItems(
      tabItem(tabName = "intro",
              h2("Introduction"),
              div(class = "box",
                  h3("Introduction of our project"),
                  p("In our daily lives, we still see stray pets on the streets, which sparked our interest in the current situation of animals in pet shelters. After searching the Internet, we found that until today, animal adoption is still a big topic that needs attention. We believe that our project can provide some help to improve the current situation of stray animals and shelter animals. The purpose of this project is to better understand the adoption of dogs and other animals in the United States. We are curious about how the characteristics of shelter animals affect their chances of being adopted, and how these characteristics varied by location. By analyzing the data of adoptable dogs, we can gain insight into the characteristics of these dogs and how they affect their chances of being adopted. We hope that the results of this project can help shelters and rescue agencies so that they can optimize their efforts to find homes for these dogs."
                    ),
                  img(src = "https://www.oipa.org/international/wp-content/uploads/2021/05/82170867_2507581532817048_1575957757285105664_o.jpg", height = "300px"),
                  p("Source: [https://www.oipa.org/international/save-a-stray-project/]"),
                  h3("Research Questions"),
                  p("1. What are the most common breeds among adoptable dogs?"),
                  p("2. Is there a correlation between age or size and whether being considered adoptable?"
                    ),
                  p("3. How do the characteristics of dogs vary across different states?"
                    ),
                  h3("Data Source"),
                  p("Data is collected by Amber Thomas. All data except for description was collected using PetFinder’s V2 API method get-animals as described in their documentation. Since the V2 API doesn’t return the full animal description, the creator of this dataset was encouraged by the API maintainers to query the same animal profiles using the V1 API to acquire that information. Thus, the creator used all of the shelter ID’s returned from the V2 API calls to find all descriptions of dogs in each shelter and combine the two results by the animal’s unique ID. The original source of the data we used can be found here: [https://github.com/the-pudding/data/tree/master/dog-shelters]"
                    ),
                  p("One big reason that this dataset is appropriate for our research is that it contains a large number of observations and many variables, which makes it more feasible for us to conduct research in various directions."
                    ),
                  h3("Possible Limitations"
                     ),
                  p("The dataset only represents some information about adoptable dogs in the US on a single day, which means that the data might not accurately represent the overall trend of adoptable dogs in the US. Seasonal variations, special events, or other temporal factors that might influence the number and characteristics of adoptable dogs are not captured in this dataset."
                    ),
                  p("Another potential limitation is the bias caused by the self-reported data. Because the information about the dogs is reported by the shelters or rescues that posted the dogs for adoption on PetFinder. The accuracy and completeness of this information depend on the individual shelters or rescues, which might vary widely. Some shelters or rescues might provide detailed and accurate information about the dogs, while others might provide minimal or inaccurate information. This could introduce biases in the data and affect the reliability of the analysis.Another potential limitation is the bias caused by the self-reported data. Because the information about the dogs is reported by the shelters or rescues that posted the dogs for adoption on PetFinder. The accuracy and completeness of this information depend on the individual shelters or rescues, which might vary widely. Some shelters or rescues might provide detailed and accurate information about the dogs, while others might provide minimal or inaccurate information. This could introduce biases in the data and affect the reliability of the analysis."
                    ),
                  p("Moreover, the dataset is limited to dogs listed on PetFinder. Although PetFinder is a popular platform, we all know that not all shelters or rescues might be using this platform. Therefore, there might be regional variations in the use of PetFinder, with some areas having a high proportion of their adoptable dogs listed on the platform, while others might use different platforms or methods for listing their adoptable dogs. This could limit the comprehensiveness of the data and introduce geographical biases in the analysis."
                  ))),
      tabItem(tabName = "breeds",
              h2("Most Common Adoptable Breeds"),
              div(class = "box",
                  p("This chart is titled“Distribution of ‘Breed name’ by Age and Size.” It’s designed to analyze the distribution of each breed of dogs by age and size in an animal shelter setting, and we could see the number of the dogs through the number y axis.
                  It discuss the prevalence of different breeds in animal shelters. The number of dogs in shelter shows the number of abandoned dog breeds. This number is also related to the number of dogs of each breed in the United States. According to Humanesocietytampa.org, pit bulls were the number one breed in the United States in 2023, with an estimated 18 million in the country. Vetstreet.com also says that the American Pit Bull Terrier is one of the top three favorite breeds in 28 states. This can be seen in the fact that pit bull terrier is the highest amount adoptable dog breed. Although there are other influencing factors, this factor is also very important.
                  The chart shows four age categories: Baby, Young, Adult, and Senior, and how the sizes (Small, Medium, Large, Extra Large) are distributed within these age groups. The most common category in this dataset is Adult, with a significant number being Large and Medium size."
                    ),
                  selectInput("breed_select", "Select Breed:", choices = unique(dogs$Breed[dogs$Adoptable == "adoptable"])),
                  plotOutput("breed_plot"),
                  h3("Conclusion"),
                  p("In conclusion, the chart analyzing the distribution of dog breeds by age and size in animal shelters provides a significant reflection of the prevalence of these breeds in the United States. The high number of pit bulls in shelters corresponds with their status as the most common breed in the country in 2023. The data also reveals that Adult dogs, particularly of Large and Medium sizes, are the most common demographic in shelters. These insights are crucial for understanding trends in dog ownership and abandonment, and can guide future strategies and policies in animal welfare."
                    )
              )),
      tabItem(tabName = "adoptability",
              h2("Adoptability Analysis"),
              div(class = "box",
                  p("A major challenge faced by pet shelters is how to successfully find all the shelter animals to suitable homes. Although these animals all need a warm home, not all animals have an equal chance of being adopted. In many cases, a pet's age and size have a significant impact on its likelihood of being considered 'adoptable.' Studies have shown that younger, smaller pets are generally more likely to be adopted, while older or larger pets face more difficulties. This trend not only reflects the preferences of potential adopters, but also reveals some deeper questions about pet welfare and shelter management.
                  In addition to age and size factors, shelters also have to deal with public biases about certain pet breeds and behaviors. These biases can be based on misconceptions about the pet's personality, health issues, and the difficulty of keeping it. Through education and advocacy, shelters can help change these biases and increase acceptance of older and larger pets. This includes holding introductions, sharing successful adoption stories and giving practical advice on keeping older or larger pets.
                  Some shelters have also taken innovative steps to increase adoption rates for older and larger pets. For example, a 'trial adoption' program is offered, allowing adopters to experience living together for a period of time before a formal decision is made. Such programs can reduce adopters' concerns and make them more confident in adopting older or larger pets. In addition, shelters can partner with local veterinarians and pet food companies to provide medical and nutritional support to families adopting older or larger pets, thereby reducing their burden."
                  ),
                  fluidRow(
                    column(6, actionButton("age_button", "Show Adoptability by Age")),
                    column(6, actionButton("size_button", "Show Adoptability by Size"))
                  ),
                  plotOutput("adoptability_plot"),
                  h3("Conclusion"),
                  p("First, younger pets are generally more likely to be adopted than older pets. Young animals, especially calves, are popular for their cute, lively appearance and long life expectancy. Many potential adopters prefer to invest time and affection in a young pet, hoping to keep them company for many years. Older pets, however, face more adoption difficulties. They may be perceived as needing more medical attention or having more problems with behavior and health, causing some adopters to shy away. For example, elderly pets may have chronic illnesses that require regular veterinary visits and special diets, which can be a burden for some adopters. This preference for younger pets makes older animals stay longer in shelters and may even be at risk of euthanasia.
                  Secondly, the size of a pet is also an important factor affecting its chances of adoption. Small dogs and cats are generally easier to adopt, mainly because they are suitable for indoor living and relatively easier to manage and care for. Small pets generally require less space to move around and less food, which makes them more attractive to city dwellers and small families. In contrast, large dogs are often overlooked by potential adopters because they require more room to move around, food and training. For example, some large dogs require a lot of daily exercise and a wide space to move around, which may not be realistic for families living in urban apartments. In addition, society's negative stereotypes of certain large dog breeds, such as bulldogs and Rottweilers, further reduce the chances of these animals being adopted. These dog breeds are often mistaken for being aggressive, although many of them are actually very docile and friendly.
                  ")
              )),
      tabItem(tabName = "state",
              h2("Characteristics by State"),
              div(class = "box",
                  p("Here is an interactive 'State Analysis Plot' where users can explore the distribution of dog breeds within different states across the United States. By selecting a specific state, users can visualize the count of Small, Medium, Large, and Extra Large dogs for each breed in the shelter within that state. This dynamic analysis provides valuable insights into regional preferences and challenges faced by animal shelters, allowing users to understand how breed distribution varies across states and how size preferences may influence adoption rates."
                    ),
                  selectInput("state_select", "Select State:", choices = unique(dogs$State)),
                  plotOutput("state_plot"),
                  h3("Conclusion"),
                  p("The 'State Analysis Plot' empowers users to delve into the nuances of breed distribution and size preferences within shelters across different states. By exploring the count of dogs by breed and size category, users gain valuable insights into regional trends and dynamics that impact adoption outcomes. This interactive tool facilitates informed decision-making for shelters and animal welfare organizations, enabling them to tailor their strategies and resources to address the unique needs of each state's shelter population. Through such targeted efforts, we can work towards improving adoption rates and promoting the well-being of shelter animals nationwide."
                  )
              )),
      tabItem(tabName = "conclusion",
              h2("Conclusion"),
              div(class = "box",
                  p("Taken together, our analysis of adoptable dogs in the United States provides valuable insights into the factors that influence their adoptability and the different characteristics that vary across states. The project aims to uncover the adoption process by answering three key research questions: identifying the most common breeds of adoptable dogs, exploring correlations between age or size and adoptability, and examining differences in canine characteristics across states. Here are the specific findings from our analysis:"
                    ),
                  h3("Most Common Breeds Among Adoptable Dogs:"),
                  p("Our analysis shows that certain breeds are more commonly available for adoption in shelters. For example, Pit Bulls and Labrador Retrievers are the most common among all the breeds. This pattern can clearly be seen in the breed distribution map, where the numbers of these breeds are always higher than other breeds. This information is very important to shelter because it can help them to better understand which breeds are more likely to be abandoned or given up. Based on the information, they can tailor adoption events and resources to better meet the specific needs of these breeds."
                    ),
                  h3("Correlation Between Age or Size and Adoptability:"),
                  p("One key finding was a significant correlation between a dog’s age and its adoptability. Our data showed that younger dogs, especially puppies and young adults, were more likely to be adopted than older dogs. This trend is visualized in the adoptability by age chart, where younger dogs had significantly higher adoption rates. Additionally, the size of a dog also had an impact on its adoptability. As shown in our size vs. adoptability analysis, small to medium dogs were adopted more often than large dogs. These insights can help shelters set priorities and develop strategies to promote adoptions of older and larger dogs, who may require more attention before they can find homes."
                     ),
                  h3("Characteristics of Dogs Across Different States:"),
                  p("Our state-level analysis found that the characteristics of adoptable dogs vary widely from state to state. For example, the popularity of certain dog breeds and the average size of dogs vary from state to state. In states like Mississippi, there is a higher percentage of large dogs or medium-sized breeds (such as Labrador Retrievers), while in states like California, small breeds are more common. Knowing this geographic variation is important for understanding regional preferences and challenges in dog adoption. Potentially, shelters can use this information to develop location-specific adoption strategies with other local organizations in order to meet the unique needs of their communities."
                    ),
                  h3("Important Insight"),
                  p("One of the most important insights from our analysis is the clear preference for younger and smaller dogs when it comes to adoption. This preference has significant implications for how shelters and rescue organizations approach their adoption efforts. By recognizing that senior and larger dogs are less likely to be adopted, shelters can implement targeted campaigns to highlight the benefits of adopting these less preferred groups. For example, they can offer incentives such as reduced adoption fees, provide more information about the temperament and care needs of older dogs, or create special events that focus on adopting larger breeds."
                    ),
                  h3("Broader Implications"),
                  p("The broad implications of this insight are not limited to individual shelters, but also to overall strategies to improve animal welfare and adoption rates. By understanding the factors that impact adoptability, policymakers and animal welfare advocates can develop more effective programs and policies to support shelters. This may include funding special adoption programs, developing educational campaigns to change public perceptions of senior and large dogs, and working with businesses and communities to promote adoptions. Ultimately, these efforts can increase adoption rates, reduce shelter overcrowding, and result in better outcomes for dogs who need families."
                    )
              ))
    )
  )
)

# Server
server <- function(input, output) {

  # Reactive value to keep track of which plot to display
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

  # Common Breeds Plot
  output$breed_plot <- renderPlot({
    breed_data <- dogs %>% filter(Breed == input$breed_select, Adoptable == "adoptable")
    ggplot(breed_data, aes(x = Age, fill = size)) +
      geom_bar() +
      labs(title = paste("Distribution of", input$breed_select, "by Age and Size"))
  })

  # State Analysis Plot
  output$state_plot <- renderPlot({
    state_data <- dogs %>% filter(State == input$state_select)
    ggplot(state_data, aes(x = Breed, fill = size)) +
      geom_bar(position = "dodge") +
      labs(title = paste("Distribution of Breeds in", input$state_select)) +
      theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  })
}

# Run the app
shinyApp(ui = ui, server = server)

