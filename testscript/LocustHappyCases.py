from locust import HttpUser, task, between
import uuid
import json
import  requests

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
    
    @task
    def create_merchant(self):
        """Create a merchant with valid data."""
        merchant_id = str(uuid.uuid4())
        payload = {"merchantId": merchant_id, "baseCurrency": "GBP", "invoicePrefix": "INVxxxxxx", "dueAfter": 30, "nextInvoiceNumber": 1, "mcc": "80-01-01", "mccName": "SHOPPING & RETAIL", "loyaltyEligible": True, "category": {"categoryName": "Retail", "categoryCode": "RETAIL", "riskLevel": "LOW", "description": "Retail category for consumer goods."}}
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
        payload = {"baseCurrency": "GBP","dueAfter": 30,"invoicePrefix": "INVxxxxxx","nextInvoiceNumber": 1,"mcc": "80-01-01","mccName": "SHOPPING & RETAIL","loyaltyEligible": True}
        headers = {"Authorization": f"Bearer {self.id_token}"}
        self.client.put(f"/merchants/{merchant_id}", json=payload, headers=headers)
