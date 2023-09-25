import duckdb
import time
import statistics

# Configuration.
database = "db"
temp = "temp"

# Generate data.
scales = []
for scale in scales:
    print("Scale {scale} Generate".format(scale=scale))
    generate = """
    install tpcds;
    load tpcds;
    drop schema if exists sf{scale} cascade;
    create schema sf{scale};
    call dsdgen(sf={scale}, schema=sf{scale});
    """.format(scale=scale)
    connection = duckdb.connect(database=database)
    connection.sql(generate)
    connection.close()

# Query data.
scales = ["1000"]
results = []
for scale in scales:
    times = []
    exclude = [4, 14, 19, 23, 54, 67, 72, 78, 95]
    for i in range(1, 100):
        if i in exclude:
            continue
        print("Scale {scale} Query {i}".format(scale=scale, i=i))
        connection = duckdb.connect(database=database, read_only=True)
        connection.sql("set schema = 'sf{scale}'; set enable_progress_bar = true; set temp_directory = '{temp}';".format(scale=scale, temp=temp))
        start = time.time()
        connection.sql("pragma tpcds({i});".format(i=i))
        end = time.time()
        times.append(end-start)
        connection.close()

    results.append(statistics.geometric_mean(times))
    print(results)
