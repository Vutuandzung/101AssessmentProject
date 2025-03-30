### Project Setup and Execution Guide

1. **Install Dependencies**  
   Before running the script, install all required libraries by executing:  
   pip install -r requirements.txt

2. **Keyword Organization**  
- All keywords are located in the `keywords/common` folder for easy tracking.  
- If the codebase is extended, some keywords may be moved to other folders following the **Page Object Model (POM)** structure.  

3. **Generating Reports**  
- To generate reports in the `./Reports` directory, execute:  
run.bat
4. **Run Load Test**
Please use the command:
locust -f LocustHappyCases.py --web-port 8090
If port 8090 does not work, try changing it to a different port.
