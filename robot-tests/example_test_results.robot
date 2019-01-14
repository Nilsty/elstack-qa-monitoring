*** Settings ***
Documentation  Example of an API test using the Requests Library
...            call the API.
...            The first test case valides the response code.
...            The second test case valides the respons time.
...            The third test cases iterates over a json response
...            to filter by a partial string match.

Resource  Resources/Keywords.robot

Suite Setup  Create API session

*** Test Cases ***
Example 1
    Post example 1 test results

Example 2
    Post example 2 test results

Example 3
    Post example 3 test results
