# pcp_easy
`pcp_easy` provides a simple Ruby API to query metrics from a remote [Performance Co-Pilot] \(PCP\) daemon.
## Install
Written as a native extension, it requires PCP development headers to be present on the system.
```sh
gem install pcp_easy
```

## Usage
The API is still in flux and is subject to change until a stable (1.0.0) version is released.
```ruby
require 'pcp_easy'

# Connect to a remote agent
agent = PCPEasy::Agent.new('localhost')

# Metrics that have no instances return a single metric
metric = agent.metric('disk.all.read')
puts metric.inspect
#<PCPEasy::Metric:0x00560b04bd5050 @name="disk.all.read", @value=116044, @instance=nil, @semantics=:counter>

# Metrics that have instances return an array of metrics
metrics = agent.metric('disk.partitions.read')
puts metrics.inspect
#[#<PCPEasy::Metric:0x00560b04bd4c40 @name="disk.partitions.read", @value=177, @instance="sda1", @semantics=:counter>,
#<PCPEasy::Metric:0x00560b04bd4ab0 @name="disk.partitions.read", @value=115805, @instance="sda5", @semantics=:counter>]
```

   [performance co-pilot]: <http://pcp.io/>