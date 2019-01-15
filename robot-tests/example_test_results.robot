*** Settings ***
Documentation  Creation of example test reports to populate via
...            logstash in Kibana.

Resource  Resources/Keywords.robot

Suite Setup  Create API session

*** Test Cases ***
Example 1
    Post example 1 test results

Example 2
    Post example 2 test results

Example 3
    Post example 3 test results
