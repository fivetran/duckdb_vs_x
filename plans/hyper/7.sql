                                executiontarget(1)                                
                                                                                  
                                     sort(2)                                      
                                                                                  
                                    groupby(3)                                    
                                                                                  
                                      map(4)                                      
                                                                                  
                                     join(5)                                      
                                     hash                                         
                                                                                  
tablescan(6)                                join(7)                               
customer                                    hash                                  
                                                                                  
                                     join(8)                         tablescan(15)
                                     hash                            orders       
                                                                     ep: (7)      
                              join(9)                  tablescan(14)              
                              hash                     lineitem                   
                                                       ep: (8)                    
                      join(10)           tablescan(13)                            
                      bnl                supplier                                 
                                         ep: (9)                                  
             tablescan(11) tablescan(12)                                          
             n2            n1                                                     
