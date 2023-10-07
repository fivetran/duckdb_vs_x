          executiontarget(1)           
                                       
                sort(2)                
                                       
              groupby(3)               
                                       
                map(4)                 
                                       
                join(5)                
                hash                   
                                       
 groupby(6)       leftantijoin(8)      
                  hash                 
tablescan(7)                           
customer     tablescan(9) tablescan(10)
             customer     orders       
                          ep: (8)      
