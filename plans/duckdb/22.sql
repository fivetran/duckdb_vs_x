┌───────────────────────────┐                                                                                                                    
│          ORDER_BY         │                                                                                                                    
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                    
│          ORDERS:          │                                                                                                                    
│   custsale.cntrycode ASC  │                                                                                                                    
└─────────────┬─────────────┘                                                                                                                                                 
┌─────────────┴─────────────┐                                                                                                                    
│       HASH_GROUP_BY       │                                                                                                                    
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                    
│             #0            │                                                                                                                    
│        count_star()       │                                                                                                                    
│          sum(#1)          │                                                                                                                    
└─────────────┬─────────────┘                                                                                                                                                 
┌─────────────┴─────────────┐                                                                                                                    
│         PROJECTION        │                                                                                                                    
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                    
│         cntrycode         │                                                                                                                    
│         c_acctbal         │                                                                                                                    
└─────────────┬─────────────┘                                                                                                                                                 
┌─────────────┴─────────────┐                                                                                                                    
│         PROJECTION        │                                                                                                                    
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                    
│         cntrycode         │                                                                                                                    
│         c_acctbal         │                                                                                                                    
└─────────────┬─────────────┘                                                                                                                                                 
┌─────────────┴─────────────┐                                                                                                                    
│         HASH_JOIN         │                                                                                                                    
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                    
│            ANTI           │                                                                                                                    
│ c_custkey IS NOT DISTINCT ├─────────────────────────────────────────────────────────────────────────────────────────────────────┐              
│       FROM c_custkey      │                                                                                                     │              
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                     │              
│       EC: 384000000       │                                                                                                     │              
└─────────────┬─────────────┘                                                                                                     │                                           
┌─────────────┴─────────────┐                                                                                       ┌─────────────┴─────────────┐
│      NESTED_LOOP_JOIN     │                                                                                       │         SEQ_SCAN          │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│           INNER           │                                                                                       │           orders          │
│CAST(c_acctbal AS DOUBLE) >├───────────────────────────────────────────┐                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│          SUBQUERY         │                                           │                                           │         o_custkey         │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                           │                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│        EC: 32272050       │                                           │                                           │       EC: 384000000       │
└─────────────┬─────────────┘                                           │                                           └───────────────────────────┘                             
┌─────────────┴─────────────┐                             ┌─────────────┴─────────────┐                                                          
│           FILTER          │                             │    UNGROUPED_AGGREGATE    │                                                          
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
│          IN (...)         │                             │         first(#0)         │                                                          
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             │                           │                                                          
│        EC: 7680000        │                             │                           │                                                          
└─────────────┬─────────────┘                             └─────────────┬─────────────┘                                                                                       
┌─────────────┴─────────────┐                             ┌─────────────┴─────────────┐                                                          
│         HASH_JOIN         │                             │         PROJECTION        │                                                          
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
│            MARK           │                             │             #0            │                                                          
│substring(c_phone, 1, 2) = ├──────────────┐              │                           │                                                          
│             #0            │              │              │                           │                                                          
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │              │              │                           │                                                          
│        EC: 38400000       │              │              │                           │                                                          
└─────────────┬─────────────┘              │              └─────────────┬─────────────┘                                                                                       
┌─────────────┴─────────────┐┌─────────────┴─────────────┐┌─────────────┴─────────────┐                                                          
│         SEQ_SCAN          ││      COLUMN_DATA_SCAN     ││      STREAMING_LIMIT      │                                                          
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           ││                           │                                                          
│          customer         ││                           ││                           │                                                          
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           ││                           │                                                          
│          c_phone          ││                           ││                           │                                                          
│         c_acctbal         ││                           ││                           │                                                          
│         c_custkey         ││                           ││                           │                                                          
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           ││                           │                                                          
│        EC: 38400000       ││                           ││                           │                                                          
└───────────────────────────┘└───────────────────────────┘└─────────────┬─────────────┘                                                                                       
                                                          ┌─────────────┴─────────────┐                                                          
                                                          │    UNGROUPED_AGGREGATE    │                                                          
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
                                                          │          avg(#0)          │                                                          
                                                          └─────────────┬─────────────┘                                                                                       
                                                          ┌─────────────┴─────────────┐                                                          
                                                          │         PROJECTION        │                                                          
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
                                                          │         c_acctbal         │                                                          
                                                          └─────────────┬─────────────┘                                                                                       
                                                          ┌─────────────┴─────────────┐                                                          
                                                          │         PROJECTION        │                                                          
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
                                                          │             #0            │                                                          
                                                          │             #2            │                                                          
                                                          └─────────────┬─────────────┘                                                                                       
                                                          ┌─────────────┴─────────────┐                                                          
                                                          │           FILTER          │                                                          
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
                                                          │          IN (...)         │                                                          
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
                                                          │        EC: 7680000        │                                                          
                                                          └─────────────┬─────────────┘                                                                                       
                                                          ┌─────────────┴─────────────┐                                                          
                                                          │         HASH_JOIN         │                                                          
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
                                                          │            MARK           │                                                          
                                                          │substring(c_phone, 1, 2) = ├──────────────┐                                           
                                                          │             #0            │              │                                           
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │              │                                           
                                                          │        EC: 7680000        │              │                                           
                                                          └─────────────┬─────────────┘              │                                                                        
                                                          ┌─────────────┴─────────────┐┌─────────────┴─────────────┐                             
                                                          │         SEQ_SCAN          ││      COLUMN_DATA_SCAN     │                             
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │                             
                                                          │          customer         ││                           │                             
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │                             
                                                          │         c_acctbal         ││                           │                             
                                                          │          c_phone          ││                           │                             
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │                             
                                                          │Filters: c_acctbal>0.00 AND││                           │                             
                                                          │    c_acctbal IS NOT NULL  ││                           │                             
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │                             
                                                          │        EC: 7680000        ││                           │                             
                                                          └───────────────────────────┘└───────────────────────────┘                                                          
