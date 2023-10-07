┌───────────────────────────┐
│         PROJECTION        │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│__internal_decompress_strin│
│           g(#0)           │
│__internal_decompress_strin│
│           g(#1)           │
│             #2            │
│             #3            │
│             #4            │
│             #5            │
│             #6            │
│             #7            │
│             #8            │
│             #9            │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│          ORDER_BY         │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│          ORDERS:          │
│ lineitem.l_returnflag ASC │
│ lineitem.l_linestatus ASC │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│         PROJECTION        │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│__internal_compress_string_│
│        utinyint(#0)       │
│__internal_compress_string_│
│        utinyint(#1)       │
│             #2            │
│             #3            │
│             #4            │
│             #5            │
│             #6            │
│             #7            │
│             #8            │
│             #9            │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│         PROJECTION        │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│__internal_decompress_strin│
│           g(#0)           │
│__internal_decompress_strin│
│           g(#1)           │
│             #2            │
│             #3            │
│             #4            │
│             #5            │
│             #6            │
│             #7            │
│             #8            │
│             #9            │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│   PERFECT_HASH_GROUP_BY   │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│             #0            │
│             #1            │
│    sum_no_overflow(#2)    │
│    sum_no_overflow(#3)    │
│    sum_no_overflow(#4)    │
│          sum(#5)          │
│          avg(#6)          │
│          avg(#7)          │
│          avg(#8)          │
│        count_star()       │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│         PROJECTION        │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│        l_returnflag       │
│        l_linestatus       │
│         l_quantity        │
│      l_extendedprice      │
│             #4            │
│   (#4 * (1.00 + l_tax))   │
│         l_quantity        │
│      l_extendedprice      │
│         l_discount        │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│         PROJECTION        │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│__internal_compress_string_│
│        utinyint(#0)       │
│__internal_compress_string_│
│        utinyint(#1)       │
│             #2            │
│             #3            │
│             #4            │
│             #5            │
│             #6            │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│         PROJECTION        │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│        l_returnflag       │
│        l_linestatus       │
│         l_quantity        │
│      l_extendedprice      │
│ (l_extendedprice * (1.00 -│
│        l_discount))       │
│           l_tax           │
│         l_discount        │
└─────────────┬─────────────┘                             
┌─────────────┴─────────────┐
│         SEQ_SCAN          │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│          lineitem         │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│        l_returnflag       │
│        l_linestatus       │
│         l_quantity        │
│      l_extendedprice      │
│         l_discount        │
│           l_tax           │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│ Filters: l_shipdate<=1998 │
│-09-02 AND l_shipdate ...  │
│            NULL           │
│   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
│       EC: 307200488       │
└───────────────────────────┘                             
