                                                    executiontarget(1)                                                     
                                                                                                                           
                                                          sort(2)                                                          
                                                                                                                           
                                                          join(3)                                                          
                                                          hash                                                             
                                                                                                                           
         join(4)                                                       join(7)                                             
         hash                                                          hash                                                
                                                                                                                           
tablescan(5) tablescan(6)                                       join(8)                                       tablescan(20)
region       nation                                             hash                                          supplier     
             ep: (4)                                                                                          ep: (7)(3)   
                                                         join(9)                                tablescan(19)              
                                                         hash                                   partsupp                   
                                                                                                ep: (8)                    
                          tablescan(10)                       groupby(11)                                                  
                          part                                                                                             
                                                               join(12)                                                    
                                                               hash                                                        
                                                                                                                           
                                                        join(13)                  tablescan(18)                            
                                                        hash                      partsupp                                 
                                                                                  ep: (12)(9)                              
                                                 join(14)           tablescan(17)                                          
                                                 hash               supplier                                               
                                                                    ep: (13)                                               
                                        tablescan(15) tablescan(16)                                                        
                                        region        nation                                                               
                                                      ep: (14)                                                             
