┌───────────────────────────┐                             
│         PROJECTION        │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│__internal_decompress_strin│                             
│           g(#0)           │                             
│             #1            │                             
│             #2            │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│          ORDER_BY         │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│          ORDERS:          │                             
│  lineitem.l_shipmode ASC  │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│         PROJECTION        │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│__internal_compress_string_│                             
│        ubigint(#0)        │                             
│             #1            │                             
│             #2            │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│         PROJECTION        │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│__internal_decompress_strin│                             
│           g(#0)           │                             
│             #1            │                             
│             #2            │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│       HASH_GROUP_BY       │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│             #0            │                             
│          sum(#1)          │                             
│          sum(#2)          │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│         PROJECTION        │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│         l_shipmode        │                             
│       CASE  WHEN ((       │                             
│(o_orderpriority = '1-...  │                             
│(o_orderpriority = '2-...  │                             
│     THEN (1) ELSE 0 END   │                             
│       CASE  WHEN ((       │                             
│(o_orderpriority != '1...  │                             
│(o_orderpriority != '2...  │                             
│     THEN (1) ELSE 0 END   │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│         PROJECTION        │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│             #0            │                             
│             #1            │                             
│             #2            │                             
│__internal_compress_string_│                             
│        ubigint(#3)        │                             
└─────────────┬─────────────┘                                                          
┌─────────────┴─────────────┐                             
│         HASH_JOIN         │                             
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
│           INNER           │                             
│  o_orderkey = l_orderkey  ├──────────────┐              
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │              │              
│        EC: 61440097       │              │              
└─────────────┬─────────────┘              │                                           
┌─────────────┴─────────────┐┌─────────────┴─────────────┐
│         SEQ_SCAN          ││           FILTER          │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│           orders          ││      ((l_commitdate <     │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││ l_receiptdate) AND (l...  │
│         o_orderkey        ││ l_commitdate) AND ((l...  │
│      o_orderpriority      ││= 'MAIL') OR (l_shipmode = │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││         'SHIP')))         │
│       EC: 384000000       ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│                           ││        EC: 61440097       │
└───────────────────────────┘└─────────────┬─────────────┘                             
                             ┌─────────────┴─────────────┐
                             │         SEQ_SCAN          │
                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
                             │          lineitem         │
                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
                             │         l_orderkey        │
                             │         l_shipmode        │
                             │        l_commitdate       │
                             │       l_receiptdate       │
                             │         l_shipdate        │
                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
                             │Filters: l_shipdate<1995-01│
                             │ -01 AND l_shipdate IS NOT │
                             │            NULL           │
                             │ l_receiptdate>=1994-01-01 │
                             │ AND l_receiptdate<199...  │
                             │  AND l_receiptdate IS NOT │
                             │            NULL           │
                             │l_commitdate<1995-01-01 AND│
                             │  l_commitdate IS NOT NULL │
                             │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
                             │        EC: 61440097       │
                             └───────────────────────────┘                             
