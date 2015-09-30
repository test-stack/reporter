# Reporter
Logging results of tests and load server with Selenium environment based on Docker.

## How to run
More information in [test-stack-docker](https://github.com/test-stack/docker#elasticsearch--kibana)

## Configuration Harness
You must add to `./config.cson` `ELASTICSEARCH: "IP_OF_ELASTICSEARCH:PORT"`

And run your [Harness](https://github.com/test-stack/harness#run) with `-R elastic` option

# Collectd
[Collectd](https://collectd.org/) - The system statistics collection daemon

## Collectd instalation
```
sudo apt-get update
sudo apt-get install collectd collectd-utils
```
## Collectd configuration
Edit your [`/etc/collectd/collectd.conf`](https://github.com/test-stack/reporter/tree/master/etc/collectd/collectd.conf)

Apply changes `sudo service collectd restart`

# Logstash

## Logstash configuration
Create [`~/logstashConf/collectd.conf`](https://github.com/test-stack/reporter/tree/master/logstashConf/collectd.conf)

## Run Logstash
`docker run -d -v /local/logstashConfig/directory/:/conf --name logstash -p 25826:25826/udp itzg/logstash:latest`
