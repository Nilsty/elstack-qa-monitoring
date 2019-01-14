# Monitor your automation test results with logstash, elastic search and kibana

## Intro
As QA you are always required to provide the best possible transparency for your test automation. To always know what was tested when and with what result will benefit your stakeholders as well as your team members.
This demo project should show how the elastic stack can be used as a monitoring tool for automation test results.

## Requirements

You need to have [docker](https://www.docker.com/) installed.

To later send seed demo data as test results you can either use
* [Postman](https://www.getpostman.com/),
* [Newman](https://github.com/postmanlabs/newman#getting-started),
* [cURL](https://curl.haxx.se/)
* or [Robotframework](https://robotframework.org/) with [RequestsLibrary](https://github.com/bulkan/robotframework-requests)

## How to run it

git clone this repository

Build and run the docker container
```
docker build -t el-qa-mon .
docker run -d --name qa-mon-elastic-stack -p 80:80 -p 8060:8060 -p 9200:9200 el-qa-mon
```
This docker container will bring up Logstash, Elastic Search and Kibana with a default configuration. I used [this docker image](https://hub.docker.com/r/blacktop/elastic-stack/) as a base and only added the [Logstash http-input-plugin](https://www.elastic.co/blog/introducing-logstash-input-http-plugin).

## Explore Kibana and Logstash

In your browser go to http://localhost:80 to see the Kibana frontend. (Not much to see yet without data)

In your browser go to http://localhost:8060 to check if the logstash http input plugin is listening (it takes 2 mins to come up after the docker container has been started)
Once it's running it'll show "ok".

## Send seed data - demo test reports
* Either open with Postman the collection QA-Monitoring-demo-seed-data.postman_collection.json and execute it.
* or use Newman
```
newman run QA-Monitoring-demo-seed-data.postman_collection.json
```
* or send the following cURLs
```
curl -X POST \
  http://localhost:8060/ \
  -H 'Content-Type: application/json' \
  -d '{
	"environment" : "Staging",
	"test_title" : "the-test-test",
	"result" : "PASS",
	"report" : "All test steps have passed."

}'
curl -X POST \
  http://localhost:8060/ \
  -H 'Content-Type: application/json' \
  -d '{
	"environment" : "Production",
	"test_title" : "the-test-test",
	"result" : "PASS",
	"report" : "All test steps have passed."

}'
curl -X POST \
  http://localhost:8060/ \
  -H 'Content-Type: application/json' \
  -d '{
	"environment" : "Staging",
	"test_title" : "the-test-test",
	"result" : "FAIL",
	"report" : "Test failed on step 23\nCould not find UI object."

}'
```
* or use these robot framework tests to populate some example test results
`robot robot-tests`

## Find data in Kibana

In your browser go to http://localhost:80 to see the Kibana frontend.

1. Create an index pattern "*"
![index pattern](/images/define-index-pattern.png)

2. Index creation step 2 - Time filter = @timestamp
![index pattern](/images/configure-setting.png)

3. Go to discover and select the fields you are interested in to have a less convoluted view.
![index pattern](/images/selected-fields.png)

4. Build some nice visualisations in the Visualize section.
I highly recommend using a [tutorial](https://www.digitalocean.com/community/tutorials/how-to-use-kibana-dashboards-and-visualizations) to get into this.
