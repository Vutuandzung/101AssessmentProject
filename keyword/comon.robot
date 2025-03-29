*** Settings ***
Resource    ../environment/library.robot
Library    DateTime
Library    Telnet

*** Keywords ***
Get Login Token
    [Documentation]
    ...    [Description]    Return login token for api testing
    ...    [Author]         John.vu
    ...    [Date]           2025.03.29
    Create Session    ${ApiSession}    ${BaseUrl}
    Create Session    ${InvalidApiSession}    ${BaseUrl}
    ${headers}=    Create Dictionary    Content-Type=application/json    User-Agent=Python-urllib/3.8
    ${body}=    Create Dictionary    clientId=${LoginClientId}    redirectUri=${LoginRedirectUri}    grantType=refresh_token    refreshToken=${LoginRefreshToken}
    ${response}=    POST On Session    ${ApiSession}    ${LoginUrl}    json=${body}    headers=${headers}    expected_status=200
    Should Be Equal As Strings    ${response.status_code}    ${200}
    ${id_token}    Get From Dictionary    ${response.json()}    id_token
    Set Suite Variable    ${IdToken}

Update Merchant ID
    [Arguments]    ${body}    ${uuid}
    ${decoded_json}=    Set To Dictionary    ${body}    merchantId=${uuid}
    [Return]    ${decoded_json}

Create Merchant API
    [Arguments]    ${session}    ${body}    ${token}    ${expected_status}    ${expected_message}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}  
    ${response}=    POST On Session    ${session}    ${BaseUrl}     json=${body}    headers=${headers}    expected_status=${expected_status}
    Should Contain    ${response.text}    ${expected_message}
    Set Test Variable    ${ActualResbody}    ${response.text}
    Set Test Variable    ${ActualRescode}    ${response.status_code}
    
Get Merchant API
    [Arguments]    ${session}    ${merchantId}    ${token}    ${expected_status}    ${expected_message}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}   
    ${response}=    GET On Session    ${session}    ${BaseUrl}/${MerchantId}    headers=${headers}    expected_status=${expected_status}
    Should Contain    ${response.text}    ${expected_message}

Search Merchants API
    [Arguments]    ${session}    ${query_params}    ${token}    ${expected_status}    ${expected_message}    ${param_name} 
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    ${session}    url=${BaseUrl}?${param_name}=${query_params}    headers=${headers}    expected_status=${expected_status}
    Should Contain    ${response.text}    ${expected_message}

Update Merchant API
    [Arguments]    ${session}    ${merchantId}    ${body}    ${token}    ${expected_status}    ${expected_message}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}   
    ${response}=    PATCH On Session    ${session}    ${BaseUrl}/${MerchantId}    json=${body}    headers=${headers}    expected_status=${expected_status}
    Should Contain    ${response.text}    ${expected_message}

Get Data On Excel File And Start Test
    [Documentation]
    ...    [Description]    Get data on excel file and start test
    ...    [Author]         John.vu
    ...    [Date]           2025.09.30
    ${reqbody}    Get Test Data    ${MerchantDataSheet}    ${TEST_NAME}    ${RequestBodyColumn}
    ${rescode}    Get Test Data    ${MerchantDataSheet}    ${TEST_NAME}    ${ResponseCodeColumn}
    ${resbody}     Get Test Data    ${MerchantDataSheet}    ${TEST_NAME}    ${ResponseBodyColumn}
    ${paramtype}     Get Test Data    ${MerchantDataSheet}    ${TEST_NAME}    ${ParamTypeColumn}
    IF  '${Reqbody}' != 'None'
         ${reqbody}=    Evaluate    json.loads(r'''${Reqbody}''')    modules=json
    END
    Set Test Variable    ${Reqbody}
    Set Test Variable    ${Rescode}
    Set Test Variable    ${Resbody}
    Set Test Variable    ${paramtype}



    
