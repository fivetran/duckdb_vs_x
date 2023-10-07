                        executiontarget(1)                        
                                                                  
                             sort(2)                              
                                                                  
                         leftsemijoin(3)                          
                         hash                                     
                                                                  
         join(4)                          join(7)                 
         hash                             hash                    
                                                                  
tablescan(5) tablescan(6)      rightsemijoin(8)         map(11)   
nation       supplier          hash                               
             ep: (4)                                  groupby(12) 
                          tablescan(9) tablescan(10)              
                          part         partsupp      tablescan(13)
                                       ep: (8)(3)    lineitem     
                                                     ep: (7)      
