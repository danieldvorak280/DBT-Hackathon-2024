
  
    

        create or replace transient table "HACKATHON"."TEAM_01"."test_macro"
         as
        (



    
            
            select 
                ID as TEAM_01_ALL_PIZZA_ORDERS_ID,
                *  
            from HACKATHON.DATA_SAMPLE.PIZZA_ORDERS
        );
      
  