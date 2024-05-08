
  
    

        create or replace transient table "HACKATHON"."TEAM_01"."PIZZA_ORDER_ITEMS"
         as
        (

    
            
            select 
                ID as TEAM_01_ALL_PIZZA_ORDER_ITEMS_ID,
                *  
            from HACKATHON.DATA_SAMPLE.PIZZA_ORDER_ITEMS
        );
      
  