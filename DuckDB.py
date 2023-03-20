import duckdb
import time
import statistics

# Configuration.
database = "/mnt/disks/ssd/db"
database = "db"
scales = ["63", "125", "250"]
results = {}

for scale in scales:
    # Generate data.
    print("Scale {scale} Generate".format(scale=scale))
    generate = """
    install tpcds;
    load tpcds;
    create schema sf{scale};
    call dsdgen(sf={scale}, schema=sf{scale});
    """.format(scale=scale)
    connection = duckdb.connect(database=database)
    # connection.sql(generate)
    connection.close()

    # Query data.
    times = []
    exclude = [4, 14, 19, 23, 54, 67, 72, 78, 95]
    for i in range(1, 100):
        if i in exclude:
            continue
        print("Scale {scale} Query {i}".format(scale=scale, i=i))
        connection = duckdb.connect(database=database, read_only=True)
        connection.sql("set schema = sf{scale}; set enable_progress_bar = true;".format(scale=scale))
        start = time.time()
        connection.sql("pragma tpcds({i});".format(i=i))
        end = time.time()
        times.append(end-start)
        connection.close()

    results[scale] = statistics.geometric_mean(times)
    print(results)