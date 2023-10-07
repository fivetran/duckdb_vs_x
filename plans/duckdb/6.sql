┌───────────────────────────┐
│    UNGROUPED_AGGREGATE    │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│    sum_no_overflow(#0)    │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│         PROJECTION        │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│     (l_extendedprice *    │
│         l_discount)       │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│         SEQ_SCAN          │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│          lineitem         │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│         l_discount        │
│      l_extendedprice      │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│ Filters: l_shipdate>=1994 │
│-01-01 AND l_shipdate<...  │
│ -01 AND l_shipdate IS NOT │
│            NULL           │
│    l_discount>=0.05 AND   │
│ l_discount<=0.07 AND ...  │
│         IS NOT NULL       │
│    l_quantity<24.00 AND   │
│   l_quantity IS NOT NULL  │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│       EC: 307200488       │
└───────────────────────────┘                             
