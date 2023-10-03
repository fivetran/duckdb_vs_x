import duckdb
import os
import threading
from tableauhyperapi import HyperProcess, Telemetry, Connection, CreateMode
import time
import statistics

parallelism = 100
tables = ['nation','region','customer','supplier','lineitem','orders','partsupp','part']

# def generate_queries():
#     for query in range(1, 23):
#         text = duckdb.sql(f"select query from tpch_queries() where query_nr = {query}").to_df().get("query")[0]
#         with open(f"queries/{query}.sql", "w") as file:
#             file.write(text)

def make_dirs(scale):
    for table in tables:
        path = f"/tmp/benchmark/{scale}/{table}"
        if not os.path.exists(path):
            os.makedirs(path)

def generate_data(scale, step):
    duckdb.sql(f"create schema tpch_{scale}_{step}; call dbgen(schema=tpch_{scale}_{step}, sf={scale}, children={parallelism}, step={step})")
    for table in tables:
        duckdb.sql(f"copy tpch_{scale}_{step}.{table} to '/tmp/benchmark/{scale}/{table}/{step}.parquet'")

def generate_all_data(scale):
    make_dirs(scale)
    threads = []
    for step in range(0, parallelism):
        thread = threading.Thread(target=generate_data, args=(scale, step))
        thread.start()
        threads.append(thread)
    for thread in threads:
        thread.join()

def copy_to_duckdb(scale):
    path=f"/tmp/benchmark/{scale}/duckdb"
    if os.path.exists(path):
        os.remove(path)
    with duckdb.connect(path) as connection:
        for table in tables:
            connection.sql(f"""
            create table {table} as select * from '/tmp/benchmark/{scale}/{table}/*.parquet';
            """)

def copy_to_hyper(scale):
    with HyperProcess(telemetry=Telemetry.SEND_USAGE_DATA_TO_TABLEAU) as hyper:
        with Connection(endpoint=hyper.endpoint, database=f"/tmp/benchmark/{scale}/hyper",create_mode=CreateMode.CREATE_AND_REPLACE) as connection:
            for table in ['nation','region','customer','supplier','lineitem','orders','partsupp','part']:
                files_list =[ f"'/tmp/benchmark/{scale}/{table}/{step}.parquet'" for step in range(0, parallelism) ]
                files_string = ", ".join(files_list)
                connection.execute_command(f"create table {table} as (select * from external(array[{files_string}]))")

def benchmark_duckdb(scale):
    with duckdb.connect(f"/tmp/benchmark/{scale}/duckdb") as connection:
        times = []
        for query in range(1, 23):
            start = time.time()
            text = open(f"queries/{query}.sql").read()
            connection.sql(text).execute()
            end = time.time()
            times.append(end-start)
        print(statistics.geometric_mean(times))

def benchmark_hyper(scale):
    with HyperProcess(telemetry=Telemetry.SEND_USAGE_DATA_TO_TABLEAU) as hyper:
        with Connection(endpoint=hyper.endpoint, database=f"/tmp/benchmark/{scale}/hyper",create_mode=CreateMode.NONE) as connection:
            times = []
            for query in range(1, 23):
                start = time.time()
                text = open(f"queries/{query}.sql").read()
                connection.execute_query(text).close()
                end = time.time()
                times.append(end-start)
            print(statistics.geometric_mean(times))

for scale in [1, 2, 4, 8, 16, 32, 64]:
    print(f"Scale {scale}...")
    print("...generate data")
    generate_all_data(scale)
    print("...copy to DuckDB")
    copy_to_duckdb(scale)
    print("...copy to Hyper")
    copy_to_hyper(scale)
    print("...benchmark DuckDB")
    benchmark_duckdb(scale)
    print("...benchmark Hyper")
    benchmark_hyper(scale)

