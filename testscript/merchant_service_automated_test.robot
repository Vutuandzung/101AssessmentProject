*** Settings ***
Resource    ../environment/library.robot
Suite Setup    Get Login Token    
Test Setup    Get Data On Excel File And Start Test
Suite Teardown   Delete All Sessions 

*** Test Cases ***
Create Merchant - Valid Data
    [Documentation]
    ...    [TC_ID]          TC01
    ...    [Description]    Create a merchant with valid data and a valid access token in the request header 
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    ${uuid}    Uuid Generate
    ${decoded_json}    Update Merchant ID    ${Reqbody}    ${uuid}
    Create Merchant API    ${ApiSession}    ${decoded_json}    ${IdToken}    ${Rescode}    ${Resbody}

Create Merchant - Invalid Token
    [Documentation]
    ...    [TC_ID]          TC02
    ...    [Description]    Create a merchant with valid data and an invalid access token in the request header 
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    ${uuid}    Uuid Generate
    ${decoded_json}    Update Merchant ID    ${Reqbody}    ${uuid}
    Create Merchant API    ${InvalidApiSession}    ${decoded_json}    ${InvalidIdToken}    ${Rescode}    ${Resbody}

Create Merchant - Empty baseCurrency
    [Documentation]
    ...    [TC_ID]          TC03
    ...    [Description]    Create new Merchant using an empty baseCurrency value 
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    ${uuid}    Uuid Generate
    ${decoded_json}    Update Merchant ID    ${Reqbody}    ${uuid}
    Create Merchant API    ${ApiSession}    ${decoded_json}    ${IdToken}    ${Rescode}    ${Resbody}

Retrieve Merchant - Valid ID
    [Documentation]
    ...    [TC_ID]          TC04
    ...    [Description]    Retrieve existing merchant 
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Get Merchant API    ${ApiSession}    ${MerchantId}    ${IdToken}    ${Rescode}    ${Resbody} 

Retrieve Merchant - Invalid Token
    [Documentation]
    ...    [TC_ID]          TC05
    ...    [Description]    Get merchant details with invalid access token in the request header.
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Get Merchant API    ${InvalidApiSession}    ${MerchantId}    ${InvalidIdToken}    ${Rescode}    ${Resbody}

Retrieve Merchant - Invalid ID
    [Documentation]
    ...    [TC_ID]          TC06
    ...    [Description]    Get merchant details using merchantId path parameter value as “test123"
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Get Merchant API    ${ApiSession}    ${InvalidMerchantId}    ${IdToken}    ${Rescode}    ${Resbody}

Retrieve All Merchants - No Query Params
    [Documentation]
    ...    [TC_ID]          TC07
    ...    [Description]    Retrieve all merchants without providing any query parameters
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Search Merchants API    ${ApiSession}    ${EMPTY}    ${IdToken}    ${Rescode}    ${Resbody}    ${EMPTY}

Retrieve All Merchants - Invalid Token
    [Documentation]
    ...    [TC_ID]          TC08
    ...    [Description]    Retrieve all merchants with an invalid access token in the request header.
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Search Merchants API    ${InvalidApiSession}    ${EMPTY}    ${InvalidIdToken}    ${Rescode}    ${Resbody}     ${EMPTY}

Retrieve All Merchants - Valid mccName
    [Documentation]
    ...    [TC_ID]          TC09
    ...    [Description]    Retrieve all merchants using mccName query parameter and with a valid mccNamevalue 
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Search Merchants API    ${ApiSession}    ${ValidmCC}    ${IdToken}    ${Rescode}    ${Resbody}    ${paramtype}

Retrieve All Merchants - Invalid Page Number
    [Documentation]
    ...    [TC_ID]          TC10
    ...    [Description]    Retrieve all merchants using an invalid pageNumber query parameter value “test123” 
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Search Merchants API    ${ApiSession}    ${InvalidMerchantId}    ${IdToken}    ${Rescode}    ${Resbody}    ${paramtype}

Update Merchant - Valid Data
    [Documentation]
    ...    [TC_ID]          TC11
    ...    [Description]    Update a merchant’s invoicePrefix and loyaltyEligible 
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Update Merchant API    ${ApiSession}    ${MerchantId}    ${Reqbody}    ${IdToken}    ${Rescode}    ${Resbody}

Update Merchant - Invalid Token
    [Documentation]
    ...    [TC_ID]          TC12
    ...    [Description]    Update merchant with an invalid access token in the request header 
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Update Merchant API    ${InvalidApiSession}    ${MerchantId}    ${Reqbody}    ${InvalidIdToken}    ${Rescode}    ${Resbody}

Update Merchant - Empty baseCurrency
    [Documentation]
    ...    [TC_ID]          TC13
    ...    [Description]    Update merchant using an empty baseCurrency value 
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Update Merchant API    ${ApiSession}    ${MerchantId}    ${Reqbody}    ${IdToken}    ${Rescode}    ${Resbody}
