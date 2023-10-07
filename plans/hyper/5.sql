                                executiontarget(1)                                
                                                                                  
                                     sort(2)                                      
                                                                                  
                                    groupby(3)                                    
                                                                                  
                                     join(4)                                      
                                     hash                                         
                                                                                  
tablescan(5)                                join(6)                               
supplier                                    hash                                  
                                                                                  
                                     join(7)                         tablescan(14)
                                     hash                            lineitem     
                                                                     ep: (6)      
                              join(8)                  tablescan(13)              
                              hash                     orders                     
                                                       ep: (7)                    
                       join(9)           tablescan(12)                            
                       hash              customer                                 
                                         ep: (8)                                  
             tablescan(10) tablescan(11)                                          
             region        nation                                                 
                           ep: (9)                                                
