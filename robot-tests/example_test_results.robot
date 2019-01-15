*** Settings ***
Documentation  Creation of example test reports to populate via
...            logstash in Kibana.

Resource  Resources/Keywords.robot

Suite Setup  Create API session

*** Test Cases ***
Example 1
    Post example test results Staging passed

Example 2
    Post example test results Production failed

Example 3
    Post example test results Production passed
