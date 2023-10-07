┌───────────────────────────┐                             
│    UNGROUPED_AGGREGATE    │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│          sum(#0)          │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│         PROJECTION        │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│ (l_extendedprice * (1.00 -│                             
│        l_discount))       │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│         PROJECTION        │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│             #1            │                             
│             #2            │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│         PROJECTION        │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│             #1            │                             
│             #3            │                             
│             #4            │                             
│             #6            │                             
│             #7            │                             
│             #8            │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│           FILTER          │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│(((l_quantity <= 11.00) AND│                             
│ (p_size <= 5) AND (p_brand│                             
│     = 'Brand#12') AND (   │                             
│(p_container = 'SM CAS...  │                             
│(p_container = 'SM BOX...  │                             
│(p_container = 'SM PAC...  │                             
│(p_container = 'SM PKG...  │                             
│ ((l_quantity >= 10.00) AND│                             
│ (l_quantity <= 20.00) AND │                             
│(p_size <= 10) AND (p_brand│                             
│     = 'Brand#23') AND (   │                             
│(p_container = 'MED BA...  │                             
│(p_container = 'MED BO...  │                             
│(p_container = 'MED PK...  │                             
│(p_container = 'MED PA...  │                             
│  OR ((l_quantity >= 20.00)│                             
│  AND (l_quantity <= 30.00)│                             
│   AND (p_size <= 15) AND  │                             
│(p_brand = 'Brand#34')...  │                             
│(p_container = 'LG CAS...  │                             
│(p_container = 'LG BOX...  │                             
│(p_container = 'LG PAC...  │                             
│ (p_container = 'LG PKG')))│                             
│             )             │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│        EC: 41582516       │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│         HASH_JOIN         │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│           INNER           │                             
│   l_partkey = p_partkey   ├──────────────┐              
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │              │              
│        EC: 41582516       │              │              
└─────────────┬─────────────┘              │                                           
┌─────────────┴─────────────┐┌─────────────┴─────────────┐
│           FILTER          ││         SEQ_SCAN          │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│ ((l_shipmode = 'AIR') OR  ││            part           │
│ (l_shipmode = 'AIR REG')) ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││         p_partkey         │
│        EC: 76800122       ││          p_brand          │
│                           ││        p_container        │
│                           ││           p_size          │
│                           ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│                           ││        EC: 51200000       │
└─────────────┬─────────────┘└───────────────────────────┘                             
┌─────────────┴─────────────┐                             
│         SEQ_SCAN          │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│          lineitem         │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│         l_partkey         │                             
│         l_quantity        │                             
│         l_shipmode        │                             
│      l_extendedprice      │                             
│         l_discount        │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│  Filters: l_shipinstruct  │                             
│   =DELIVER IN PERSON AND  │                             
│ l_shipinstruct IS NOT NULL│                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│        EC: 76800122       │                             
└───────────────────────────┘                                                          
