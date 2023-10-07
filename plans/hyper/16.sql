          executiontarget(1)          
                                      
               sort(2)                
                                      
              groupby(3)              
                                      
           rightantijoin(4)           
           hash                       
                                      
tablescan(5)          join(6)         
supplier              hash            
                                      
             tablescan(7) tablescan(8)
             part         partsupp    
                          ep: (6)     
