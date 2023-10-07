                                              executiontarget(1)                                              
                                                                                                              
                                                   sort(2)                                                    
                                                                                                              
                                                    map(3)                                                    
                                                                                                              
                                                  groupby(4)                                                  
                                                                                                              
                                                    map(5)                                                    
                                                                                                              
                                                   join(6)                                                    
                                                   hash                                                       
                                                                                                              
tablescan(7)                                              join(8)                                             
n2                                                        hash                                                
                                                                                                              
                       join(9)                                         join(12)                               
                       hash                                            hash                                   
                                                                                                              
             tablescan(10) tablescan(11)                        join(13)                         tablescan(20)
             region        n1                                   hash                             customer     
                           ep: (9)                                                               ep: (12)(8)  
                                                         join(14)                  tablescan(19)              
                                                         hash                      orders                     
                                                                                   ep: (13)                   
                                                  join(15)           tablescan(18)                            
                                                  hash               supplier                                 
                                                                     ep: (14)                                 
                                         tablescan(16) tablescan(17)                                          
                                         part          lineitem                                               
                                                       ep: (15)                                               
