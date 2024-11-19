# _The Good Place_ Analysis

### Project Overview
This data analysis project aims to provide insights into the viewership and ratings performance of the TV show The Good Place. By analyzing various aspects of the show’s data, such as audience ratings, episode viewership, and creative contributions from writers and directors, we seek to identify trends, uncover audience preferences, and gain a deeper understanding of the factors contributing to the show’s success.

![PowerBI Report](TheGoodPlaceDashboardSS.png)
### Data Sources

Episode Data: The first dataset used for this analysis is the "the_good_place_episodes" file, containing detailed information about every episode created.

IMDb Data: The second dataset used for this analysis is the "the_good_place_imdb" file, containing detailed information about ratings for every episode.

**Both Datasets were sourced from [Kaggle](https://www.kaggle.com/datasets/bcruise/the-good-place-episode-data); however, the CSV file has been included in this repository.**

### Tools 

- Excel - Data Collection and Exploration
- MySQL Workbench - Data Cleaning & Data Analysis
- PowerBI - Creating Reports


### Data Preparation and Cleaning

In the initial data preparation phase, we performed the following tasks:
1. Data loading and inspection
2. Handling Null and Blank values
3. Removing Duplicates
4. Standardizing the Data

### Exploratory Data Analysis

EDA involved exploraing the show's data to answer key questions, such as:

1. What are the 5 most popular episodes?
2. What are the 5 most viewed episodes?
3. Is there a relationship between viewership and ratings for each episode?
4. How many episodes has each director, directed?
5. What is the average rating for each director?
6. How many episodes has each writing group, written?
7. What is the average rating for each writing group?
8. How many unique pairings of directors and writers have worked on the show?
9. What is the average rating for each director & writer(s) pairing?
10. What are the 10 highest rated episodes, and who directed and wrote them?
11. From episode to episode, what was the percent change in viewership and ratings?
12. From season to season, what is the percent change in the average viewership and average ratings?


### Summary of Findings
* Viewership
  1. As the seasons went on, overall viewership decreased alongside average viewership.
  2. Season 1 holds the most watched episodes, with season 2 taking over by their 11th episode.
      - This attributes to viewers' tendency to test out shows and determine whether or not they will continue watching.
  3. As the seasons went on, viewership became more consistent and stable.
    
* Popularity
    1. Season 2 has the highest average rating out of all the seasons.
        - It has 6 episodes within the top ten highest rated. 
    2. Season 2 has the most consistent ratings.
    3. The two highest rated episdoes belong to season 4 finale and season 1 finale.
        - Episodes had major plot points and were well received by the overall audience.

**There is no definitive relationship found between viewership and ratings considering the consistent decrease in viewership over the seasons, while ratings are prone to more fluctuations** 

* Directors & Writers
    1. The Director with the highest average rating is Michael Schur.
    2. The Writer(s) with the highest average rating is also Michael Schur.
    3. Michael Schur has the highest average rated episodes when he both directs and writes episodes.


### Recommendations
- Increase the creative contributions of Michael Schur.
    - The audience seems to resonate with his work more.
- With the consistency in ratings, look towards season 2 for quality storylines that resonate with the audience a lot more.
- Considering the large drop off of viewership, promotion of the show should also remain consistent throughout the seasons.
    - Continue promotional efforts, maybe even increase it if possible, as the show goes on.   


### Limitations
* Some Episodes were 2 parts and in the first dataset, they were split and labeled as such; however, in the IMDb dataset they were identified as a single episode. To counter this I ulitmately inserted the part 2 of the episodes into the IMDb dataset because they consisted of the same release date, episode number, views, and descriptions. Everything was the same except the creative contributions, because they were aired as a single long episode.
* The dataset only includes viewership and ratings from audiences in the United States. Findings may not represent global satisfaction and behaviors.
