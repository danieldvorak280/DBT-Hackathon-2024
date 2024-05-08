
  
    

        create or replace transient table "HACKATHON"."TEAM_01"."PIZZA_ORDER_ITEM_TOPPINGS"
         as
        (

    
            
            select 
                ID as TEAM_01_ALL_PIZZA_ORDER_ITEM_TOPPINGS_ID,
                *  
            from HACKATHON.DATA_SAMPLE.PIZZA_ORDER_ITEM_TOPPINGS
        );
      
  