                                executiontarget(1)                                
                                                                                  
                                     sort(2)                                      
                                                                                  
                                    groupby(3)                                    
                                                                                  
                                 leftsemijoin(4)                                  
                                 hash                                             
                                                                                  
                          leftantijoin(5)                            tablescan(14)
                          hash                                       l2           
                                                                     ep: (4)      
                       join(6)                         tablescan(13)              
                       hash                            l3                         
                                                       ep: (5)                    
                join(7)                  tablescan(12)                            
                hash                     orders                                   
                                         ep: (6)                                  
         join(8)           tablescan(11)                                          
         hash              l1                                                     
                           ep: (7)                                                
tablescan(9) tablescan(10)                                                        
nation       supplier                                                             
             ep: (8)                                                              
