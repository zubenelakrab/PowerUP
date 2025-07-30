# 🚇 World 7-1 - Pipe Maze: Networking & Microservices

**"Welcome to the Pipe Maze! Navigate through interconnected tunnels where data flows like water and services communicate through an intricate network of pathways!"**

World 7-1 is the complex Pipe Maze, an underground labyrinth where green pipes connect distant realms and transport systems move data at the speed of thought! This world represents the challenging domain of networking, microservices architecture, and distributed systems communication. Here, understanding the flow of data through pipes is crucial, and one wrong connection can lead you into the wrong service entirely!

## 🎮 World 7-1 Overview

### 🚇 **The Pipe Network**
This subterranean maze embodies the complexity of modern distributed systems:
- **Terrain**: Interconnected pipe networks, data flow tunnels, service communication channels
- **Enemies**: Network Latency Piranha Plants, Service Discovery Lakitus, Circuit Breaker Thwomps
- **Power-Ups**: Load Balancer Warp Pipes, API Gateway Stars, Service Mesh Super Mushrooms
- **Goal**: Successfully navigate to the Distributed Systems Command Center!

```markdown
You are guiding a developer through World 7-1, the intricate Pipe Maze of Networking & Microservices!

**Environment**: Complex, interconnected, requires understanding of system architecture
**Teaching Style**: System-thinking focused, emphasizes communication patterns and reliability
**Tone**: Network engineer sage who sees the big picture of data flow

**World 7-1 Philosophy**:
- In distributed systems, the network is the computer
- Services should be loosely coupled but highly cohesive
- Failure is inevitable - design for resilience, not perfection  
- Observability is your map through the maze
- Communication patterns define your architecture

**Common Pipe Challenges**:
- Service discovery in dynamic environments
- Managing network latency and failures
- Implementing reliable inter-service communication
- Handling data consistency across services
- Monitoring and tracing distributed requests

Remember: In the Pipe Maze, understanding the flow is more important than any individual pipe!
```

## 🎯 World 7-1 Commands

### `/world-7-1-enter [architecture] [communication-pattern]`
Begin your journey through the distributed systems maze with proper networking setup.

**Example Usage**:
```bash
/world-7-1-enter microservices --communication=event-driven --mesh=istio
```

**World 7-1 Response**:
```
🚇 Welcome to World 7-1: The Pipe Maze of Networking & Microservices!

*A vast underground network of glowing pipes extends in all directions*

"Greetings, network navigator! You're about to enter a realm where data flows like rivers and services communicate through an endless maze of connections!" 🌐

🔧 PIPE MAZE ORIENTATION 🔧

🎯 Your Chosen Architecture: Microservices with Event-Driven Communication
⚡ Service Mesh: Istio (intelligent traffic management)
🌊 Data Flow Pattern: Asynchronous messaging with resilience
🗺️ Navigation System: Distributed tracing enabled

🚇 ENTERING THE PIPE NETWORK:

🗺️ **Maze Level Structure**:
  📍 **Pipe Junction 1**: Service Discovery & Registration Hub
  📍 **Tunnel System 2**: Inter-Service Communication Channels
  📍 **Flow Control 3**: Load Balancing & Traffic Management
  📍 **Data Rapids 4**: Event Streaming & Message Queues
  📍 **Command Center 5**: Distributed Systems Coordination

🔧 **Pipe Maze Power-Ups Available**:
  🚇 **Warp Pipe Network**: Instant service-to-service teleportation
  ⭐ **API Gateway Star**: Central entry point with superpowers
  🍄 **Service Mesh Mushroom**: Enhanced inter-service capabilities
  🔥 **Circuit Breaker Fire**: Protection against cascade failures
  ⚡ **Event Storm Lightning**: High-throughput message processing

⚠️ **Network Hazards to Navigate**:
  🌱 **Latency Piranha Plants**: Network delays that bite performance
  ☁️ **Discovery Lakitus**: Services that can't find each other
  🏗️ **Coordination Thwomps**: Distributed consensus challenges
  🌊 **Data Consistency Rapids**: ACID vs eventual consistency trade-offs

```javascript
// 🚇 World 7-1: Microservices Pipe Network Journey
const express = require('express');
const { Kafka } = require('kafkajs');
const consul = require('consul');

class PipeMazeNetworkJourney {
  constructor() {
    this.architecture = 'microservices';
    this.communicationPattern = 'event-driven';
    this.serviceMesh = 'istio';
    this.networkTopology = 'distributed-mesh';
    
    console.log('🚇 Pipe Maze: Beginning microservices network journey!');
  }
  
  async beginNetworkNavigation(config) {
    console.log('🌐 Navigating through the microservices pipe maze...');
    
    const journey = {
      // Junction 1: Service Discovery
      serviceDiscovery: await this.setupServiceDiscoveryHub(config),
      
      // Tunnel 2: Inter-Service Communication
      communicationChannels: await this.establishCommunicationChannels(config),
      
      // Flow Control 3: Load Balancing
      loadBalancing: await this.implementLoadBalancing(config),
      
      // Data Rapids 4: Event Streaming
      eventStreaming: await this.configureEventStreaming(config),
      
      // Command Center 5: Distributed Coordination
      distributedCoordination: await this.buildDistributedCoordination(config)
    };
    
    console.log('🏗️ Pipe maze network infrastructure deployed!');
    return journey;
  }
  
  async setupServiceDiscoveryHub(config) {
    console.log('🔍 Junction 1: Setting up service discovery hub...');
    
    const discoveryHub = {
      // Service registry (Consul-based)
      registry: {
        type: 'consul',
        cluster: 'highly-available-cluster',
        
        // Service registration
        registration: {
          healthChecks: {
            http: '/health',
            interval: '10s',
            timeout: '3s',
            deregisterAfter: '30s'
          },
          
          metadata: {
            version: 'semantic-versioning',
            tags: ['environment', 'version', 'capability'],
            weights: 'load-balancing-weights'
          }
        },
        
        // Service discovery
        discovery: {
          dns: 'consul-dns-interface',
          api: 'consul-rest-api',
          watches: 'real-time-service-changes',
          caching: 'client-side-caching'
        }
      },
      
      // Service mesh integration
      serviceMesh: {
        type: 'istio',
        
        // Automatic service discovery
        serviceEntries: 'automatic-service-entry-creation',
        destinationRules: 'traffic-policy-configuration',
        virtualServices: 'routing-rule-management',
        
        // Sidecar configuration
        sidecarInjection: 'automatic-envoy-injection',
        telemetry: 'distributed-tracing-enabled',
        security: 'mtls-by-default'
      },
      
      // DNS-based discovery
      dns: {
        // Service DNS records
        records: {
          pattern: 'service-name.namespace.cluster.local',
          ttl: '30s',
          loadBalancing: 'round-robin-default'
        },
        
        // External service integration
        external: {
          upstreams: 'external-service-definitions',
          healthChecks: 'upstream-health-monitoring',
          failover: 'multi-region-failover'
        }
      }
    };
    
    // Deploy service registry cluster
    await this.deployConsulCluster(discoveryHub.registry);
    
    // Configure service mesh
    await this.configureIstioServiceMesh(discoveryHub.serviceMesh);
    
    return {
      hub: discoveryHub,
      status: 'DISCOVERY_HUB_ACTIVE',
      services: 'AUTO_DISCOVERED'
    };
  }
  
  async establishCommunicationChannels(config) {
    console.log('📡 Tunnel 2: Establishing inter-service communication channels...');
    
    const communicationChannels = {
      // Synchronous communication
      synchronous: {
        // HTTP/REST APIs
        rest: {
          protocol: 'HTTP/2',
          security: 'mTLS-encrypted',
          serialization: 'JSON-with-schema-validation',
          
          // Client configuration
          clients: {
            timeout: '5s',
            retries: 3,
            backoff: 'exponential-backoff',
            circuitBreaker: 'hystrix-pattern'
          },
          
          // Server configuration
          servers: {
            compression: 'gzip-compression',
            validation: 'request-response-validation',
            rateLimit: 'per-client-rate-limiting',
            monitoring: 'request-metrics-collection'
          }
        },
        
        // gRPC services
        grpc: {
          protocol: 'HTTP/2-based-gRPC',
          serialization: 'protocol-buffers',
          streaming: 'bidirectional-streaming-support',
          
          // Service definitions
          services: [
            {
              name: 'UserService',
              methods: ['GetUser', 'CreateUser', 'UpdateUser'],
              streaming: false
            },
            {
              name: 'NotificationService', 
              methods: ['SendNotification', 'SubscribeToUpdates'],
              streaming: true
            }
          ]
        }
      },
      
      // Asynchronous communication
      asynchronous: {
        // Message queues
        messageQueues: {
          // Apache Kafka
          kafka: {
            cluster: 'kafka-cluster-with-3-brokers',
            topics: [
              {
                name: 'user-events',
                partitions: 12,
                replication: 3,
                cleanup: 'delete-after-7-days'
              },
              {
                name: 'order-events',
                partitions: 24,
                replication: 3,
                cleanup: 'compact-for-state'
              }
            ],
            
            // Producer configuration
            producers: {
              acks: 'all', // Wait for all replicas
              compression: 'snappy',
              batching: 'intelligent-batching',
              idempotence: true
            },
            
            // Consumer configuration
            consumers: {
              groups: 'consumer-group-management',
              offset: 'earliest-on-first-run',
              autoCommit: false, // Manual offset management
              rebalancing: 'cooperative-sticky-assignor'
            }
          },
          
          // Redis Streams
          redis: {
            streams: 'high-throughput-streams',
            consumerGroups: 'parallel-processing',
            persistence: 'append-only-file',
            clustering: 'redis-cluster-mode'
          }
        },
        
        // Event sourcing
        eventSourcing: {
          eventStore: 'append-only-event-log',
          snapshots: 'periodic-state-snapshots',
          projections: 'read-model-projections',
          replay: 'event-replay-capability'
        }
      },
      
      // Service mesh communication
      serviceMesh: {
        // Istio configuration
        istio: {
          // Traffic management
          trafficManagement: {
            virtualServices: await this.createVirtualServices(),
            destinationRules: await this.createDestinationRules(),
            gateways: await this.createServiceGateways()
          },
          
          // Security policies
          security: {
            authorizationPolicies: 'rbac-based-access-control',
            peerAuthentication: 'mtls-enforcement',
            requestAuthentication: 'jwt-token-validation'
          },
          
          // Observability
          observability: {
            telemetry: 'prometheus-metrics-collection',
            tracing: 'jaeger-distributed-tracing',
            logging: 'envoy-access-logs'
          }
        }
      }
    };
    
    // Set up communication infrastructure
    await this.deployCommunicationInfrastructure(communicationChannels);
    
    return {
      channels: communicationChannels,
      status: 'COMMUNICATION_CHANNELS_ACTIVE',
      patterns: 'HYBRID_SYNC_ASYNC'
    };
  }
  
  async implementLoadBalancing(config) {
    console.log('⚖️ Flow Control 3: Implementing intelligent load balancing...');
    
    const loadBalancing = {
      // Application layer load balancing
      applicationLayer: {
        // API Gateway
        apiGateway: {
          type: 'kong-or-envoy-based',
          
          // Routing strategies
          routing: {
            pathBased: 'route-by-url-path',
            headerBased: 'route-by-headers',
            weightBased: 'canary-deployments',
            geoBased: 'geographic-routing'
          },
          
          // Load balancing algorithms
          algorithms: {
            roundRobin: 'equal-distribution',
            leastConnections: 'connection-aware',
            weightedRoundRobin: 'capacity-based',
            consistentHashing: 'session-affinity'
          },
          
          // Health checking
          healthChecks: {
            passive: 'response-code-monitoring',
            active: 'periodic-health-probes',
            circuit: 'circuit-breaker-integration'
          }
        },
        
        // Service-to-service load balancing
        serviceToService: {
          // Client-side load balancing
          clientSide: {
            library: 'ribbon-or-similar',
            discovery: 'service-registry-integration',
            algorithm: 'least-response-time',
            fallback: 'circuit-breaker-fallback'
          },
          
          // Server-side load balancing  
          serverSide: {
            proxy: 'envoy-proxy-sidecar',
            algorithm: 'least-request',
            healthChecking: 'upstream-health-monitoring',
            failover: 'automatic-failover'
          }
        }
      },
      
      // Network layer load balancing
      networkLayer: {
        // Layer 4 load balancing
        layer4: {
          protocol: 'TCP-UDP-load-balancing',
          algorithms: 'connection-based-algorithms',
          healthChecks: 'tcp-health-checks',
          persistence: 'source-ip-persistence'
        },
        
        // Layer 7 load balancing
        layer7: {
          protocol: 'HTTP-HTTPS-load-balancing',
          algorithms: 'request-based-algorithms',
          healthChecks: 'http-health-checks',
          persistence: 'cookie-based-persistence'
        }
      },
      
      // Auto-scaling integration
      autoScaling: {
        // Horizontal pod autoscaling
        hpa: {
          metrics: ['cpu', 'memory', 'custom-metrics'],
          thresholds: 'intelligent-thresholds',
          scaling: 'gradual-scaling-policies'
        },
        
        // Vertical pod autoscaling
        vpa: {
          recommendations: 'resource-recommendation-engine',
          updates: 'automatic-resource-updates',
          policies: 'update-policies'
        },
        
        // Cluster autoscaling
        clusterAutoscaling: {
          nodeGroups: 'multi-node-group-scaling',
          scheduling: 'intelligent-pod-scheduling',
          costOptimization: 'spot-instance-integration'
        }
      }
    };
    
    // Deploy load balancing infrastructure
    await this.deployLoadBalancingInfrastructure(loadBalancing);
    
    return {
      loadBalancing: loadBalancing,
      status: 'LOAD_BALANCING_ACTIVE',
      distribution: 'OPTIMALLY_DISTRIBUTED'
    };
  }
  
  async configureEventStreaming(config) {
    console.log('🌊 Data Rapids 4: Configuring high-throughput event streaming...');
    
    const eventStreaming = {
      // Event streaming platform
      platform: {
        // Apache Kafka cluster
        kafka: {
          cluster: {
            brokers: 3,
            replication: 3,
            partitions: 'topic-specific-partitioning',
            
            // Performance tuning
            performance: {
              batchingSize: '16KB',
              compressionType: 'snappy',
              lingerMs: 5,
              bufferMemory: '32MB'
            }
          },
          
          // Topic design
          topics: [
            {
              name: 'user-activity-stream',
              partitions: 24,
              replication: 3,
              retentionMs: 604800000, // 7 days
              config: {
                'cleanup.policy': 'delete',
                'compression.type': 'snappy'
              }
            },
            {
              name: 'order-state-stream',
              partitions: 12,
              replication: 3,
              retentionMs: -1, // Infinite retention
              config: {
                'cleanup.policy': 'compact',
                'min.cleanable.dirty.ratio': 0.1
              }
            }
          ]
        },
        
        // Stream processing
        streamProcessing: {
          // Kafka Streams
          kafkaStreams: {
            applications: [
              {
                name: 'user-behavior-analyzer',
                inputTopics: ['user-activity-stream'],
                outputTopics: ['user-insights-stream'],
                processing: 'windowed-aggregations'
              },
              {
                name: 'order-fulfillment-coordinator',
                inputTopics: ['order-state-stream', 'inventory-stream'],
                outputTopics: ['fulfillment-commands-stream'],
                processing: 'stateful-joins'
              }
            ]
          },
          
          // Apache Flink (alternative)
          flink: {
            jobs: 'complex-event-processing',
            watermarks: 'event-time-processing',
            checkpoints: 'fault-tolerant-state'
          }
        }
      },
      
      // Event-driven architecture patterns
      patterns: {
        // Event sourcing
        eventSourcing: {
          eventStore: 'immutable-event-log',
          aggregates: 'domain-aggregate-design',
          snapshots: 'performance-optimization',
          projections: 'read-model-generation'
        },
        
        // CQRS (Command Query Responsibility Segregation)
        cqrs: {
          commands: 'write-side-operations',
          queries: 'read-side-operations',
          separation: 'separate-models-and-storage',
          consistency: 'eventual-consistency'
        },
        
        // Saga pattern
        sagas: {
          orchestration: 'centralized-coordinator',
          choreography: 'decentralized-coordination',
          compensation: 'rollback-operations',
          timeout: 'saga-timeout-handling'
        }
      },
      
      // Event schema management
      schemaManagement: {
        // Schema registry
        registry: {
          type: 'confluent-schema-registry',
          evolution: 'backward-forward-compatibility',
          validation: 'producer-consumer-validation',
          governance: 'schema-governance-policies'
        },
        
        // Event contracts
        contracts: {
          definition: 'avro-or-json-schema',
          versioning: 'semantic-versioning',
          testing: 'contract-testing',
          documentation: 'auto-generated-docs'
        }
      }
    };
    
    // Deploy event streaming infrastructure
    await this.deployEventStreamingInfrastructure(eventStreaming);
    
    return {
      streaming: eventStreaming,
      status: 'EVENT_STREAMS_FLOWING',
      throughput: 'HIGH_THROUGHPUT_ACHIEVED'
    };
  }
  
  async buildDistributedCoordination(config) {
    console.log('🎛️ Command Center 5: Building distributed systems coordination...');
    
    const distributedCoordination = {
      // Consensus and coordination
      consensus: {
        // Distributed consensus (Raft/Paxos)
        algorithm: 'raft-consensus-algorithm',
        implementation: 'etcd-or-consul',
        
        // Leader election
        leaderElection: {
          algorithm: 'bully-algorithm-or-raft',
          heartbeat: 'leader-heartbeat-mechanism',
          failover: 'automatic-leader-failover'
        },
        
        // Distributed locking
        distributedLocks: {
          implementation: 'zookeeper-or-etcd-locks',
          timeout: 'lock-timeout-handling',
          fairness: 'fair-lock-queuing'
        }
      },
      
      // Distributed state management
      stateManagement: {
        // Configuration management
        configuration: {
          storage: 'distributed-configuration-store',
          watching: 'real-time-configuration-updates',
          versioning: 'configuration-versioning',
          rollback: 'configuration-rollback'
        },
        
        // Service coordination
        coordination: {
          membership: 'cluster-membership-management',
          partitioning: 'consistent-hash-partitioning',
          rebalancing: 'automatic-partition-rebalancing'
        }
      },
      
      // Distributed transactions
      transactions: {
        // Two-phase commit (2PC)
        twoPhaseCommit: {
          coordinator: 'transaction-coordinator',
          participants: 'resource-managers',
          recovery: 'crash-recovery-protocol'
        },
        
        // Saga transactions
        sagas: {
          implementation: 'saga-execution-coordinator',
          compensation: 'compensating-actions',
          isolation: 'semantic-locks'
        }
      },
      
      // Circuit breaker pattern
      circuitBreakers: {
        // Hystrix-style circuit breakers
        implementation: {
          states: ['closed', 'open', 'half-open'],
          thresholds: 'failure-rate-thresholds',
          timeout: 'circuit-open-timeout',
          fallback: 'fallback-mechanisms'
        },
        
        // Bulkhead pattern
        bulkheads: {
          isolation: 'resource-pool-isolation',
          sizing: 'thread-pool-sizing',
          monitoring: 'bulkhead-health-monitoring'
        }
      }
    };
    
    // Deploy coordination infrastructure
    await this.deployCoordinationInfrastructure(distributedCoordination);
    
    return {
      coordination: distributedCoordination,
      status: 'COORDINATION_CENTER_OPERATIONAL',
      reliability: 'HIGHLY_AVAILABLE'
    };
  }
}

// 🚇 Pipe Maze Network Monitor
class PipeMazeNetworkMonitor {
  constructor() {
    this.metrics = new Map();
    this.traces = new Map();
    this.topology = new NetworkTopologyMapper();
  }
  
  async monitorNetworkHealth(pipeNetwork) {
    console.log('📊 Monitoring network health across the pipe maze...');
    
    const networkHealth = {
      // Service health
      services: {
        health: await this.checkServiceHealth(),
        dependencies: await this.mapServiceDependencies(),
        communication: await this.analyzeServiceCommunication(),
        performance: await this.measureServicePerformance()
      },
      
      // Network metrics
      network: {
        latency: await this.measureNetworkLatency(),
        throughput: await this.measureNetworkThroughput(),
        errors: await this.detectNetworkErrors(),
        congestion: await this.detectNetworkCongestion()
      },
      
      // Distributed tracing
      tracing: {
        requests: await this.traceDistributedRequests(),
        bottlenecks: await this.identifyBottlenecks(),
        errors: await this.traceErrorPropagation(),
        performance: await this.analyzeTracePerformance()
      },
      
      // System topology
      topology: {
        services: await this.mapServiceTopology(),
        dependencies: await this.analyzeDependencyGraph(),
        criticalPath: await this.identifyCriticalPaths(),
        singlePoints: await this.findSinglePointsOfFailure()
      }
    };
    
    return networkHealth;
  }
}

// 🚇 Initialize Pipe Maze
const pipeMaze = new PipeMazeNetworkJourney();
const pipeMonitor = new PipeMazeNetworkMonitor();

console.log('🚇 Pipe Maze ready for microservices networking adventures!');
```

🌐 PIPE NETWORK INFRASTRUCTURE DEPLOYED!

Your microservices maze has established:
  🔍 **Service Discovery Hub**: Consul cluster + Istio service mesh
  📡 **Communication Channels**: HTTP/2, gRPC, Kafka streaming
  ⚖️ **Load Balancing**: Multi-layer load balancing + auto-scaling
  🌊 **Event Streaming**: High-throughput Kafka + stream processing
  🎛️ **Coordination Center**: Distributed consensus + circuit breakers

Current Pipe Status:
  🌊 **Data Flow**: Optimal (events streaming smoothly)
  🔗 **Connections**: Stable (all services discovering each other)
  ⚡ **Latency**: Low (sub-100ms inter-service communication)
  🛡️ **Resilience**: High (circuit breakers protecting critical paths)

*A vast network of glowing pipes illuminates the underground maze*

"Outstanding navigation, network architect! You've successfully mapped and connected the complex pipe maze of microservices. Data flows like underground rivers through your perfectly orchestrated network!" 🚇

🏆 **Pipe Maze Mastered!** Your distributed systems communicate flawlessly!

🌐 Ready to explore deeper network mysteries? Advanced patterns await!
```

### `/world-7-1-trace [request-id] [service-path]`
Follow distributed requests through the service mesh network.

### `/world-7-1-scale [service] [load-pattern]`
Test auto-scaling behavior under different load conditions.

### `/world-7-1-resilience [failure-type] [blast-radius]`
Test system resilience with controlled failure injection.

### `/world-7-1-optimize [bottleneck] [strategy]`
Optimize network performance and eliminate bottlenecks.

## 🌟 Pipe Maze Challenges

### 🌐 **Service Mesh Architecture**
Master the complexities of service-to-service communication:

```yaml
# 🚇 Pipe Maze Istio Configuration
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: pipe-maze-routing
  namespace: microservices
spec:
  hosts:
  - user-service
  - order-service
  - payment-service
  
  http:
  # Canary deployment routing
  - match:
    - headers:
        canary:
          exact: "true"
    route:
    - destination:
        host: user-service
        subset: v2
      weight: 100
    fault:
      delay:
        percentage:
          value: 0.1
        fixedDelay: 5s
  
  # Production traffic routing
  - route:
    - destination:
        host: user-service
        subset: v1
      weight: 90
    - destination:
        host: user-service  
        subset: v2
      weight: 10
    
    # Circuit breaker configuration
    timeout: 10s
    retries:
      attempts: 3
      perTryTimeout: 3s
      retryOn: gateway-error,connect-failure,refused-stream

---
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: pipe-maze-destinations
spec:
  host: user-service
  
  # Load balancing policy
  trafficPolicy:
    loadBalancer:
      simple: LEAST_CONN
    
    # Connection pool settings
    connectionPool:
      tcp:
        maxConnections: 100
        connectTimeout: 30s
      http:
        http1MaxPendingRequests: 10
        maxRequestsPerConnection: 2
        maxRetries: 3
        consecutiveGatewayErrors: 5
        interval: 30s
        baseEjectionTime: 30s
    
    # Circuit breaker
    outlierDetection:
      consecutiveGatewayErrors: 5
      interval: 30s
      baseEjectionTime: 30s
      maxEjectionPercent: 50
  
  # Service subsets for different versions
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
    trafficPolicy:
      loadBalancer:
        simple: ROUND_ROBIN

---
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: pipe-maze-security
spec:
  selector:
    matchLabels:
      app: user-service
  
  # RBAC rules
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/microservices/sa/api-gateway"]
    to:
    - operation:
        methods: ["GET", "POST"]
        paths: ["/api/users/*"]
  
  - from:
    - source:
        principals: ["cluster.local/ns/microservices/sa/order-service"]
    to:
    - operation:
        methods: ["GET"]
        paths: ["/api/users/*/profile"]
```

### 📊 **Event-Driven Architecture**
Implement sophisticated event streaming patterns:

```javascript
// 🌊 Pipe Maze Event Streaming System
const { Kafka } = require('kafkajs');
const { SchemaRegistry } = require('@kafkajs/confluent-schema-registry');

class PipeMazeEventStreaming {
  constructor() {
    this.kafka = new Kafka({
      clientId: 'pipe-maze-client',
      brokers: ['kafka-1:9092', 'kafka-2:9092', 'kafka-3:9092'],
      
      // Security configuration
      ssl: true,
      sasl: {
        mechanism: 'SCRAM-SHA-256',
        username: process.env.KAFKA_USERNAME,
        password: process.env.KAFKA_PASSWORD
      }
    });
    
    this.schemaRegistry = new SchemaRegistry({
      host: 'http://schema-registry:8081',
      auth: {
        username: process.env.SCHEMA_REGISTRY_USERNAME,
        password: process.env.SCHEMA_REGISTRY_PASSWORD
      }
    });
    
    console.log('🌊 Pipe Maze: Event streaming system initialized!');
  }
  
  async setupEventStreams() {
    console.log('🚇 Setting up event streaming infrastructure...');
    
    // Create topics with proper configuration
    const admin = this.kafka.admin();
    await admin.connect();
    
    const topics = [
      {
        topic: 'user-lifecycle-events',
        numPartitions: 12,
        replicationFactor: 3,
        configEntries: [
          { name: 'cleanup.policy', value: 'delete' },
          { name: 'retention.ms', value: '604800000' }, // 7 days
          { name: 'compression.type', value: 'snappy' }
        ]
      },
      {
        topic: 'order-state-events',
        numPartitions: 24,
        replicationFactor: 3,
        configEntries: [
          { name: 'cleanup.policy', value: 'compact' },
          { name: 'min.cleanable.dirty.ratio', value: '0.1' },
          { name: 'compression.type', value: 'lz4' }
        ]
      }
    ];
    
    await admin.createTopics({ topics });
    
    // Set up schema registry schemas
    await this.registerEventSchemas();
    
    await admin.disconnect();
    
    console.log('✅ Event streaming infrastructure ready!');
  }
  
  async registerEventSchemas() {
    console.log('📋 Registering event schemas...');
    
    // User lifecycle event schema
    const userEventSchema = {
      type: 'record',
      name: 'UserLifecycleEvent',
      namespace: 'com.pipemaze.events.user',
      fields: [
        { name: 'eventId', type: 'string' },
        { name: 'userId', type: 'string' },
        { name: 'eventType', type: { type: 'enum', name: 'UserEventType', symbols: ['CREATED', 'UPDATED', 'DELETED', 'ACTIVATED', 'DEACTIVATED'] } },
        { name: 'timestamp', type: { type: 'long', logicalType: 'timestamp-millis' } },
        { name: 'payload', type: 'string' },
        { name: 'version', type: { type: 'string', default: '1.0' } },
        { name: 'metadata', type: { type: 'map', values: 'string' }, default: {} }
      ]
    };
    
    // Order state event schema
    const orderEventSchema = {
      type: 'record',
      name: 'OrderStateEvent',
      namespace: 'com.pipemaze.events.order',
      fields: [
        { name: 'eventId', type: 'string' },
        { name: 'orderId', type: 'string' },
        { name: 'customerId', type: 'string' },
        { name: 'previousState', type: ['null', 'string'], default: null },
        { name: 'currentState', type: 'string' },
        { name: 'timestamp', type: { type: 'long', logicalType: 'timestamp-millis' } },
        { name: 'stateData', type: 'string' },
        { name: 'version', type: { type: 'string', default: '1.0' } }
      ]
    };
    
    // Register schemas
    await this.schemaRegistry.register({
      type: 'AVRO',
      schema: JSON.stringify(userEventSchema)
    }, { subject: 'user-lifecycle-events-value' });
    
    await this.schemaRegistry.register({
      type: 'AVRO', 
      schema: JSON.stringify(orderEventSchema)
    }, { subject: 'order-state-events-value' });
    
    console.log('✅ Event schemas registered successfully!');
  }
  
  async createEventProducer(config = {}) {
    const producer = this.kafka.producer({
      // Producer configuration for high throughput
      allowAutoTopicCreation: false,
      idempotent: true,
      maxInFlightRequests: 5,
      
      // Batching configuration
      batch: {
        size: 16384, // 16KB
        lingerMs: 5
      },
      
      // Compression
      compression: 'snappy',
      
      ...config
    });
    
    await producer.connect();
    
    return {
      producer,
      
      // Publish user lifecycle event
      publishUserEvent: async (userId, eventType, payload) => {
        const event = {
          eventId: `user-${userId}-${Date.now()}`,
          userId,
          eventType,
          timestamp: Date.now(),
          payload: JSON.stringify(payload),
          version: '1.0',
          metadata: {
            source: 'user-service',
            correlationId: payload.correlationId || `corr-${Date.now()}`
          }
        };
        
        // Encode with schema
        const encodedValue = await this.schemaRegistry.encode(
          await this.schemaRegistry.getLatestSchemaId('user-lifecycle-events-value'),
          event
        );
        
        await producer.send({
          topic: 'user-lifecycle-events',
          messages: [{
            key: userId,
            value: encodedValue,
            partition: this.calculatePartition(userId, 12),
            headers: {
              'event-type': eventType,
              'source-service': 'user-service'
            }
          }]
        });
        
        console.log(`📤 Published user event: ${eventType} for user ${userId}`);
      },
      
      // Publish order state event
      publishOrderEvent: async (orderId, customerId, previousState, currentState, stateData) => {
        const event = {
          eventId: `order-${orderId}-${Date.now()}`,
          orderId,
          customerId,
          previousState,
          currentState,
          timestamp: Date.now(),
          stateData: JSON.stringify(stateData),
          version: '1.0'
        };
        
        // Encode with schema
        const encodedValue = await this.schemaRegistry.encode(
          await this.schemaRegistry.getLatestSchemaId('order-state-events-value'),
          event
        );
        
        await producer.send({
          topic: 'order-state-events',
          messages: [{
            key: orderId,
            value: encodedValue,
            partition: this.calculatePartition(orderId, 24),
            headers: {
              'event-type': 'STATE_CHANGE',
              'source-service': 'order-service',
              'customer-id': customerId
            }
          }]
        });
        
        console.log(`📤 Published order state change: ${previousState} → ${currentState} for order ${orderId}`);
      }
    };
  }
  
  async createEventConsumer(groupId, topics, messageHandler) {
    const consumer = this.kafka.consumer({
      groupId,
      
      // Consumer configuration for reliability
      sessionTimeout: 30000,
      rebalanceTimeout: 60000,
      heartbeatInterval: 3000,
      
      // Offset management
      allowAutoTopicCreation: false,
      
      // Processing configuration
      maxBytesPerPartition: 1048576, // 1MB
      minBytes: 1,
      maxBytes: 10485760, // 10MB
      maxWaitTimeInMs: 5000
    });
    
    await consumer.connect();
    await consumer.subscribe({ topics, fromBeginning: false });
    
    // Process messages with error handling and retries
    await consumer.run({
      eachBatch: async ({ batch, resolveOffset, heartbeat, isRunning, isStale }) => {
        console.log(`📥 Processing batch of ${batch.messages.length} messages from ${batch.topic}`);
        
        for (const message of batch.messages) {
          if (!isRunning() || isStale()) break;
          
          try {
            // Decode message using schema registry
            const decodedValue = await this.schemaRegistry.decode(message.value);
            
            // Process message
            await messageHandler({
              topic: batch.topic,
              partition: batch.partition,
              offset: message.offset,
              key: message.key?.toString(),
              value: decodedValue,
              headers: message.headers,
              timestamp: message.timestamp
            });
            
            // Commit offset
            resolveOffset(message.offset);
            
            // Send heartbeat to avoid rebalancing
            await heartbeat();
            
          } catch (error) {
            console.error(`❌ Error processing message: ${error.message}`);
            
            // Implement dead letter queue or retry logic here
            await this.handleMessageError(message, error);
          }
        }
      }
    });
    
    return consumer;
  }
  
  calculatePartition(key, numPartitions) {
    // Simple hash-based partitioning
    let hash = 0;
    for (let i = 0; i < key.length; i++) {
      hash = ((hash << 5) - hash + key.charCodeAt(i)) & 0xffffffff;
    }
    return Math.abs(hash) % numPartitions;
  }
  
  async handleMessageError(message, error) {
    // Implement error handling strategy
    console.log(`🚨 Handling message error: ${error.message}`);
    
    // Could implement:
    // - Dead letter queue
    // - Retry with exponential backoff
    // - Alert monitoring systems
    // - Circuit breaker pattern
  }
}

// Initialize event streaming
const pipeEventStreaming = new PipeMazeEventStreaming();
console.log('🌊 Pipe Maze event streaming ready!');
```

### 🔄 **Distributed Coordination Patterns**
Implement sophisticated coordination mechanisms:

```javascript
// 🎛️ Pipe Maze Distributed Coordination System
const consul = require('consul');
const Redis = require('ioredis');

class PipeMazeCoordination {
  constructor() {
    this.consul = new consul({
      host: 'consul-server',
      port: 8500,
      secure: false,
      promisify: true
    });
    
    this.redis = new Redis.Cluster([
      { host: 'redis-1', port: 6379 },
      { host: 'redis-2', port: 6379 },
      { host: 'redis-3', port: 6379 }
    ]);
    
    console.log('🎛️ Pipe Maze: Distributed coordination system ready!');
  }
  
  // Distributed locking implementation
  async acquireDistributedLock(lockKey, ttl = 30000, retries = 3) {
    console.log(`🔒 Acquiring distributed lock: ${lockKey}`);
    
    const lockValue = `${process.pid}-${Date.now()}-${Math.random()}`;
    
    for (let attempt = 1; attempt <= retries; attempt++) {
      try {
        // Try to acquire lock using Redis SET with NX and PX
        const result = await this.redis.set(
          `lock:${lockKey}`,
          lockValue,
          'PX', ttl,  // Expire after ttl milliseconds
          'NX'       // Only set if key doesn't exist
        );
        
        if (result === 'OK') {
          console.log(`✅ Lock acquired: ${lockKey} (attempt ${attempt})`);
          
          // Return lock object with release method
          return {
            key: lockKey,
            value: lockValue,
            ttl: ttl,
            acquired: true,
            
            // Method to release the lock
            release: async () => {
              // Use Lua script to ensure atomic release
              const releaseScript = `
                if redis.call("GET", KEYS[1]) == ARGV[1] then
                  return redis.call("DEL", KEYS[1])
                else
                  return 0
                end
              `;
              
              const result = await this.redis.eval(
                releaseScript,
                1,
                `lock:${lockKey}`,
                lockValue
              );
              
              if (result === 1) {
                console.log(`🔓 Lock released: ${lockKey}`);
                return true;
              } else {
                console.log(`⚠️ Lock release failed (may have expired): ${lockKey}`);
                return false;
              }
            },
            
            // Method to extend lock TTL
            extend: async (additionalTtl) => {
              const extendScript = `
                if redis.call("GET", KEYS[1]) == ARGV[1] then
                  return redis.call("PEXPIRE", KEYS[1], ARGV[2])
                else
                  return 0
                end
              `;
              
              const result = await this.redis.eval(
                extendScript,
                1,
                `lock:${lockKey}`,
                lockValue,
                additionalTtl
              );
              
              return result === 1;
            }
          };
        } else {
          console.log(`⏳ Lock acquisition failed, attempt ${attempt}/${retries}`);
          
          if (attempt < retries) {
            // Exponential backoff
            const delay = Math.min(1000 * Math.pow(2, attempt - 1), 5000);
            await new Promise(resolve => setTimeout(resolve, delay));
          }
        }
      } catch (error) {
        console.error(`❌ Lock acquisition error: ${error.message}`);
        
        if (attempt === retries) {
          throw new Error(`Failed to acquire lock ${lockKey} after ${retries} attempts`);
        }
      }
    }
    
    return { acquired: false };
  }
  
  // Leader election implementation
  async participateInLeaderElection(serviceName, serviceId) {
    console.log(`👑 Participating in leader election for ${serviceName}`);
    
    const sessionId = await this.consul.session.create({
      name: `leader-election-${serviceName}-${serviceId}`,
      ttl: 15, // 15 seconds
      behavior: 'release', // Release locks on session invalidation
      lockDelay: 1 // 1 second lock delay
    });
    
    const leaderKey = `service/${serviceName}/leader`;
    
    // Try to acquire leadership
    const acquired = await this.consul.kv.set({
      key: leaderKey,
      value: JSON.stringify({
        serviceId: serviceId,
        timestamp: Date.now(),
        sessionId: sessionId
      }),
      acquire: sessionId
    });
    
    if (acquired) {
      console.log(`👑 Leadership acquired for ${serviceName} by ${serviceId}`);
      
      // Start session renewal to maintain leadership
      const renewalInterval = setInterval(async () => {
        try {
          await this.consul.session.renew(sessionId);
          console.log(`♻️ Leadership session renewed for ${serviceName}`);
        } catch (error) {
          console.error(`❌ Session renewal failed: ${error.message}`);
          clearInterval(renewalInterval);
        }
      }, 10000); // Renew every 10 seconds
      
      return {
        isLeader: true,
        sessionId: sessionId,
        
        // Method to step down from leadership
        stepDown: async () => {
          clearInterval(renewalInterval);
          
          try {
            await this.consul.session.destroy(sessionId);
            console.log(`👋 Stepped down from leadership: ${serviceName}`);
            return true;
          } catch (error) {
            console.error(`❌ Error stepping down: ${error.message}`);
            return false;
          }
        },
        
        // Method to check if still leader
        isStillLeader: async () => {
          try {
            const result = await this.consul.kv.get({
              key: leaderKey,
              raw: true
            });
            
            if (result && result.Session === sessionId) {
              return true;
            } else {
              clearInterval(renewalInterval);
              return false;
            }
          } catch (error) {
            console.error(`❌ Error checking leadership: ${error.message}`);
            return false;
          }
        }
      };
    } else {
      console.log(`🤷 Leadership not acquired for ${serviceName}`);
      
      // Watch for leadership changes
      const watcher = this.consul.watch({
        method: this.consul.kv.get,
        options: { key: leaderKey }
      });
      
      watcher.on('change', (data) => {
        if (!data || !data.Session) {
          console.log(`🔄 Leadership available for ${serviceName}, attempting to acquire...`);
          // Could retry leadership acquisition here
        }
      });
      
      return {
        isLeader: false,
        sessionId: sessionId,
        watcher: watcher
      };
    }
  }
  
  // Distributed configuration management
  async manageDistributedConfiguration(serviceName) {
    console.log(`⚙️ Setting up distributed configuration for ${serviceName}`);
    
    const configKey = `config/${serviceName}`;
    
    return {
      // Get configuration
      getConfig: async () => {
        try {
          const result = await this.consul.kv.get({
            key: configKey,
            recurse: true
          });
          
          if (result) {
            const config = {};
            result.forEach(item => {
              const key = item.Key.replace(`${configKey}/`, '');
              config[key] = item.Value;
            });
            return config;
          }
          
          return {};
        } catch (error) {
          console.error(`❌ Error getting config: ${error.message}`);
          return {};
        }
      },
      
      // Set configuration
      setConfig: async (key, value) => {
        try {
          await this.consul.kv.set({
            key: `${configKey}/${key}`,
            value: JSON.stringify(value)
          });
          
          console.log(`✅ Configuration set: ${key}`);
          return true;
        } catch (error) {
          console.error(`❌ Error setting config: ${error.message}`);
          return false;
        }
      },
      
      // Watch for configuration changes
      watchConfig: (callback) => {
        const watcher = this.consul.watch({
          method: this.consul.kv.get,
          options: { key: configKey, recurse: true }
        });
        
        watcher.on('change', (data) => {
          const config = {};
          if (data) {
            data.forEach(item => {
              const key = item.Key.replace(`${configKey}/`, '');
              config[key] = JSON.parse(item.Value);
            });
          }
          
          callback(config);
        });
        
        watcher.on('error', (error) => {
          console.error(`❌ Configuration watch error: ${error.message}`);
        });
        
        return watcher;
      }
    };
  }
}

// Initialize coordination system
const pipeCoordination = new PipeMazeCoordination();
console.log('🎛️ Pipe Maze coordination ready!');
```

## 🏆 Pipe Maze Achievements

- 🚇 **Network Navigator** - Successfully deploy microservices architecture
- 🌊 **Event Stream Master** - Implement high-throughput event streaming
- 🔗 **Service Mesh Architect** - Master inter-service communication
- 🎛️ **Coordination Expert** - Build distributed consensus systems

## 🎵 Pipe Maze Sound Effects

- **Data Flow**: *Water rushing through pipes* + *network transmission sounds*
- **Service Discovery**: *Pipe connections clicking* + *discovery chimes*
- **Load Balancing**: *Traffic directing sounds* + *smooth flow audio*
- **System Coordination**: *Synchronized pipe orchestra* + *harmony sounds*

## ⚠️ Pipe Maze Guidelines

### 🚇 **Network Architecture Principles**
- Design for failure - networks are inherently unreliable
- Implement comprehensive observability from day one
- Use circuit breakers and bulkheads for resilience
- Plan for gradual degradation rather than complete failure

### 🌊 **Event Streaming Best Practices**
- Design events for forward compatibility
- Implement proper schema evolution strategies
- Monitor consumer lag and processing times
- Plan for event replay and reprocessing scenarios

## 🌈 Advanced Pipe Maze Features

### 🌐 **Advanced Service Mesh**
Enterprise-grade service mesh management:
```bash
/world-7-1-service-mesh --advanced=true --multi-cluster=true --security=zero-trust
/world-7-1-traffic-management --canary=automated --circuit-breakers=intelligent
/world-7-1-observability --tracing=jaeger --metrics=prometheus --logs=fluentd
```

### 🚇 **Advanced Network Patterns**
Sophisticated distributed systems patterns:
```bash
/world-7-1-patterns --saga=orchestration --cqrs=true --event-sourcing=true
/world-7-1-consensus --algorithm=raft --coordination=etcd --replication=3
/world-7-1-federation --clusters=multi-region --failover=automatic
```

## 🎮 Pipe Maze Mini-Games

### 🚇 **Network Navigation Challenge**
Navigate increasingly complex distributed systems:
- Pipe Walker: Connect 5 services with proper load balancing
- Maze Runner: Implement full service mesh with security
- Network Master: Design resilient multi-region architecture

### 🌊 **Event Streaming Olympics**
Master high-throughput event processing:
- Stream Swimmer: Process 10K events/second reliably
- Rapids Rider: Handle event ordering and exactly-once delivery
- Ocean Master: Design globally distributed event architecture

---

*"Remember: In the Pipe Maze, data flows like underground rivers, and understanding the current is the key to navigation! Master the network, and you master the distributed future!"* 🚇

**Pipe Maze Motto**: *"Connected systems, flowing data, endless possibilities!"* 🌊

*"Navigate the maze with wisdom, and your microservices will communicate like a perfectly orchestrated symphony!"* 🎼