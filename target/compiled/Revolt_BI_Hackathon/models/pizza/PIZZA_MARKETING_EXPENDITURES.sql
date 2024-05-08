

    
            
            select
                row_number() over (order by EXPENDITURE_DATE) as TEAM_01_ALL_PIZZA_MARKETING_EXPENDITURES_ID,
                *
            from HACKATHON.DATA_SAMPLE.PIZZA_MARKETING_EXPENDITURES