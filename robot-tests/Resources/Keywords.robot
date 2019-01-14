*** Settings ***
Library      RequestsLibrary
Resource     Variables.robot


*** Keywords ***
Create API session
    Create Session      logstash     ${URL}

Post example 1 test results
    &{headers}=   Create Dictionary   Content-type=application/json
    &{data}=    Create Dictionary  environment=Staging  test_title=Example 1  result=PASS  report=All test steps have passed.
    ${resp}=    Post Request  logstash  /  json=${data}  headers=${headers}
    Should Be Equal As Strings  ${resp.status_code}  200
    Log  ${resp.content}

Post example 2 test results
    &{headers}=   Create Dictionary   Content-type=application/json
    &{data}=    Create Dictionary  environment=Production  test_title=Example 2  result=FAIL  report=Test step 1 failed with an error.
    ${resp}=    Post Request  logstash  /  json=${data}  headers=${headers}
    Should Be Equal As Strings  ${resp.status_code}  200
    Log  ${resp.content}

Post example 3 test results
    &{headers}=   Create Dictionary   Content-type=application/json
    &{data}=    Create Dictionary  environment=Production  test_title=Example 3  result=PASS  report=All test steps have passed.
    ${resp}=    Post Request  logstash  /  json=${data}  headers=${headers}
    Should Be Equal As Strings  ${resp.status_code}  200
    Log  ${resp.content}
