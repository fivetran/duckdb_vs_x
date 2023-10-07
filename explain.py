import duckdb
from tableauhyperapi import HyperProcess, Telemetry, Connection, CreateMode
import sys
import os

cpus = int(sys.argv[1])
memory = cpus * 4
min_scale = cpus * 2
max_scale = min_scale * 2 * 2
memory_per_scale = 4 # 4:1 ratio of memory to the size of data we generate concurrently.
steps = int(cpus * memory_per_scale * max_scale / memory) # memory_per_scale = memory / (max_scale * cpus / steps)
tables = ['nation','region','customer','supplier','lineitem','orders','partsupp','part']

def explain_duckdb(scale):
    if not os.path.exists("plans/duckdb"): os.makedirs("plans/duckdb")
    with duckdb.connect(f"/tmp/benchmark/{scale}/duckdb") as connection:
        for query in range(1, 23):
            text = open(f"queries/{query}.sql").read()
            result = connection.sql(f"explain {text}").fetchone()
            with open(f"plans/duckdb/{query}.sql", "w") as file:
                file.write(result[1]) # type: ignore

def explain_hyper(scale):
    if not os.path.exists("plans/hyper"): os.makedirs("plans/hyper")
    with HyperProcess(telemetry=Telemetry.SEND_USAGE_DATA_TO_TABLEAU) as hyper:
        with Connection(endpoint=hyper.endpoint, database=f"/tmp/benchmark/{scale}/hyper",create_mode=CreateMode.NONE) as connection:
            for query in range(1, 23):
                text = open(f"queries/{query}.sql").read()
                result = connection.execute_query(f"explain {text}")
                with open(f"plans/hyper/{query}.sql", "w") as file:
                    while result.next_row():
                        file.write(result.get_value(0) + "\n")
                result.close()

if __name__ == "__main__":
    explain_duckdb(max_scale)
    explain_hyper(max_scale)

