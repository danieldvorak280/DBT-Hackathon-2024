
  
    

        create or replace transient table "HACKATHON"."TEAM_01"."PIZZA_CUSTOMERS"
         as
        (

    
            
            select 
                ID as TEAM_01_ALL_PIZZA_CUSTOMERS_ID,
                *  
            from HACKATHON.DATA_SAMPLE.PIZZA_CUSTOMERS
        );
      
  