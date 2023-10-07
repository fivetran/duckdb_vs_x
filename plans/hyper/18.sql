                  executiontarget(1)                  
                                                      
                       sort(2)                        
                                                      
                      groupby(3)                      
                                                      
                       join(4)                        
                       hash                           
                                                      
                join(5)                  tablescan(12)
                hash                     lineitem     
                                         ep: (4)      
tablescan(6)      rightsemijoin(7)                    
customer          hash                                
                                                      
               select(8)   tablescan(11)              
                           orders                     
              groupby(9)   ep: (7)                    
                                                      
             tablescan(10)                            
             lineitem                                 
