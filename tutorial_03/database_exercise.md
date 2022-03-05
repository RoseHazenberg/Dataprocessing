1. How is the input output construction handled in case of a database?  
   * Een blast database wordt gecreëerd door die meerdere files genereert voor de structuur van de database.
   * De bestand worden gebruikt om blast te runnen en een .tsv file te genereren om data uitwisselen tussen databasen.
   * De .tsv file wordt geparst en genereert een .txt bestand. 
2. How is de Snakefile documented?  
   * De hele Snakefile is niet gedocumenteerd.
3. What would you improve in this script?  
   * Ik zou de file documenteren. En ik zou de credentials van mySQL login ook in de config file zetten als dat mogelijk is 
   en dan aangeven met config[''].    