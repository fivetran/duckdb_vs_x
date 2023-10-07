                executiontarget(1)                
                                                  
                     sort(2)                      
                                                  
                     join(3)                      
                     hash                         
                                                  
              join(4)                tablescan(10)
              hash                   supplier     
                                     ep: (3)      
  groupby(5)    explicitscan(9)->(7)              
                                                  
explicitscan(6)                                   
                                                  
  groupby(7)                                      
                                                  
 tablescan(8)                                     
 lineitem                                         
