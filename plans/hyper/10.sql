                 executiontarget(1)                 
                                                    
                      sort(2)                       
                                                    
                     groupby(3)                     
                                                    
                      join(4)                       
                      hash                          
                                                    
               join(5)                 tablescan(10)
               hash                    lineitem     
                                       ep: (4)      
tablescan(6)          join(7)                       
nation                hash                          
                                                    
             tablescan(8) tablescan(9)              
             orders       customer                  
                          ep: (7)                   
