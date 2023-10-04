import duckdb
import os
from tableauhyperapi import HyperProcess, Telemetry, Connection, CreateMode
import time
import concurrent.futures
import sys

cpus = int(sys.argv[1])
memory = cpus * 4
min_scale = cpus * 2
max_scale = min_scale * 2 * 2
memory_per_scale = 4 # 4:1 ratio of memory to the size of data we generate concurrently.
steps = int(cpus * memory_per_scale * max_scale / memory) # memory_per_scale = memory / (max_scale * cpus / steps)
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
    duckdb.sql(f"create schema tpch_{scale}_{step}; call dbgen(schema=tpch_{scale}_{step}, sf={scale}, children={steps}, step={step})")
    for table in tables:
        duckdb.sql(f"copy tpch_{scale}_{step}.{table} to '/tmp/benchmark/{scale}/{table}/{step}.parquet'")
    duckdb.sql(f"drop schema tpch_{scale}_{step} cascade;")

def generate_all_data(scale):
    make_dirs(scale)
    tasks = []
    with concurrent.futures.ProcessPoolExecutor(cpus) as executor:
        for step in range(0, steps):
            future = executor.submit(generate_data, scale, step)
            tasks.append(future)
        for task in tasks:
            task.result()

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
                files_list =[ f"'/tmp/benchmark/{scale}/{table}/{step}.parquet'" for step in range(0, steps) ]
                files_string = ", ".join(files_list)
                connection.execute_command(f"create table {table} as (select * from external(array[{files_string}]))")

def benchmark_duckdb(scale):
    with duckdb.connect(f"/tmp/benchmark/{scale}/duckdb") as connection:
        for query in range(1, 23):
            start = time.time()
            text = open(f"queries/{query}.sql").read()
            connection.sql(text).execute()
            end = time.time()
            print(f'DuckDB\t{cpus}\t{memory}\t{scale}\t{query}\t{end-start}')

def benchmark_hyper(scale):
    with HyperProcess(telemetry=Telemetry.SEND_USAGE_DATA_TO_TABLEAU) as hyper:
        with Connection(endpoint=hyper.endpoint, database=f"/tmp/benchmark/{scale}/hyper",create_mode=CreateMode.NONE) as connection:
            for query in range(1, 23):
                start = time.time()
                text = open(f"queries/{query}.sql").read()
                connection.execute_query(text).close()
                end = time.time()
                print(f'Hyper\t{cpus}\t{memory}\t{scale}\t{query}\t{end-start}')

if __name__ == "__main__":
    print('System\tCPUs\tMemory\tScale\tQuery\tTime')
    scale = min_scale
    while scale <= max_scale:
        generate_all_data(scale)
        copy_to_duckdb(scale)
        copy_to_hyper(scale)
        benchmark_duckdb(scale)
        benchmark_hyper(scale)
        scale = scale * 2

