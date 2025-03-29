import pandas as pd
import os
import uuid

# Get the directory of the current script (environment folder)
script_dir = os.path.dirname(os.path.abspath(__file__))

# Resolve the absolute path correctly
file_path = os.path.abspath(os.path.join(script_dir, "..", "resource", "TestCasesData.xlsx"))
# file_path = fr'C:\Users\Welcome\OneDrive\Máy tính\Demo\environment\merchant_test_data.xlsx'
def get_test_data(sheet_name, tc, key, index=0):
    df = pd.read_excel(file_path, sheet_name=sheet_name,dtype=str)
    df = df[df["Test Case Name"] == tc]
    if isinstance(df, pd.DataFrame):
        try:
            if not df.get(key).empty:
                value = df.get(key).values[index]
                if not pd.isna(value):
                    return str(value)
            return ""
        except AttributeError:
            raise AttributeError(f"df haven't key {key}")
    else:
        if df.get(key):
            return str(df.get(key))
        return ""
    
def uuid_generate():
    return str(uuid.uuid1())
