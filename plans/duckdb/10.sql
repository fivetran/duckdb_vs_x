┌───────────────────────────┐                                                                                       
│           TOP_N           │                                                                                       
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
│           Top 20          │                                                                                       
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
│       sum((lineitem       │                                                                                       
│.l_extendedprice * (1 ...  │                                                                                       
│    .l_discount))) DESC    │                                                                                       
└─────────────┬─────────────┘                                                                                                                    
┌─────────────┴─────────────┐                                                                                       
│         PROJECTION        │                                                                                       
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
│         c_custkey         │                                                                                       
│           c_name          │                                                                                       
│          revenue          │                                                                                       
│         c_acctbal         │                                                                                       
│           n_name          │                                                                                       
│         c_address         │                                                                                       
│          c_phone          │                                                                                       
│         c_comment         │                                                                                       
└─────────────┬─────────────┘                                                                                                                    
┌─────────────┴─────────────┐                                                                                       
│         PROJECTION        │                                                                                       
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
│             #0            │                                                                                       
│             #1            │                                                                                       
│             #2            │                                                                                       
│__internal_decompress_strin│                                                                                       
│           g(#3)           │                                                                                       
│__internal_decompress_strin│                                                                                       
│           g(#4)           │                                                                                       
│             #5            │                                                                                       
│             #6            │                                                                                       
│             #7            │                                                                                       
└─────────────┬─────────────┘                                                                                                                    
┌─────────────┴─────────────┐                                                                                       
│       HASH_GROUP_BY       │                                                                                       
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
│             #0            │                                                                                       
│             #1            │                                                                                       
│             #2            │                                                                                       
│             #3            │                                                                                       
│             #4            │                                                                                       
│             #5            │                                                                                       
│             #6            │                                                                                       
│          sum(#7)          │                                                                                       
└─────────────┬─────────────┘                                                                                                                    
┌─────────────┴─────────────┐                                                                                       
│         PROJECTION        │                                                                                       
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
│         c_custkey         │                                                                                       
│           c_name          │                                                                                       
│         c_acctbal         │                                                                                       
│          c_phone          │                                                                                       
│           n_name          │                                                                                       
│         c_address         │                                                                                       
│         c_comment         │                                                                                       
│ (l_extendedprice * (1.00 -│                                                                                       
│        l_discount))       │                                                                                       
└─────────────┬─────────────┘                                                                                                                    
┌─────────────┴─────────────┐                                                                                       
│         PROJECTION        │                                                                                       
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
│             #0            │                                                                                       
│             #1            │                                                                                       
│             #2            │                                                                                       
│             #3            │                                                                                       
│             #4            │                                                                                       
│             #5            │                                                                                       
│             #6            │                                                                                       
│__internal_compress_string_│                                                                                       
│        hugeint(#7)        │                                                                                       
│             #8            │                                                                                       
│             #9            │                                                                                       
│__internal_compress_string_│                                                                                       
│        hugeint(#10)       │                                                                                       
└─────────────┬─────────────┘                                                                                                                    
┌─────────────┴─────────────┐                                                                                       
│         HASH_JOIN         │                                                                                       
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
│           INNER           │                                                                                       
│  l_orderkey = o_orderkey  ├──────────────┐                                                                        
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │              │                                                                        
│        EC: 61262447       │              │                                                                        
└─────────────┬─────────────┘              │                                                                                                     
┌─────────────┴─────────────┐┌─────────────┴─────────────┐                                                          
│         SEQ_SCAN          ││         HASH_JOIN         │                                                          
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
│          lineitem         ││           INNER           │                                                          
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   o_custkey = c_custkey   │                                                          
│         l_orderkey        ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
│      l_extendedprice      ││        EC: 45946762       │                                                          
│         l_discount        ││                           ├──────────────┐                                           
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │              │                                           
│Filters: l_returnflag=R AND││                           │              │                                           
│  l_returnflag IS NOT NULL ││                           │              │                                           
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │              │                                           
│       EC: 512000814       ││                           │              │                                           
└───────────────────────────┘└─────────────┬─────────────┘              │                                                                        
                             ┌─────────────┴─────────────┐┌─────────────┴─────────────┐                             
                             │         SEQ_SCAN          ││         HASH_JOIN         │                             
                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
                             │           orders          ││           INNER           │                             
                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││ c_nationkey = n_nationkey │                             
                             │         o_custkey         ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
                             │         o_orderkey        ││        EC: 38400000       │                             
                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           ├──────────────┐              
                             │ Filters: o_orderdate>=1993││                           │              │              
                             │-10-01 AND o_orderdate<1994││                           │              │              
                             │ -01-01 AND o_orderdate IS ││                           │              │              
                             │          NOT NULL         ││                           │              │              
                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │              │              
                             │        EC: 76800000       ││                           │              │              
                             └───────────────────────────┘└─────────────┬─────────────┘              │                                           
                                                          ┌─────────────┴─────────────┐┌─────────────┴─────────────┐
                                                          │         SEQ_SCAN          ││         SEQ_SCAN          │
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
                                                          │          customer         ││           nation          │
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
                                                          │         c_custkey         ││        n_nationkey        │
                                                          │        c_nationkey        ││           n_name          │
                                                          │           c_name          ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
                                                          │         c_acctbal         ││           EC: 25          │
                                                          │          c_phone          ││                           │
                                                          │         c_address         ││                           │
                                                          │         c_comment         ││                           │
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │
                                                          │    Filters: c_custkey<    ││                           │
                                                          │=38399999 AND c_custke...  ││                           │
                                                          │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │
                                                          │        EC: 38400000       ││                           │
                                                          └───────────────────────────┘└───────────────────────────┘                             
