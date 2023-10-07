          executiontarget(1)          
                                      
               sort(2)                
                                      
              groupby(3)              
                                      
               join(4)                
               hash                   
                                      
         join(5)          tablescan(8)
         hash             lineitem    
                          ep: (4)     
tablescan(6) tablescan(7)             
customer     orders                   
             ep: (5)                  
