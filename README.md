# iPerf3 Docker Network Performance Testing

A Docker-based network performance testing tool using iPerf3 for bandwidth, latency, and throughput analysis in containerized environments.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Performance Metrics](#performance-metrics)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)
- [Use Cases](#use-cases)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

This project provides a containerized iPerf3 network performance testing solution designed for:

- **Network Bandwidth Testing**: Measure maximum achievable bandwidth
- **Throughput Analysis**: Analyze network performance under various conditions
- **Latency Measurement**: Assess network delay and jitter
- **Automated Testing**: Scripted execution for consistent and repeatable tests
- **Container Networking**: Test Docker container network performance
- **CI/CD Integration**: Network performance validation in deployment pipelines

The solution uses Docker containers to ensure consistent testing environments and easy deployment across different systems.

## ✨ Features

### Core Capabilities
- **TCP Bandwidth Testing**: Maximum throughput measurement
- **UDP Performance Testing**: Packet loss and jitter analysis
- **Bi-directional Testing**: Simultaneous upload/download testing
- **Multi-stream Testing**: Parallel connection performance analysis
- **Automated Execution**: One-command test execution with logging
- **Containerized Environment**: Consistent testing across different systems

### Advanced Features
- **Custom Test Duration**: Configurable test periods
- **Detailed Logging**: Comprehensive test result documentation
- **Docker Compose Integration**: Easy multi-container orchestration
- **Performance Baseline**: Establish network performance benchmarks
- **Result Analysis**: Structured output for performance analysis

## 🛠 Technologies Used

### Core Technologies
- **iPerf3**: Network performance measurement tool
- **Docker**: Containerization platform
- **Docker Compose**: Multi-container application orchestration
- **Bash Scripting**: Automated test execution

### Container Images
- **networkstatic/iperf3**: Official iPerf3 Docker image
- **Custom Configuration**: Optimized container settings for testing

### Networking
- **Docker Networks**: Container-to-container communication
- **TCP/UDP Protocols**: Comprehensive protocol testing
- **Port Management**: Controlled network port allocation

## 🚀 Getting Started

### Prerequisites

- Docker Engine 20.10+
- Docker Compose 2.0+
- Bash shell (Linux/macOS) or WSL (Windows)
- Basic understanding of network performance concepts

### Installation

1. **Clone or download the project**:
   ```bash
   # If part of larger repository
   git clone https://github.com/DEANN19980902/docker-net-test.git
   cd docker-net-test/iPerf3
   
   # Or download just the iPerf3 files
   ```

2. **Verify Docker installation**:
   ```bash
   docker --version
   docker-compose --version
   ```

3. **Make the test script executable**:
   ```bash
   chmod +x run_docker_net_test.sh
   ```

### Quick Start

1. **Run the automated test**:
   ```bash
   ./run_docker_net_test.sh
   ```

2. **View results**:
   ```bash
   cat docker_net_test.log
   ```

## 📂 Project Structure

```
iPerf3/
├── docker-compose.yaml          # Container orchestration configuration
├── run_docker_net_test.sh       # Automated test execution script
├── docker_net_test.log          # Test results and performance data
├── .git/                        # Git repository for version control
└── README.md                    # This documentation
```

## 📋 Requirements

### System Requirements
- **OS**: Linux (Ubuntu 20.04+), macOS, or Windows with WSL2
- **Memory**: 2GB+ RAM for container operations
- **Storage**: 5GB+ free space for container images
- **Network**: Active network interface for testing

### Docker Requirements
- Docker Engine 20.10+
- Docker Compose 2.0+
- Container networking capabilities
- Access to Docker Hub for image downloads

## 🔧 Usage

### Automated Testing

The simplest way to run performance tests:

```bash
./run_docker_net_test.sh
```

This script will:
1. Start the iPerf3 server container
2. Start the iPerf3 client container
3. Execute the performance test
4. Log results to `docker_net_test.log`
5. Clean up containers

### Manual Testing

For more control over the testing process:

1. **Start the containers**:
   ```bash
   docker-compose up -d
   ```

2. **Check container status**:
   ```bash
   docker-compose ps
   ```

3. **View real-time logs**:
   ```bash
   docker-compose logs -f
   ```

4. **Run custom iPerf3 tests**:
   ```bash
   # Basic TCP test
   docker exec iperf3-client iperf3 -c iperf3-server -t 30
   
   # UDP test with bandwidth limit
   docker exec iperf3-client iperf3 -c iperf3-server -u -b 100M -t 10
   
   # Bi-directional test
   docker exec iperf3-client iperf3 -c iperf3-server --bidir -t 15
   ```

5. **Stop containers**:
   ```bash
   docker-compose down
   ```

### Advanced Testing Scenarios

#### Long Duration Test
```bash
docker exec iperf3-client iperf3 -c iperf3-server -t 300  # 5 minutes
```

#### Multi-stream Test
```bash
docker exec iperf3-client iperf3 -c iperf3-server -P 4 -t 60  # 4 parallel streams
```

#### UDP Performance with Packet Loss Analysis
```bash
docker exec iperf3-client iperf3 -c iperf3-server -u -b 1G -t 30
```

#### JSON Output for Parsing
```bash
docker exec iperf3-client iperf3 -c iperf3-server -J -t 10
```

## 📊 Performance Metrics

### TCP Measurements
- **Bandwidth**: Maximum achievable throughput (Gbits/sec)
- **Transfer**: Total data transferred (GBytes)
- **Retransmissions**: Number of TCP retransmissions
- **Congestion Window**: TCP congestion control information

### UDP Measurements
- **Bandwidth**: Configured and achieved bandwidth
- **Jitter**: Packet delay variation (milliseconds)
- **Lost/Total**: Packet loss statistics
- **Latency**: Round-trip time measurements

### Sample Output
```
Connecting to host iperf3-server, port 5201
[  5] local 172.18.0.3 port 56832 connected to 172.18.0.2 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  1.09 GBytes  9.35 Gbits/sec
[  5]   1.00-2.00   sec  1.10 GBytes  9.41 Gbits/sec
[  5]   2.00-3.00   sec  1.09 GBytes  9.38 Gbits/sec
...
[  5]   0.00-10.00  sec  10.9 GBytes  9.39 Gbits/sec                  sender
[  5]   0.00-10.04  sec  10.9 GBytes  9.36 Gbits/sec                  receiver
```

## ⚙️ Configuration

### Docker Compose Configuration

```yaml
version: '3.8'
services:
  iperf3-server:
    image: networkstatic/iperf3
    command: -s
    ports:
      - "5201:5201"
    networks:
      - iperf-network

  iperf3-client:
    image: networkstatic/iperf3
    command: -c iperf3-server -t 10
    depends_on:
      - iperf3-server
    networks:
      - iperf-network

networks:
  iperf-network:
    driver: bridge
```

### Custom Test Script

The `run_docker_net_test.sh` script can be modified for specific testing needs:

```bash
#!/bin/bash
# Custom test parameters
TEST_DURATION=30
PARALLEL_STREAMS=1
PROTOCOL="tcp"  # or "udp"

# Execute test with custom parameters
docker-compose up -d
sleep 5
docker exec iperf3-client iperf3 -c iperf3-server -t $TEST_DURATION -P $PARALLEL_STREAMS
docker-compose down
```

## 🐛 Troubleshooting

### Common Issues

#### Container Startup Problems
```bash
# Check Docker daemon status
docker info

# Verify image availability
docker images | grep iperf3

# Check container logs
docker-compose logs iperf3-server
docker-compose logs iperf3-client
```

#### Network Connectivity Issues
```bash
# Test container network connectivity
docker exec iperf3-client ping iperf3-server

# Check Docker networks
docker network ls
docker network inspect iperf3_default
```

#### Port Binding Issues
```bash
# Check if port 5201 is already in use
netstat -tlnp | grep 5201
lsof -i :5201

# Use alternative port in docker-compose.yaml
ports:
  - "5202:5201"
```

#### Performance Issues
```bash
# Check system resources
docker stats

# Monitor network interface
iftop -i docker0
```

### Error Solutions

| Error | Solution |
|-------|----------|
| Port already in use | Change port mapping in docker-compose.yaml |
| Container won't start | Check Docker daemon and image availability |
| No network connectivity | Verify Docker network configuration |
| Low performance results | Check system resources and network interface |

## 🎯 Use Cases

### Development and Testing
- **Application Performance**: Test network performance of containerized applications
- **Infrastructure Validation**: Verify network infrastructure capacity
- **Regression Testing**: Ensure network performance doesn't degrade over time

### Network Engineering
- **Capacity Planning**: Determine network bandwidth requirements
- **Performance Baseline**: Establish network performance benchmarks
- **Troubleshooting**: Diagnose network performance issues

### DevOps and CI/CD
- **Deployment Validation**: Verify network performance in new environments
- **Automated Testing**: Include network performance tests in CI/CD pipelines
- **Environment Comparison**: Compare network performance across environments

### Education and Training
- **Network Concepts**: Hands-on network performance measurement
- **Container Networking**: Understanding Docker network capabilities
- **Performance Analysis**: Learning to interpret network performance metrics

## 📈 Best Practices

### Testing Methodology
1. **Consistent Environment**: Use the same container configuration for all tests
2. **Multiple Runs**: Execute multiple test runs for statistical accuracy
3. **Baseline Establishment**: Create performance baselines for comparison
4. **Documentation**: Record test conditions and environmental factors

### Performance Optimization
1. **Container Resources**: Allocate sufficient CPU and memory to containers
2. **Network Interface**: Use high-performance network interfaces
3. **System Load**: Minimize background processes during testing
4. **Test Duration**: Use appropriate test durations for accurate results

## 🤝 Contributing

Contributions to improve this iPerf3 testing setup are welcome:

1. **Bug Reports**: Report issues with scripts or configurations
2. **Feature Requests**: Suggest improvements or new testing scenarios
3. **Documentation**: Improve setup instructions and usage guides
4. **Test Scripts**: Add new testing configurations or automation

## 📄 License

This project is created for network performance testing and educational purposes. Feel free to use and modify for your network testing needs.

## 📞 Contact

**Author**: Yi Chiun Chang  
**Project**: iPerf3 Docker Network Performance Testing  
**Use Case**: Network Performance Analysis and Bandwidth Testing

---

⭐ If you found this network performance testing tool helpful, please consider giving it a star!

## 🔗 Additional Resources

### iPerf3 Documentation
- [iPerf3 Official Documentation](https://iperf.fr/iperf-doc.php) - Complete iPerf3 guide
- [iPerf3 GitHub Repository](https://github.com/esnet/iperf) - Source code and issues
- [Network Performance Testing Guide](https://fasterdata.es.net/performance-testing/network-troubleshooting-tools/iperf/) - ESnet guide

### Docker Networking
- [Docker Networking Overview](https://docs.docker.com/network/) - Official Docker networking guide
- [Docker Compose Networking](https://docs.docker.com/compose/networking/) - Multi-container networking
- [Container Network Troubleshooting](https://docs.docker.com/network/troubleshooting/) - Debugging guide

### Network Performance Analysis
- [Network Performance Measurement](https://tools.ietf.org/html/rfc2544) - RFC 2544 benchmarking methodology
- [TCP Performance Analysis](https://www.cisco.com/c/en/us/support/docs/ip/transmission-control-protocol-tcp/10893-tcp-perf-tuning.html) - TCP optimization guide
- [Bandwidth vs Throughput](https://www.keycdn.com/support/bandwidth-vs-throughput) - Understanding network metrics 