from sqlalchemy import create_engine,text

engine = create_engine(
    "mysql+pymysql://root:Puneeth%4016@localhost/international_debt_analysis"
)

with engine.connect() as conn:

    conn.execute(text("""
    
    CREATE TABLE IF NOT EXISTS countries(
    
        country_code VARCHAR(10) PRIMARY KEY,
        
        country_name VARCHAR(150),
        
        income_group VARCHAR(100),
        
        region VARCHAR(100),
        
        lending_category VARCHAR(100),
        
        is_hipc VARCHAR(20)
        
    )
    
    """))

    conn.execute(text("""
    
    CREATE TABLE IF NOT EXISTS indicators(
    
        series_code VARCHAR(50) PRIMARY KEY,
        
        indicator_name TEXT
        
    )
    
    """))

    conn.execute(text("""
    
    CREATE TABLE IF NOT EXISTS debt_data(
    
        country_code VARCHAR(10),
        
        series_code VARCHAR(50),
        
        year INT,
        
        value DOUBLE,
        
        PRIMARY KEY(
            country_code,
            series_code,
            year
        ),
        
        FOREIGN KEY(country_code)
        REFERENCES countries(country_code),
        
        FOREIGN KEY(series_code)
        REFERENCES indicators(series_code)
        
    )
    
    """))

    conn.commit()

print("Tables Created Successfully")