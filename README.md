# reporter
Creating a report with the results

## How to run
More information in [test-stack-docker](https://github.com/test-stack/docker#elasticsearch--kibana)

## Configuration
You must add to `./config.cson` `ELASTICSEARCH: "IP_OF_ELASTICSEARCH:PORT"`

And run your [Harness](https://github.com/test-stack/harness#run) with `-R elastic` option