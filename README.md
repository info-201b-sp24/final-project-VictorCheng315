# Analysis of Animal Shelter
## INFO 201 "Foundational Skills for Data Science"

Authors: Victor Cheng, Le Luo, Cindy Xu, Rain Hou.


## Shiny App Link:

**https://bowencheng315.shinyapps.io/Final_Project_Shiny/**



# Introduction

In our daily lives, we still see stray pets on the streets, which sparked our interest in the current situation of animals in pet shelters. After searching the Internet, we found that until today, animal adoption is still a big topic that needs attention. We believe that our project can provide some help to improve the current situation of stray animals and shelter animals. The purpose of this project is to better understand the adoption of dogs and other animals in the United States. We are curious about how the characteristics of shelter animals affect their chances of being adopted, and how these characteristics varied by location. By analyzing the data of adoptable dogs, we can gain insight into the characteristics of these dogs and how they affect their chances of being adopted. We hope that the results of this project can help shelters and rescue agencies so that they can optimize their efforts to find homes for these dogs.

Research Questions
1. What are the most common breeds among adoptable dogs?

2. Is there a correlation between age or size and whether being considered adoptable?

3. How do the characteristics of dogs vary across different states?

Data Source
Data is collected by Amber Thomas. All data except for description was collected using PetFinder’s V2 API method get-animals as described in their documentation. Since the V2 API doesn’t return the full animal description, the creator of this dataset was encouraged by the API maintainers to query the same animal profiles using the V1 API to acquire that information. Thus, the creator used all of the shelter ID’s returned from the V2 API calls to find all descriptions of dogs in each shelter and combine the two results by the animal’s unique ID. The original source of the data we used can be found here: [https://github.com/the-pudding/data/tree/master/dog-shelters]

One big reason that this dataset is appropriate for our research is that it contains a large number of observations and many variables, which makes it more feasible for us to conduct research in various directions.

Possible Limitations
The dataset only represents some information about adoptable dogs in the US on a single day, which means that the data might not accurately represent the overall trend of adoptable dogs in the US. Seasonal variations, special events, or other temporal factors that might influence the number and characteristics of adoptable dogs are not captured in this dataset.

Another potential limitation is the bias caused by the self-reported data. Because the information about the dogs is reported by the shelters or rescues that posted the dogs for adoption on PetFinder. The accuracy and completeness of this information depend on the individual shelters or rescues, which might vary widely. Some shelters or rescues might provide detailed and accurate information about the dogs, while others might provide minimal or inaccurate information. This could introduce biases in the data and affect the reliability of the analysis.Another potential limitation is the bias caused by the self-reported data. Because the information about the dogs is reported by the shelters or rescues that posted the dogs for adoption on PetFinder. The accuracy and completeness of this information depend on the individual shelters or rescues, which might vary widely. Some shelters or rescues might provide detailed and accurate information about the dogs, while others might provide minimal or inaccurate information. This could introduce biases in the data and affect the reliability of the analysis.

Moreover, the dataset is limited to dogs listed on PetFinder. Although PetFinder is a popular platform, we all know that not all shelters or rescues might be using this platform. Therefore, there might be regional variations in the use of PetFinder, with some areas having a high proportion of their adoptable dogs listed on the platform, while others might use different platforms or methods for listing their adoptable dogs. This could limit the comprehensiveness of the data and introduce geographical biases in the analysis.

# Conclusion / Summary Takeaways

Taken together, our analysis of adoptable dogs in the United States provides valuable insights into the factors that influence their adoptability and the different characteristics that vary across states. The project aims to uncover the adoption process by answering three key research questions: identifying the most common breeds of adoptable dogs, exploring correlations between age or size and adoptability, and examining differences in canine characteristics across states. Here are the specific findings from our analysis:

Most Common Breeds Among Adoptable Dogs:
Our analysis shows that certain breeds are more commonly available for adoption in shelters. For example, Pit Bulls and Labrador Retrievers are the most common among all the breeds. This pattern can clearly be seen in the breed distribution map, where the numbers of these breeds are always higher than other breeds. This information is very important to shelter because it can help them to better understand which breeds are more likely to be abandoned or given up. Based on the information, they can tailor adoption events and resources to better meet the specific needs of these breeds.

Correlation Between Age or Size and Adoptability:
One key finding was a significant correlation between a dog’s age and its adoptability. Our data showed that younger dogs, especially puppies and young adults, were more likely to be adopted than older dogs. This trend is visualized in the adoptability by age chart, where younger dogs had significantly higher adoption rates. Additionally, the size of a dog also had an impact on its adoptability. As shown in our size vs. adoptability analysis, small to medium dogs were adopted more often than large dogs. These insights can help shelters set priorities and develop strategies to promote adoptions of older and larger dogs, who may require more attention before they can find homes.

Characteristics of Dogs Across Different States:
Our state-level analysis found that the characteristics of adoptable dogs vary widely from state to state. For example, the popularity of certain dog breeds and the average size of dogs vary from state to state. In states like Mississippi, there is a higher percentage of large dogs or medium-sized breeds (such as Labrador Retrievers), while in states like California, small breeds are more common. Knowing this geographic variation is important for understanding regional preferences and challenges in dog adoption. Potentially, shelters can use this information to develop location-specific adoption strategies with other local organizations in order to meet the unique needs of their communities.

Important Insight
One of the most important insights from our analysis is the clear preference for younger and smaller dogs when it comes to adoption. This preference has significant implications for how shelters and rescue organizations approach their adoption efforts. By recognizing that senior and larger dogs are less likely to be adopted, shelters can implement targeted campaigns to highlight the benefits of adopting these less preferred groups. For example, they can offer incentives such as reduced adoption fees, provide more information about the temperament and care needs of older dogs, or create special events that focus on adopting larger breeds.

Broader Implications
The broad implications of this insight are not limited to individual shelters, but also to overall strategies to improve animal welfare and adoption rates. By understanding the factors that impact adoptability, policymakers and animal welfare advocates can develop more effective programs and policies to support shelters. This may include funding special adoption programs, developing educational campaigns to change public perceptions of senior and large dogs, and working with businesses and communities to promote adoptions. Ultimately, these efforts can increase adoption rates, reduce shelter overcrowding, and result in better outcomes for dogs who need families.
