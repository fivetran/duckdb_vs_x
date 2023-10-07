          executiontarget(1)           
                                       
                map(2)                 
                                       
              groupby(3)               
                                       
                join(4)                
                hash                   
                                       
         join(5)          tablescan(10)
         hash             lineitem     
                          ep: (4)      
tablescan(6)    map(7)                 
part                                   
              groupby(8)               
                                       
             tablescan(9)              
             lineitem                  
             ep: (5)                   
