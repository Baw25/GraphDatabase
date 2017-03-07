# GraphDatabase

##Assignment
  In this challenge you will spend one to two hours building a simple graph database on top of a sample of
  IMDB feature films and actor credits. Your program will include a command-line client that receives
  commands via standard-in and prints responses through standard-out
  
  Include: COUNT, INTERSECT, SET EPOCH, UNSET EPOCH, BACON NUMBER, END commands

##Tech Used

  1. Ruby 

  2. Rspec 
  
##Directions
  1. Clone this repo locally 
    
    `git clone <this repo url>`
  
  2. bundle program
  
    `bundle`
  
  3. run loading of data and graph database CLI 
  
    `ruby runner.rb`
    
    Use the following commands: 
    
    `COUNT <movie> or <actor>`
    
    `INTERSECT <movie1> <movie2> or <actor1> <actor2>`
    
    `BACON <movie> or <actor>`
    
    `SET EPOCH <year1> <year2>`
    
    `UNSET EPOCH`
  
  4. run tests 
  
    'bundle exec rspec spec -fd spec/graph_spec.rb`
  
  ##Writeup 
  
    For this assignment, the goal was to create a graph database between three different node types: movie, actor, year. The nodes would each have their own class and be encapsulated by a larger GraphDB (graph database) structure. The graph database class would contain the CLI commands appearing in runner.rb and can be called on the GraphDB instance. 

    The CLI is located in the runner.rb. The CLI first loads the total data located at the following url: 

        https://s3-us-west-2.amazonaws.com/ies-challenges/imdb-movies.txt

    A local CSV for the data was created for the sake of this assignment demonstration. The goal for loading the data into a GraphDB instance was to create the appropriate movie, actor, and year nodes. Due to the format of the data, the data was loaded with a time complexity of approximately (fill in later) and a space complexity that was dependent on the number movies and actors in the input file. This met the goals for loading. 

    As for commands, the COUNT commands yield constant time complexities because they access the actor or movie count attributes. The INTERSECT commands yield a linear time complexity due to the iteration between the actors of both movies and the movies of both actors in order to collect matches. The SET EPOCH command is linear time complexity operaton due to the iteration and filtering through all the year nodes and the UNSET EPOCH is a constant operation. The EPOCH operation creates an additional store of filtered movies while keeping the original movies in the temp_movie_store attribute for the GraphDB. Last, the BACON command uses Breadth First Search through the movie actors or actor costars which yields a time complexity of (V + E) with V = # vertices/nodes and E = # edges (actors and movies combined). The space complexity for this operation is based on V.

    The aspects of this program I would improve are the initial data loading. This aspect was tricky because in order to seed the database, the migration is atleast dependent on the amount of rows in the text file. Therefore, I'm not sure how much can be done here for improvement. Another aspect I would improve is updating the the bacon number function to allow for other actor number calculation score. For instance, a Denzel Washington number or Tom Hanks number. The bacon function and helper function will calculate the score based on input actor to yield scores for a movie or actor with the same rules as the Kevin Bacon structure. This would yield some interesting insights for movies. Finally, I would add other typical SQL functions for querying like ORDER BY, GROUP BY, AVG, SUM, etc. These would be a module of commands I would construct and then include into the GraphDB class. I don't think adding this module will update my current GraphDB as long as the functions are built in an abstract way. 

    Overall, I was excited the constructing the EPOCH command. Creating a filter for any commands following the EPOCH command was challenging, but seemed interesting once the years nodes for filtering movies were identified as the best choice for implementation. Creating this command produced thoughts of other functions for other filtering functions that could be added to actors or movies. 








    
  
  
