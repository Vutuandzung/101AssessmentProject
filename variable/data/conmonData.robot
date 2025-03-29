*** Settings ***
Resource    ../../environment/library.robot
*** Variables ***
############################################################# Login ########################################################################
${BaseUrl}       https://api-101digital-sandbox.101digital.io/merchant-service/1.0.0/merchants
${ApiSession}               APISession
${InvalidApiSession}       InvalidAPISession
${LoginClientId}            767663206867-i67g665la5ct6ama7hveoddmitkhfjb3.apps.googleusercontent.com
${LoginRedirectUri}            https://admin-101digital-sandbox.101digital.io
${LoginRefreshToken}            1//0gOuTF8aoLHbDCgYIARAAGBASNwF-L9IrAoE4zBXxYkQOH3unchCu4KFLMPBObkALhPIi7YiIiW6RV_T92L4Xv3-xzNha5MMoVNw
${LoginUrl}                https://api-101digital-sandbox.101digital.io/identity-service/1.0.0/token
${IdToken}        ${EMPTY}
############################################################# Input File ########################################################################
${Reqbody}        ${EMPTY}
${Rescode}        ${EMPTY}
${Resbody}        ${EMPTY}
${MerchantDataSheet}                MerchantData
${RequestBodyColumn}                       Request Body
${ResponseCodeColumn}                       Response Code
${ResponseBodyColumn}                       Response Body
${ParamTypeColumn}                        Param Type
############################################################# Other ########################################################################
${InvalidIdToken}            test123
${MerchantId}    95cc60f8-0ef6-499b-9767-503152242eab
${InvalidMerchantId}    test123
${ValidmCC}    SHOPPING%20%26%20RETAIL
${ActualResbody}    ${EMPTY}
${ActualRescode}    ${EMPTY}