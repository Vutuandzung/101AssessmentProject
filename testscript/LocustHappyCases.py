from locust import HttpUser, task, between
import uuid
import json
import  requests
import os
import pandas as pd

script_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.abspath(os.path.join(script_dir, "..", "resource", "TestCasesData.xlsx"))
class MerchantUser(HttpUser):
    wait_time = between(1, 3)
    host = "https://api-101digital-sandbox.101digital.io/merchant-service/1.0.0"
    
    def on_start(self):
        """Runs at the start of each simulated user's session."""
        self.id_token = self.get_login_token()
        print(self.id_token)
    
    def get_login_token(self):
        """Simulate login and return an authentication token."""
        response = self.client.post("https://api-101digital-sandbox.101digital.io/identity-service/1.0.0/token", json={"clientId": "767663206867-i67g665la5ct6ama7hveoddmitkhfjb3.apps.googleusercontent.com", "redirectUri": "https://admin-101digital-sandbox.101digital.io","grantType": "refresh_token", "refreshToken": "1//0gOuTF8aoLHbDCgYIARAAGBASNwF-L9IrAoE4zBXxYkQOH3unchCu4KFLMPBObkALhPIi7YiIiW6RV_T92L4Xv3-xzNha5MMoVNw"})
        return response.json().get("id_token")
    
    def get_test_data(self,sheet_name, tc, key, index=0):
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
    
    @task
    def create_merchant(self):
        """Create a merchant with valid data."""
        merchant_id = str(uuid.uuid4())
        payload = self.get_test_data("MerchantData","Create Merchant - Valid Data","Request Body")
        payload = json.loads(payload)["merchantId"]=merchant_id
        payload = json.dumps(payload, indent=4)
        headers = {"Authorization": f"Bearer {self.id_token}"}
        self.client.post("/merchants", json=payload, headers=headers)
    
    @task
    def retrieve_merchant(self):
        """Retrieve an existing merchant."""
        merchant_id = "95cc60f8-0ef6-499b-9767-503152242eab"
        headers = {"Authorization": f"Bearer {self.id_token}"}
        self.client.get(f"/merchants/{merchant_id}", headers=headers)
    
    @task
    def retrieve_all_merchants(self):
        """Retrieve all merchants without query parameters."""
        headers = {"Authorization": f"Bearer {self.id_token}"}
        self.client.get("/merchants", headers=headers)
    
    @task
    def update_merchant(self):
        """Update a merchant’s invoicePrefix and loyaltyEligible."""
        merchant_id = "95cc60f8-0ef6-499b-9767-503152242eab"
        # payload = {"baseCurrency": "GBP","dueAfter": 30,"invoicePrefix": "INVxxxxxx","nextInvoiceNumber": 1,"mcc": "80-01-01","mccName": "SHOPPING & RETAIL","loyaltyEligible": True}
        payload = self.get_test_data("MerchantData","Update Merchant - Valid Data","Request Body")
        payload = json.loads(payload)
        headers = {"Authorization": f"Bearer {self.id_token}"}
        self.client.put(f"/merchants/{merchant_id}", json=payload, headers=headers)
