import duckdb
import streamlit as st
import altair as alt

'# TPC-H DuckDB vs Hyper'

"## Per-Query Performance"

cpus = st.radio('CPUs', [8, 16, 32])
scale = st.radio('Scale/CPU', [2, 4, 8])
order = duckdb.sql(f"select Query, avg(Time) from 'results.csv' where System = 'Hyper' group by all order by 2 desc").to_df()["Query"].to_list()
results = duckdb.sql(f"select Query, System, geomean(Time) as Time from 'results.csv' where CPUs = {cpus} and Scale / CPUs = {scale} group by all").to_df()
chart = alt.Chart(results).mark_bar().encode(
    x=alt.X("Query:N").sort(order),
    xOffset="System:N",
    y=alt.Y("Time").scale(type="log"),
    color="System",
)
st.altair_chart(chart, use_container_width=True)

"## Scale vs Time, Constant-CPU"

results = duckdb.sql(f"select System, Scale, CPUs, Scale / CPUs as ScalePerCPU, geomean(Time) as Time from 'results.csv' group by all").to_df()
base = alt.Chart(results).encode(
    x=alt.X("Scale", title="Scale (GB)").scale(type="log", domain=[14, 300]),
    y=alt.Y("Time", title="Geomean Time (s)").scale(type="log", domain=[0.15, 15]),
    color=alt.Color("CPUs:N", title="CPU (vCPU)"),
)
chart = base.mark_line().encode(strokeDash="System") + base.mark_point()
st.altair_chart(chart, use_container_width=True) # type: ignore

"## Scale vs Time, Constant-Scale-per-CPU"

results = duckdb.sql(f"select System, Scale, CPUs, Scale / CPUs as ScalePerCPU, geomean(Time) as Time from 'results.csv' group by all").to_df()
base = alt.Chart(results).encode(
    x=alt.X("Scale", title="Scale (GB)").scale(type="log", domain=[14, 300]),
    y=alt.Y("Time", title="Geomean Time (s)").scale(type="log", domain=[0.15, 15]),
    color=alt.Color("ScalePerCPU:N", title="Scale/CPU (GB / vCPU)"),
)
chart = base.mark_line().encode(strokeDash="System") + base.mark_point()
st.altair_chart(chart, use_container_width=True) # type: ignore