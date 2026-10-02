# IPL-Data-Analysis: Python, SQL and Power BI

This project contains analysis of IPL Data from season 2008 - 2019 using python and MySQL and visualization by creating dashboard using PowerBI.

Together the three parts performs analysis about teams, batters, bowlers, venues and match outcomes, and show how the same analysisc can be done in SQL, and in a BI tool.

## Dataset
Two CSV files, one row per match and one row per ball.

| File | Rows | Columns | Grain |
|---|---|---|---|
| `matches.csv` | 756 | 18 | One row per match (`id` is unique) |
| `deliveries.csv` | 179,078 | 21 | One row per delivery (`match_id` links to `matches.id`) |

Dataset link: 
- **Kaggle dataset:** https://www.kaggle.com/datasets/nowke9/ipldata
- **GitHub fallback repository containing both IPL CSV files:** https://github.com/Martin-data-ds/IPL_match_prediction


## Repository structure

```

ipl-data-analysis/
├── notebook/
│   └── IPL_Analysis_Pandas_Matplotlib_Seaborn  # 150 Pandas + 50 visualization questions
│   └──dataset/
│    ├── matches.csv
│    └── deliveries.csv
├── sql/
│   └── IPL SQL ANALYSIS.pdf                     # query + output screenshots
├── powerbi/
│   ├── IPL_Dashboard.pbix                       # Power BI Dashboard
└── README.md