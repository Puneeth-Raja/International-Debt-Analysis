import pandas as pd
from sqlalchemy import create_engine

engine = create_engine(
    "mysql+pymysql://root:Puneeth%4016@localhost/international_debt_analysis"
)

countries = pd.read_csv("../output/Cleaned_Data/Country_Details.xls")

indicators = pd.read_csv("../output/Cleaned_Data/Indicator_Details.xls")

debt = pd.read_csv("../output/Cleaned_Data/Debt_Data.xls")


countries = countries.rename(columns={
    'Code':'country_code',
    'Country Name':'country_name',
    'Income Group':'income_group',
    'Region':'region',
    'Lending category':'lending_category',
    'Is_HIPC':'is_hipc'
}) 


indicators = indicators.rename(columns={
    'Series Code':'series_code',
    'Indicator Name':'indicator_name'
})


debt = debt.rename(columns={
    'Country Code':'country_code',
    'Series Code':'series_code',
    'Year':'year',
    'Value':'value'
})


countries.to_sql(
    "countries",
    con=engine,
    if_exists="append",
    index=False
)

print("Countries Loaded")


indicators.to_sql(
    "indicators",
    con=engine,
    if_exists="append",
    index=False
)

print("Indicators Loaded")


debt.to_sql(
    "debt_data",
    con=engine,
    if_exists="append",
    index=False
)

print("Debt Data Loaded")