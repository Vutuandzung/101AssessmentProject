*** Settings ***
Resource    ../environment/library.robot
Suite Setup    Get Login Token    
Test Setup    Get Data On Excel File And Start Test
Suite Teardown   Delete All Sessions 

*** Test Cases ***
Create Merchant - Valid Data
    [Documentation]    Verify merchant creation with valid data
    Given a new merchant ID is generated
    And the request body is updated with the new merchant ID
    When the merchant is created using a valid session
    Then the response code should be as expected
    And the response body should contain the expected message

Create Merchant - Invalid Token
    [Documentation]    Verify merchant creation with an invalid token
    Given a new merchant ID is generated
    And the request body is updated with the new merchant ID
    When the merchant is created using an invalid session
    Then the response code should be as expected
    And the response body should contain the expected message

Create Merchant - Empty baseCurrency
    [Documentation]    Verify merchant creation when baseCurrency is empty
    Given a new merchant ID is generated
    And the request body is updated with the new merchant ID
    When the merchant is created with an empty baseCurrency
    Then the response code should be as expected
    And the response body should contain the expected message
    
*** Keywords ***
Given a new merchant ID is generated
    ${uuid}    Uuid Generate
    Set Test Variable    ${uuid}

And the request body is updated with the new merchant ID
    ${decoded_json}    Update Merchant ID    ${reqbody}    ${uuid}
    Set Test Variable    ${decoded_json}

When the merchant is created using a valid session
    Create Merchant API    ${ApiSession}    ${decoded_json}    ${IdToken}    ${rescode}    ${resbody}

When the merchant is created using an invalid session
    Create Merchant API    ${InvalidApiSession}    ${decoded_json}    ${InvalidIdToken}    ${rescode}    ${resbody}

When the merchant is created with an empty baseCurrency
    ${decoded_json}[baseCurrency]    Set Variable    ${EMPTY}
    Create Merchant API    ${ApiSession}    ${decoded_json}    ${IdToken}    ${rescode}    ${resbody}

Then the response code should be as expected
    Should Be Equal As Strings    ${ActualRescode}    ${Rescode}

And the response body should contain the expected message
    Should Contain    ${ActualResbody}    ${resbody}
