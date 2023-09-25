import streamlit
import duckdb

"# DuckDB vs Database X"

query = """
select *, ceil(cast(Scale as float) / vCPU) as ScalePerCpu 
from 'results.csv' 
where Configuration <> 'M1 Pro'
and Version <> '0.7.1'
and Version <> 'nightly'
"""
duckdb.sql(query).show()
results = duckdb.sql(query).to_df()
color = streamlit.radio("Connect Lines By", ["vCPU", "ScalePerCpu"])
spec = {
    "layer": [
        {
            "mark": {"type": "line", "interpolate": "natural"},
            "encoding": {
                "strokeDash": {
                    "field": "System",
                    "type": "nominal",
                    "sort": "descending",
                    "title": "SYSTEM"
                }
            }
        },
        {"mark": {"type": "point", "filled": True, "size": 150}}
    ],
    "encoding": {
        "x": {
            "field": "Scale",
            "type": "quantitative",
            "scale": {"type": "log", "domain": [50, 1100]},
            "title": "SCALE (GB)"
        },
        "y": {
            "field": "Time",
            "type": "quantitative",
            "scale": {"type": "log", "domain": [0.2, 20]},
            "title": "GEOMEAN EXECUTION TIME (s)"
        },
        "color": {"field": color, "type": "nominal"},
        "tooltip": [
            {"field": "System", "type": "nominal"},
            {"field": "Configuration", "type": "nominal"},
            {"field": "Scale", "type": "quantitative"},
            {"field": "vCPU", "type": "quantitative"},
            {"field": "Time", "type": "quantitative"}
        ]
    },
    "height": 500
}

streamlit.vega_lite_chart(results, spec, True)
