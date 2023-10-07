                               executiontarget(1)                                
                                                                                 
                                     sort(2)                                     
                                                                                 
                                     join(3)                                     
                                     hash                                        
                                                                                 
                map(4)                                 groupby(11)               
                                                                                 
              groupby(5)                                join(12)                 
                                                        hash                     
                join(6)                                                          
                hash                             join(13)           tablescan(16)
                                                 hash               partsupp     
         join(7)          tablescan(10)                             ep: (12)     
         hash             partsupp      tablescan(14) tablescan(15)              
                          ep: (6)       nation        supplier                   
tablescan(8) tablescan(9)               ep: (3)       ep: (13)                   
nation       supplier                                                            
             ep: (7)                                                             
