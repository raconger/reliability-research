# Industrial Communication Protocols - Implementation Examples

## Table of Contents

1. [OPC UA Examples](#opc-ua-examples)
2. [MQTT Examples](#mqtt-examples)
3. [Modbus Examples](#modbus-examples)
4. [REST API Examples](#rest-api-examples)
5. [Protocol Gateway Implementations](#protocol-gateway-implementations)
6. [Security Implementation](#security-implementation)
7. [Edge Computing Patterns](#edge-computing-patterns)
8. [Data Model Examples](#data-model-examples)

---

## OPC UA Examples

### Basic OPC UA Client (Python)

```python
from opcua import Client
import time

# Connect to OPC UA server
client = Client("opc.tcp://plc.example.com:4840")

try:
    client.connect()
    print("Connected to OPC UA server")

    # Browse root node
    root = client.get_root_node()
    print(f"Root node: {root}")

    # Get objects node
    objects = client.get_objects_node()

    # Read vibration sensor data
    vibration_node = client.get_node("ns=2;s=Machine1.VibrationRMS")
    vibration_value = vibration_node.get_value()
    print(f"Vibration RMS: {vibration_value} mm/s")

    # Subscribe to data changes
    class SubHandler:
        def datachange_notification(self, node, val, data):
            print(f"Data change: {node} = {val}")

    handler = SubHandler()
    subscription = client.create_subscription(500, handler)  # 500ms update rate
    handle = subscription.subscribe_data_change(vibration_node)

    # Run for 60 seconds
    time.sleep(60)

    # Cleanup
    subscription.delete()

finally:
    client.disconnect()
    print("Disconnected from OPC UA server")
```

### OPC UA Server with Custom Namespace (Python)

```python
from opcua import Server
from datetime import datetime
import time
import random

# Create server
server = Server()
server.set_endpoint("opc.tcp://0.0.0.0:4840/freeopcua/server/")
server.set_server_name("Condition Monitoring Server")

# Setup custom namespace
namespace = "http://example.com/conditionmonitoring"
idx = server.register_namespace(namespace)

# Create object structure
objects = server.get_objects_node()

# Add equipment hierarchy
plant = objects.add_object(idx, "Plant1")
production_line = plant.add_object(idx, "ProductionLine1")
motor = production_line.add_object(idx, "Motor101")

# Add variables (sensors)
vibration = motor.add_variable(idx, "VibrationRMS", 0.0)
vibration.set_writable()  # Allow writes for simulation

temperature = motor.add_variable(idx, "BearingTemperature", 0.0)
temperature.set_writable()

status = motor.add_variable(idx, "OperationalStatus", "Running")
status.set_writable()

# Add properties
motor.add_property(idx, "Manufacturer", "ABB")
motor.add_property(idx, "Model", "M3BP 315 SMB 4")
motor.add_property(idx, "SerialNumber", "ABC123456")
motor.add_property(idx, "RatedPower", 132.0)  # kW

# Add method (execute diagnostic)
def run_diagnostic(parent):
    return [True, "Diagnostic completed successfully"]

motor.add_method(idx, "RunDiagnostic", run_diagnostic, [], [])

# Start server
server.start()
print(f"OPC UA Server started at {server.endpoint}")

try:
    # Simulate sensor data updates
    while True:
        # Generate realistic vibration data (normal operation: 0.5-2.5 mm/s)
        base_vibration = 1.5
        vibration_value = base_vibration + random.gauss(0, 0.3)
        vibration.set_value(vibration_value)

        # Generate temperature data (normal: 50-70°C)
        temp_value = 60 + random.gauss(0, 5)
        temperature.set_value(temp_value)

        # Simulate fault condition
        if vibration_value > 3.0:
            status.set_value("Alarm")
        elif vibration_value > 2.5:
            status.set_value("Warning")
        else:
            status.set_value("Running")

        time.sleep(1)  # Update every second

except KeyboardInterrupt:
    server.stop()
    print("Server stopped")
```

### OPC UA Pub/Sub Configuration (JSON)

```json
{
  "PubSubConfiguration": {
    "Connections": [
      {
        "Name": "MQTTConnection1",
        "Enabled": true,
        "PublisherId": "urn:publisher1",
        "TransportProfileUri": "http://opcfoundation.org/UA-Profile/Transport/pubsub-mqtt",
        "Address": {
          "Url": "mqtt://broker.example.com:1883",
          "NetworkInterface": "eth0"
        },
        "WriterGroups": [
          {
            "Name": "VibrationWriterGroup",
            "Enabled": true,
            "PublishingInterval": 1000.0,
            "DataSetWriters": [
              {
                "Name": "VibrationDataWriter",
                "DataSetName": "VibrationDataSet",
                "KeyFrameCount": 1,
                "DataSetFieldContentMask": 63
              }
            ],
            "MessageSettings": {
              "QualityOfService": 1,
              "Retain": false,
              "TopicName": "factory/line1/motor101/vibration"
            }
          }
        ]
      }
    ],
    "PublishedDataSets": [
      {
        "Name": "VibrationDataSet",
        "DataSetSource": {
          "PublishedVariables": [
            {
              "PublishedVariable": "ns=2;s=Machine1.VibrationRMS",
              "AttributeId": 13
            },
            {
              "PublishedVariable": "ns=2;s=Machine1.VibrationPeak",
              "AttributeId": 13
            }
          ]
        }
      }
    ]
  }
}
```

---

## MQTT Examples

### MQTT Publisher (Python)

```python
import paho.mqtt.client as mqtt
import json
import time
import random
from datetime import datetime

# MQTT broker configuration
BROKER = "broker.example.com"
PORT = 1883
USERNAME = "sensor_publisher"
PASSWORD = "secure_password"
TOPIC_PREFIX = "factory/line1"

# Callback when connected
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to MQTT broker")
    else:
        print(f"Connection failed with code {rc}")

# Callback when message is published
def on_publish(client, userdata, mid):
    print(f"Message {mid} published")

# Create MQTT client
client = mqtt.Client(client_id="vibration_sensor_001")
client.username_pw_set(USERNAME, PASSWORD)
client.on_connect = on_connect
client.on_publish = on_publish

# Enable TLS (optional but recommended)
# client.tls_set(ca_certs="/path/to/ca.crt")

# Connect to broker
client.connect(BROKER, PORT, 60)
client.loop_start()

try:
    while True:
        # Create sensor payload
        payload = {
            "sensor_id": "vibration_sensor_001",
            "timestamp": datetime.utcnow().isoformat() + "Z",
            "measurements": {
                "vibration_rms": round(1.5 + random.gauss(0, 0.3), 3),
                "vibration_peak": round(4.5 + random.gauss(0, 0.8), 3),
                "temperature": round(60 + random.gauss(0, 5), 1),
                "battery_voltage": round(3.3 + random.uniform(-0.1, 0.1), 2)
            },
            "status": "normal",
            "quality": "good"
        }

        # Publish with QoS 1
        topic = f"{TOPIC_PREFIX}/motor101/vibration"
        result = client.publish(topic, json.dumps(payload), qos=1, retain=False)

        # Check if publish was successful
        if result.rc == mqtt.MQTT_ERR_SUCCESS:
            print(f"Published to {topic}: {payload['measurements']}")
        else:
            print(f"Publish failed: {result.rc}")

        time.sleep(5)  # Publish every 5 seconds

except KeyboardInterrupt:
    print("Stopping publisher...")
    client.loop_stop()
    client.disconnect()
```

### MQTT Subscriber (Python)

```python
import paho.mqtt.client as mqtt
import json
from datetime import datetime

BROKER = "broker.example.com"
PORT = 1883
USERNAME = "data_consumer"
PASSWORD = "secure_password"
TOPIC_PATTERN = "factory/+/+/vibration"  # Wildcard subscription

# Callback when connected
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to MQTT broker")
        # Subscribe to topics
        client.subscribe(TOPIC_PATTERN, qos=1)
        print(f"Subscribed to {TOPIC_PATTERN}")
    else:
        print(f"Connection failed with code {rc}")

# Callback when message received
def on_message(client, userdata, msg):
    try:
        # Parse JSON payload
        payload = json.loads(msg.payload.decode())

        # Extract information
        sensor_id = payload.get("sensor_id")
        timestamp = payload.get("timestamp")
        measurements = payload.get("measurements", {})
        vibration_rms = measurements.get("vibration_rms")

        print(f"[{timestamp}] {msg.topic}")
        print(f"  Sensor: {sensor_id}")
        print(f"  Vibration RMS: {vibration_rms} mm/s")

        # Check alarm conditions
        if vibration_rms and vibration_rms > 3.0:
            print(f"  ⚠️ ALARM: High vibration detected!")
            # Trigger alarm handling logic here

    except json.JSONDecodeError:
        print(f"Invalid JSON payload from {msg.topic}")
    except Exception as e:
        print(f"Error processing message: {e}")

# Create MQTT client
client = mqtt.Client(client_id="monitoring_system_001")
client.username_pw_set(USERNAME, PASSWORD)
client.on_connect = on_connect
client.on_message = on_message

# Connect and start loop
client.connect(BROKER, PORT, 60)
client.loop_forever()
```

### Sparkplug B Implementation (Python)

```python
import paho.mqtt.client as mqtt
from sparkplug_b import *
import time

# Sparkplug configuration
GROUP_ID = "FactoryA"
EDGE_NODE_ID = "Gateway01"
DEVICE_ID = "Motor101"

# Create Sparkplug namespace
namespace = "spBv1.0"

# Metric definitions
metrics = [
    {"name": "VibrationRMS", "dataType": MetricDataType.Float, "value": 0.0},
    {"name": "Temperature", "dataType": MetricDataType.Float, "value": 0.0},
    {"name": "Status", "dataType": MetricDataType.String, "value": "Unknown"}
]

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected - Publishing NBIRTH")

        # Publish node birth certificate
        nbirth_topic = f"{namespace}/{GROUP_ID}/NBIRTH/{EDGE_NODE_ID}"
        nbirth_payload = create_birth_payload(metrics)
        client.publish(nbirth_topic, nbirth_payload, qos=0, retain=False)

        # Publish device birth certificate
        dbirth_topic = f"{namespace}/{GROUP_ID}/DBIRTH/{EDGE_NODE_ID}/{DEVICE_ID}"
        dbirth_payload = create_birth_payload(metrics)
        client.publish(dbirth_topic, dbirth_payload, qos=0, retain=False)

def create_birth_payload(metrics):
    # Create Sparkplug B birth payload with all metrics
    # (Implementation depends on sparkplug_b library)
    payload = {
        "timestamp": int(time.time() * 1000),
        "metrics": metrics,
        "seq": 0
    }
    return serialize_payload(payload)  # Serialize using protobuf

def create_data_payload(metric_name, value):
    # Create Sparkplug B data payload for single metric update
    payload = {
        "timestamp": int(time.time() * 1000),
        "metrics": [{"name": metric_name, "value": value}],
        "seq": get_next_sequence()
    }
    return serialize_payload(payload)

# MQTT client setup
client = mqtt.Client(client_id=f"{EDGE_NODE_ID}")
client.on_connect = on_connect

# Set Last Will and Testament (death certificate)
will_topic = f"{namespace}/{GROUP_ID}/NDEATH/{EDGE_NODE_ID}"
will_payload = create_death_payload()
client.will_set(will_topic, will_payload, qos=0, retain=False)

# Connect and publish data
client.connect("broker.example.com", 1883, 60)
client.loop_start()

try:
    while True:
        # Publish data updates
        data_topic = f"{namespace}/{GROUP_ID}/DDATA/{EDGE_NODE_ID}/{DEVICE_ID}"

        vibration_value = read_vibration_sensor()  # Your sensor reading function
        data_payload = create_data_payload("VibrationRMS", vibration_value)
        client.publish(data_topic, data_payload, qos=0, retain=False)

        time.sleep(5)

except KeyboardInterrupt:
    # Publish death certificate on shutdown
    ndeath_topic = f"{namespace}/{GROUP_ID}/NDEATH/{EDGE_NODE_ID}"
    ndeath_payload = create_death_payload()
    client.publish(ndeath_topic, ndeath_payload, qos=0, retain=False)

    client.loop_stop()
    client.disconnect()
```

---

## Modbus Examples

### Modbus TCP Client (Python)

```python
from pymodbus.client import ModbusTcpClient
from pymodbus.exceptions import ModbusException
import time

# Connect to Modbus TCP device
client = ModbusTcpClient('192.168.1.100', port=502)

try:
    if client.connect():
        print("Connected to Modbus TCP device")

        # Read configuration
        SLAVE_ID = 1

        # Read holding registers (function code 03)
        # Example: Read vibration alarm threshold from register 40001
        response = client.read_holding_registers(
            address=40000,  # Modbus addressing: 40001 -> address 40000
            count=1,
            slave=SLAVE_ID
        )

        if not response.isError():
            threshold = response.registers[0] / 100.0  # Convert to actual value
            print(f"Vibration alarm threshold: {threshold} mm/s")
        else:
            print(f"Error reading holding registers: {response}")

        # Read input registers (function code 04)
        # Example: Read current vibration value from register 30001
        response = client.read_input_registers(
            address=30000,  # Modbus addressing: 30001 -> address 30000
            count=2,  # Read 2 registers for 32-bit float
            slave=SLAVE_ID
        )

        if not response.isError():
            # Convert two 16-bit registers to 32-bit float (big-endian)
            import struct
            raw_bytes = struct.pack('>HH', response.registers[0], response.registers[1])
            vibration_value = struct.unpack('>f', raw_bytes)[0]
            print(f"Current vibration: {vibration_value:.3f} mm/s")
        else:
            print(f"Error reading input registers: {response}")

        # Read discrete inputs (function code 02)
        # Example: Read alarm status from input 10001
        response = client.read_discrete_inputs(
            address=10000,
            count=8,  # Read 8 discrete inputs
            slave=SLAVE_ID
        )

        if not response.isError():
            alarm_status = response.bits[0]  # First discrete input
            warning_status = response.bits[1]  # Second discrete input
            print(f"Alarm: {alarm_status}, Warning: {warning_status}")
        else:
            print(f"Error reading discrete inputs: {response}")

        # Write single register (function code 06)
        # Example: Update sampling rate in register 40010
        new_sampling_rate = 1000  # Hz
        response = client.write_register(
            address=40009,
            value=new_sampling_rate,
            slave=SLAVE_ID
        )

        if not response.isError():
            print(f"Updated sampling rate to {new_sampling_rate} Hz")
        else:
            print(f"Error writing register: {response}")

        # Write multiple registers (function code 16)
        # Example: Write configuration parameters
        config_values = [100, 200, 300]  # Multiple parameters
        response = client.write_registers(
            address=40100,
            values=config_values,
            slave=SLAVE_ID
        )

        if not response.isError():
            print(f"Wrote configuration: {config_values}")
        else:
            print(f"Error writing registers: {response}")

        # Continuous monitoring loop
        print("\nStarting continuous monitoring...")
        for i in range(10):
            response = client.read_input_registers(address=30000, count=2, slave=SLAVE_ID)
            if not response.isError():
                raw_bytes = struct.pack('>HH', response.registers[0], response.registers[1])
                vibration = struct.unpack('>f', raw_bytes)[0]
                print(f"[{i+1}] Vibration: {vibration:.3f} mm/s")
            time.sleep(1)

    else:
        print("Failed to connect to Modbus TCP device")

finally:
    client.close()
    print("Disconnected from Modbus device")
```

### Modbus RTU Client (Python)

```python
from pymodbus.client import ModbusSerialClient
import time

# Connect to Modbus RTU device over serial
client = ModbusSerialClient(
    port='/dev/ttyUSB0',  # Serial port (Linux)
    # port='COM3',  # Serial port (Windows)
    baudrate=9600,
    bytesize=8,
    parity='N',
    stopbits=1,
    timeout=1
)

try:
    if client.connect():
        print("Connected to Modbus RTU device")

        SLAVE_ID = 1

        # Read sensor data
        response = client.read_input_registers(
            address=0,
            count=10,
            slave=SLAVE_ID
        )

        if not response.isError():
            print(f"Sensor readings: {response.registers}")

            # Parse specific values
            temperature = response.registers[0] / 10.0  # Scale factor 0.1
            pressure = response.registers[1] / 100.0  # Scale factor 0.01
            flow_rate = response.registers[2]

            print(f"Temperature: {temperature}°C")
            print(f"Pressure: {pressure} bar")
            print(f"Flow rate: {flow_rate} L/min")
        else:
            print(f"Error: {response}")
    else:
        print("Failed to connect to Modbus RTU device")

finally:
    client.close()
```

---

## REST API Examples

### REST API Server (Python Flask)

```python
from flask import Flask, jsonify, request
from flask_httpauth import HTTPTokenAuth
from datetime import datetime
import random

app = Flask(__name__)
auth = HTTPTokenAuth(scheme='Bearer')

# Simple token validation (use proper JWT in production)
VALID_TOKENS = {
    "secret_token_123": "user1"
}

@auth.verify_token
def verify_token(token):
    if token in VALID_TOKENS:
        return VALID_TOKENS[token]
    return None

# In-memory data store (use database in production)
sensor_data = {
    "motor101": {
        "vibration_rms": 1.5,
        "temperature": 60.0,
        "status": "running",
        "last_updated": datetime.utcnow().isoformat()
    }
}

# GET endpoint: Retrieve sensor data
@app.route('/api/v1/assets/<asset_id>/sensors', methods=['GET'])
@auth.login_required
def get_sensor_data(asset_id):
    if asset_id in sensor_data:
        return jsonify({
            "asset_id": asset_id,
            "data": sensor_data[asset_id],
            "timestamp": datetime.utcnow().isoformat()
        }), 200
    else:
        return jsonify({"error": "Asset not found"}), 404

# GET endpoint: Retrieve time-series data
@app.route('/api/v1/assets/<asset_id>/timeseries', methods=['GET'])
@auth.login_required
def get_timeseries(asset_id):
    # Query parameters
    start_time = request.args.get('start', default=None)
    end_time = request.args.get('end', default=None)
    metric = request.args.get('metric', default='vibration_rms')

    # Generate sample time-series data
    data_points = []
    for i in range(100):
        data_points.append({
            "timestamp": (datetime.utcnow().timestamp() - (100-i)*60) * 1000,  # milliseconds
            "value": 1.5 + random.gauss(0, 0.3)
        })

    return jsonify({
        "asset_id": asset_id,
        "metric": metric,
        "start_time": start_time,
        "end_time": end_time,
        "data": data_points
    }), 200

# POST endpoint: Update sensor data
@app.route('/api/v1/assets/<asset_id>/sensors', methods=['POST'])
@auth.login_required
def update_sensor_data(asset_id):
    data = request.get_json()

    if not data:
        return jsonify({"error": "Invalid JSON"}), 400

    # Update sensor data
    if asset_id not in sensor_data:
        sensor_data[asset_id] = {}

    sensor_data[asset_id].update(data)
    sensor_data[asset_id]["last_updated"] = datetime.utcnow().isoformat()

    return jsonify({
        "message": "Data updated successfully",
        "asset_id": asset_id,
        "data": sensor_data[asset_id]
    }), 200

# POST endpoint: Create alarm/alert
@app.route('/api/v1/alarms', methods=['POST'])
@auth.login_required
def create_alarm():
    data = request.get_json()

    required_fields = ['asset_id', 'severity', 'message']
    if not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    alarm = {
        "alarm_id": f"ALM_{int(datetime.utcnow().timestamp())}",
        "asset_id": data['asset_id'],
        "severity": data['severity'],
        "message": data['message'],
        "timestamp": datetime.utcnow().isoformat(),
        "acknowledged": False
    }

    # In production, save to database
    print(f"Alarm created: {alarm}")

    return jsonify(alarm), 201

# Health check endpoint
@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "healthy", "timestamp": datetime.utcnow().isoformat()}), 200

if __name__ == '__main__':
    # Enable HTTPS in production with SSL certificates
    # app.run(host='0.0.0.0', port=5000, ssl_context=('cert.pem', 'key.pem'))
    app.run(host='0.0.0.0', port=5000, debug=True)
```

### REST API Client (Python)

```python
import requests
from datetime import datetime, timedelta

# API configuration
BASE_URL = "https://api.example.com/api/v1"
API_TOKEN = "secret_token_123"

# Headers with authentication
headers = {
    "Authorization": f"Bearer {API_TOKEN}",
    "Content-Type": "application/json"
}

# GET request: Retrieve sensor data
def get_sensor_data(asset_id):
    url = f"{BASE_URL}/assets/{asset_id}/sensors"

    try:
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()  # Raise exception for HTTP errors

        data = response.json()
        print(f"Sensor data for {asset_id}:")
        print(f"  Vibration: {data['data']['vibration_rms']} mm/s")
        print(f"  Temperature: {data['data']['temperature']}°C")
        print(f"  Status: {data['data']['status']}")

        return data

    except requests.exceptions.HTTPError as e:
        print(f"HTTP Error: {e}")
    except requests.exceptions.RequestException as e:
        print(f"Request failed: {e}")

    return None

# GET request: Retrieve time-series data
def get_timeseries(asset_id, metric='vibration_rms', hours=24):
    url = f"{BASE_URL}/assets/{asset_id}/timeseries"

    end_time = datetime.utcnow()
    start_time = end_time - timedelta(hours=hours)

    params = {
        "metric": metric,
        "start": start_time.isoformat(),
        "end": end_time.isoformat()
    }

    try:
        response = requests.get(url, headers=headers, params=params, timeout=30)
        response.raise_for_status()

        data = response.json()
        print(f"Retrieved {len(data['data'])} data points for {metric}")

        return data['data']

    except requests.exceptions.RequestException as e:
        print(f"Request failed: {e}")

    return None

# POST request: Update sensor data
def update_sensor_data(asset_id, sensor_values):
    url = f"{BASE_URL}/assets/{asset_id}/sensors"

    try:
        response = requests.post(url, headers=headers, json=sensor_values, timeout=10)
        response.raise_for_status()

        print(f"Updated sensor data for {asset_id}")
        return response.json()

    except requests.exceptions.RequestException as e:
        print(f"Update failed: {e}")

    return None

# POST request: Create alarm
def create_alarm(asset_id, severity, message):
    url = f"{BASE_URL}/alarms"

    alarm_data = {
        "asset_id": asset_id,
        "severity": severity,
        "message": message
    }

    try:
        response = requests.post(url, headers=headers, json=alarm_data, timeout=10)
        response.raise_for_status()

        alarm = response.json()
        print(f"Created alarm {alarm['alarm_id']}: {message}")
        return alarm

    except requests.exceptions.RequestException as e:
        print(f"Alarm creation failed: {e}")

    return None

# Example usage
if __name__ == "__main__":
    # Get current sensor data
    get_sensor_data("motor101")

    # Get historical time-series
    timeseries = get_timeseries("motor101", metric="vibration_rms", hours=24)

    # Update sensor data
    update_sensor_data("motor101", {
        "vibration_rms": 2.1,
        "temperature": 65.5
    })

    # Create alarm
    create_alarm("motor101", "warning", "Vibration levels elevated")
```

---

## Protocol Gateway Implementations

### Modbus to MQTT Gateway

```python
from pymodbus.client import ModbusTcpClient
import paho.mqtt.client as mqtt
import json
import time
from datetime import datetime

class ModbusToMqttGateway:
    def __init__(self, modbus_host, modbus_port, mqtt_broker, mqtt_port):
        # Modbus client
        self.modbus_client = ModbusTcpClient(modbus_host, port=modbus_port)

        # MQTT client
        self.mqtt_client = mqtt.Client(client_id="modbus_gateway")
        self.mqtt_broker = mqtt_broker
        self.mqtt_port = mqtt_port

        # Sensor configuration
        self.sensors = [
            {
                "name": "vibration_sensor_1",
                "slave_id": 1,
                "register_address": 30000,
                "register_count": 2,
                "data_type": "float32",
                "mqtt_topic": "factory/line1/motor101/vibration",
                "poll_interval": 5
            },
            {
                "name": "temperature_sensor_1",
                "slave_id": 1,
                "register_address": 30002,
                "register_count": 1,
                "data_type": "int16",
                "scale_factor": 0.1,
                "mqtt_topic": "factory/line1/motor101/temperature",
                "poll_interval": 10
            }
        ]

        self.running = False

    def connect(self):
        # Connect to Modbus device
        if not self.modbus_client.connect():
            print("Failed to connect to Modbus device")
            return False
        print("Connected to Modbus device")

        # Connect to MQTT broker
        self.mqtt_client.connect(self.mqtt_broker, self.mqtt_port, 60)
        self.mqtt_client.loop_start()
        print("Connected to MQTT broker")

        return True

    def read_modbus_register(self, sensor_config):
        try:
            response = self.modbus_client.read_input_registers(
                address=sensor_config["register_address"],
                count=sensor_config["register_count"],
                slave=sensor_config["slave_id"]
            )

            if response.isError():
                print(f"Modbus read error for {sensor_config['name']}")
                return None

            # Parse based on data type
            if sensor_config["data_type"] == "float32":
                import struct
                raw_bytes = struct.pack('>HH', response.registers[0], response.registers[1])
                value = struct.unpack('>f', raw_bytes)[0]
            elif sensor_config["data_type"] == "int16":
                value = response.registers[0]
                if "scale_factor" in sensor_config:
                    value *= sensor_config["scale_factor"]
            else:
                value = response.registers[0]

            return value

        except Exception as e:
            print(f"Error reading Modbus: {e}")
            return None

    def publish_to_mqtt(self, topic, value, sensor_name):
        payload = {
            "sensor": sensor_name,
            "value": round(value, 3) if isinstance(value, float) else value,
            "timestamp": datetime.utcnow().isoformat() + "Z",
            "source": "modbus_gateway"
        }

        result = self.mqtt_client.publish(topic, json.dumps(payload), qos=1)

        if result.rc == mqtt.MQTT_ERR_SUCCESS:
            print(f"Published {sensor_name}: {value} to {topic}")
        else:
            print(f"MQTT publish failed for {sensor_name}")

    def run(self):
        if not self.connect():
            return

        self.running = True
        last_poll_time = {sensor["name"]: 0 for sensor in self.sensors}

        try:
            while self.running:
                current_time = time.time()

                for sensor in self.sensors:
                    # Check if it's time to poll this sensor
                    if current_time - last_poll_time[sensor["name"]] >= sensor["poll_interval"]:
                        value = self.read_modbus_register(sensor)

                        if value is not None:
                            self.publish_to_mqtt(
                                sensor["mqtt_topic"],
                                value,
                                sensor["name"]
                            )

                        last_poll_time[sensor["name"]] = current_time

                time.sleep(0.5)  # Small sleep to prevent CPU spinning

        except KeyboardInterrupt:
            print("Shutting down gateway...")
        finally:
            self.shutdown()

    def shutdown(self):
        self.running = False
        self.modbus_client.close()
        self.mqtt_client.loop_stop()
        self.mqtt_client.disconnect()
        print("Gateway shutdown complete")

# Run gateway
if __name__ == "__main__":
    gateway = ModbusToMqttGateway(
        modbus_host="192.168.1.100",
        modbus_port=502,
        mqtt_broker="broker.example.com",
        mqtt_port=1883
    )

    gateway.run()
```

### OPC UA to MQTT Gateway

```python
from opcua import Client, ua
import paho.mqtt.client as mqtt
import json
import time
from datetime import datetime

class OpcUaToMqttGateway:
    def __init__(self, opcua_url, mqtt_broker, mqtt_port):
        self.opcua_client = Client(opcua_url)
        self.mqtt_client = mqtt.Client(client_id="opcua_gateway")
        self.mqtt_broker = mqtt_broker
        self.mqtt_port = mqtt_port

        # Node mapping configuration
        self.node_mapping = [
            {
                "node_id": "ns=2;s=Machine1.VibrationRMS",
                "mqtt_topic": "factory/line1/machine1/vibration_rms",
                "name": "Vibration RMS"
            },
            {
                "node_id": "ns=2;s=Machine1.Temperature",
                "mqtt_topic": "factory/line1/machine1/temperature",
                "name": "Bearing Temperature"
            },
            {
                "node_id": "ns=2;s=Machine1.Status",
                "mqtt_topic": "factory/line1/machine1/status",
                "name": "Operational Status"
            }
        ]

        self.subscriptions = []

    def on_mqtt_connect(self, client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT broker")
        else:
            print(f"MQTT connection failed: {rc}")

    def connect(self):
        # Connect to OPC UA server
        try:
            self.opcua_client.connect()
            print("Connected to OPC UA server")
        except Exception as e:
            print(f"OPC UA connection failed: {e}")
            return False

        # Connect to MQTT broker
        self.mqtt_client.on_connect = self.on_mqtt_connect
        self.mqtt_client.connect(self.mqtt_broker, self.mqtt_port, 60)
        self.mqtt_client.loop_start()

        return True

    def create_subscription_handler(self, mapping):
        class SubHandler:
            def __init__(self, gateway, mapping):
                self.gateway = gateway
                self.mapping = mapping

            def datachange_notification(self, node, val, data):
                # Publish value change to MQTT
                payload = {
                    "node_id": str(node.nodeid),
                    "name": self.mapping["name"],
                    "value": val,
                    "timestamp": datetime.utcnow().isoformat() + "Z",
                    "source": "opcua_gateway",
                    "quality": "good"  # Could extract from data.monitored_item.Value.StatusCode
                }

                self.gateway.mqtt_client.publish(
                    self.mapping["mqtt_topic"],
                    json.dumps(payload, default=str),  # default=str handles non-JSON types
                    qos=1
                )

                print(f"Published {self.mapping['name']}: {val}")

        return SubHandler(self, mapping)

    def setup_subscriptions(self):
        try:
            # Create OPC UA subscription (500ms update interval)
            subscription = self.opcua_client.create_subscription(500, self.create_subscription_handler(self.node_mapping[0]))

            # Subscribe to each node
            for mapping in self.node_mapping:
                node = self.opcua_client.get_node(mapping["node_id"])
                handler = self.create_subscription_handler(mapping)
                handle = subscription.subscribe_data_change(node)
                self.subscriptions.append((subscription, handle))
                print(f"Subscribed to {mapping['name']}")

        except Exception as e:
            print(f"Subscription setup failed: {e}")

    def run(self):
        if not self.connect():
            return

        self.setup_subscriptions()

        try:
            # Keep running
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("Shutting down gateway...")
        finally:
            self.shutdown()

    def shutdown(self):
        # Clean up subscriptions
        for subscription, handle in self.subscriptions:
            subscription.unsubscribe(handle)
            subscription.delete()

        self.opcua_client.disconnect()
        self.mqtt_client.loop_stop()
        self.mqtt_client.disconnect()
        print("Gateway shutdown complete")

# Run gateway
if __name__ == "__main__":
    gateway = OpcUaToMqttGateway(
        opcua_url="opc.tcp://plc.example.com:4840",
        mqtt_broker="broker.example.com",
        mqtt_port=1883
    )

    gateway.run()
```

---

## Security Implementation

### TLS/SSL Configuration for MQTT

```python
import paho.mqtt.client as mqtt
import ssl

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Secure connection established")
        client.subscribe("factory/#")
    else:
        print(f"Connection failed: {rc}")

# Create MQTT client
client = mqtt.Client(client_id="secure_client_001")

# Username/password authentication
client.username_pw_set("username", "password")

# Configure TLS/SSL
client.tls_set(
    ca_certs="/path/to/ca.crt",  # Certificate Authority certificate
    certfile="/path/to/client.crt",  # Client certificate (for mutual TLS)
    keyfile="/path/to/client.key",  # Client private key
    cert_reqs=ssl.CERT_REQUIRED,  # Require server certificate
    tls_version=ssl.PROTOCOL_TLSv1_2,  # Use TLS 1.2 or higher
    ciphers=None  # Use default secure ciphers
)

# Optionally disable hostname verification (not recommended for production)
# client.tls_insecure_set(True)

client.on_connect = on_connect

# Connect to broker on secure port (8883 for MQTTS)
client.connect("broker.example.com", 8883, 60)
client.loop_forever()
```

### OPC UA Security Configuration

```python
from opcua import Client, ua
from cryptography import x509
from cryptography.hazmat.backends import default_backend

# Create client
client = Client("opc.tcp://server.example.com:4840")

# Set application URI and name
client.application_uri = "urn:example:client"
client.set_user("username")
client.set_password("password")

# Configure security policy and mode
client.set_security_string("Basic256Sha256,Sign,/path/to/client_cert.der,/path/to/client_key.pem")

# Or use Security Policy and Mode explicitly
# client.set_security(
#     security_policy=ua.SecurityPolicyType.Basic256Sha256,
#     certificate="/path/to/client_cert.der",
#     private_key="/path/to/client_key.pem",
#     server_certificate="/path/to/server_cert.der"
# )

try:
    client.connect()
    print("Secure OPC UA connection established")

    # Verify server certificate
    server_cert = client.get_server_certificate()
    print(f"Server certificate: {server_cert}")

    # Read data
    node = client.get_node("ns=2;s=SecureData")
    value = node.get_value()
    print(f"Secure data: {value}")

finally:
    client.disconnect()
```

### Certificate Generation Script

```bash
#!/bin/bash
# Generate certificates for OPC UA / MQTTS

# Set variables
DAYS_VALID=3650  # 10 years
COUNTRY="US"
STATE="California"
CITY="San Francisco"
ORG="Example Corp"
CN_CA="Example Root CA"
CN_SERVER="mqtt.example.com"
CN_CLIENT="client001"

# Create directories
mkdir -p certs
cd certs

# Generate CA private key and certificate
openssl genrsa -out ca.key 4096
openssl req -new -x509 -days $DAYS_VALID -key ca.key -out ca.crt \
    -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/CN=$CN_CA"

# Generate server private key and certificate signing request
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr \
    -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/CN=$CN_SERVER"

# Sign server certificate with CA
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out server.crt -days $DAYS_VALID

# Generate client private key and certificate
openssl genrsa -out client.key 2048
openssl req -new -key client.key -out client.csr \
    -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/CN=$CN_CLIENT"

openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out client.crt -days $DAYS_VALID

# Convert to DER format for OPC UA
openssl x509 -in server.crt -outform der -out server.der
openssl x509 -in client.crt -outform der -out client.der

# Set permissions
chmod 600 *.key
chmod 644 *.crt *.der

echo "Certificates generated successfully in ./certs/"
```

---

## Edge Computing Patterns

### Edge Analytics with Local ML Inference

```python
import numpy as np
from scipy import signal
from sklearn.ensemble import IsolationForest
import joblib
import time
from opcua import Client
import paho.mqtt.client as mqtt
import json

class EdgeAnalytics:
    def __init__(self, opcua_url, mqtt_broker):
        self.opcua_client = Client(opcua_url)
        self.mqtt_client = mqtt.Client(client_id="edge_analytics")
        self.mqtt_broker = mqtt_broker

        # Load pre-trained anomaly detection model
        self.model = joblib.load('/models/vibration_anomaly_model.pkl')

        # Feature extraction parameters
        self.sample_rate = 10000  # Hz
        self.window_size = 1024
        self.buffer = []

    def connect(self):
        self.opcua_client.connect()
        self.mqtt_client.connect(self.mqtt_broker, 1883, 60)
        self.mqtt_client.loop_start()

    def extract_features(self, waveform):
        """Extract frequency domain features from vibration waveform"""
        # Calculate FFT
        fft = np.fft.fft(waveform)
        freqs = np.fft.fftfreq(len(waveform), 1/self.sample_rate)
        magnitude = np.abs(fft[:len(fft)//2])
        freqs = freqs[:len(freqs)//2]

        # Time domain features
        rms = np.sqrt(np.mean(waveform**2))
        peak = np.max(np.abs(waveform))
        crest_factor = peak / rms if rms > 0 else 0
        kurtosis = np.mean((waveform - np.mean(waveform))**4) / (np.std(waveform)**4)

        # Frequency domain features
        peak_freq = freqs[np.argmax(magnitude)]
        spectral_centroid = np.sum(freqs * magnitude) / np.sum(magnitude)

        # Band power (specific frequency ranges for bearing faults)
        bearing_freq_range = (500, 2000)  # Hz
        mask = (freqs >= bearing_freq_range[0]) & (freqs <= bearing_freq_range[1])
        bearing_band_power = np.sum(magnitude[mask]**2)

        features = {
            'rms': rms,
            'peak': peak,
            'crest_factor': crest_factor,
            'kurtosis': kurtosis,
            'peak_freq': peak_freq,
            'spectral_centroid': spectral_centroid,
            'bearing_band_power': bearing_band_power
        }

        return features

    def detect_anomaly(self, features):
        """Use ML model to detect anomalies"""
        # Convert features to array format expected by model
        feature_array = np.array([[
            features['rms'],
            features['peak'],
            features['crest_factor'],
            features['kurtosis'],
            features['peak_freq'],
            features['spectral_centroid'],
            features['bearing_band_power']
        ]])

        # Predict (-1 for anomaly, 1 for normal)
        prediction = self.model.predict(feature_array)[0]
        anomaly_score = self.model.score_samples(feature_array)[0]

        return {
            'is_anomaly': prediction == -1,
            'anomaly_score': float(anomaly_score),
            'severity': 'high' if anomaly_score < -0.5 else 'medium' if anomaly_score < -0.2 else 'low'
        }

    def publish_results(self, asset_id, features, anomaly_result):
        """Publish analytics results to MQTT"""
        payload = {
            'asset_id': asset_id,
            'timestamp': time.time() * 1000,
            'features': {k: float(v) for k, v in features.items()},
            'anomaly_detection': anomaly_result,
            'edge_processed': True
        }

        # Publish to different topics based on result
        base_topic = f"analytics/{asset_id}"
        self.mqtt_client.publish(f"{base_topic}/features", json.dumps(payload), qos=1)

        if anomaly_result['is_anomaly']:
            self.mqtt_client.publish(f"{base_topic}/anomalies", json.dumps(payload), qos=1)
            print(f"⚠️  Anomaly detected on {asset_id}! Score: {anomaly_result['anomaly_score']:.3f}")

    def process_waveform(self, asset_id, waveform):
        """Main processing pipeline"""
        # Extract features
        features = self.extract_features(waveform)

        # Detect anomalies
        anomaly_result = self.detect_anomaly(features)

        # Publish results
        self.publish_results(asset_id, features, anomaly_result)

        return features, anomaly_result

    def run(self):
        self.connect()

        try:
            # Subscribe to waveform data from OPC UA
            waveform_node = self.opcua_client.get_node("ns=2;s=Motor101.VibrationWaveform")

            while True:
                # Read waveform (array of samples)
                waveform = waveform_node.get_value()

                if waveform and len(waveform) >= self.window_size:
                    self.process_waveform("motor101", np.array(waveform))

                time.sleep(1)  # Process every second

        except KeyboardInterrupt:
            print("Stopping edge analytics...")
        finally:
            self.opcua_client.disconnect()
            self.mqtt_client.disconnect()

# Run edge analytics
if __name__ == "__main__":
    analytics = EdgeAnalytics(
        opcua_url="opc.tcp://localhost:4840",
        mqtt_broker="broker.example.com"
    )
    analytics.run()
```

---

## Data Model Examples

### OPC UA Information Model (NodeSet XML)

```xml
<?xml version="1.0" encoding="utf-8"?>
<UANodeSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xmlns:uax="http://opcfoundation.org/UA/2008/02/Types.xsd"
           xmlns="http://opcfoundation.org/UA/2011/03/UANodeSet.xsd">

    <NamespaceUris>
        <Uri>http://example.com/ConditionMonitoring/</Uri>
    </NamespaceUris>

    <!-- Motor Object Type -->
    <UAObjectType NodeId="ns=1;i=1001" BrowseName="1:MotorType">
        <DisplayName>Motor Type</DisplayName>
        <References>
            <Reference ReferenceType="HasSubtype" IsForward="false">i=58</Reference>
            <Reference ReferenceType="HasComponent">ns=1;i=1002</Reference>
            <Reference ReferenceType="HasComponent">ns=1;i=1003</Reference>
            <Reference ReferenceType="HasComponent">ns=1;i=1004</Reference>
            <Reference ReferenceType="HasProperty">ns=1;i=1010</Reference>
        </References>
    </UAObjectType>

    <!-- Vibration RMS Variable -->
    <UAVariable NodeId="ns=1;i=1002" BrowseName="1:VibrationRMS" DataType="Double">
        <DisplayName>Vibration RMS</DisplayName>
        <References>
            <Reference ReferenceType="HasComponent" IsForward="false">ns=1;i=1001</Reference>
            <Reference ReferenceType="HasProperty">ns=1;i=1005</Reference>
            <Reference ReferenceType="HasProperty">ns=1;i=1006</Reference>
        </References>
    </UAVariable>

    <!-- Engineering Units Property -->
    <UAVariable NodeId="ns=1;i=1005" BrowseName="EngineeringUnits" DataType="i=887">
        <DisplayName>Engineering Units</DisplayName>
        <References>
            <Reference ReferenceType="HasProperty" IsForward="false">ns=1;i=1002</Reference>
        </References>
        <Value>
            <uax:ExtensionObject>
                <uax:TypeId>
                    <uax:Identifier>i=888</uax:Identifier>
                </uax:TypeId>
                <uax:Body>
                    <EUInformation xmlns="http://opcfoundation.org/UA/2008/02/Types.xsd">
                        <NamespaceUri>http://www.opcfoundation.org/UA/units/un/cefact</NamespaceUri>
                        <UnitId>4405559</UnitId>
                        <DisplayName>
                            <Locale></Locale>
                            <Text>mm/s</Text>
                        </DisplayName>
                        <Description>
                            <Locale></Locale>
                            <Text>millimeter per second</Text>
                        </Description>
                    </EUInformation>
                </uax:Body>
            </uax:ExtensionObject>
        </Value>
    </UAVariable>

    <!-- Alarm Threshold Property -->
    <UAVariable NodeId="ns=1;i=1006" BrowseName="1:AlarmThreshold" DataType="Double">
        <DisplayName>Alarm Threshold</DisplayName>
        <References>
            <Reference ReferenceType="HasProperty" IsForward="false">ns=1;i=1002</Reference>
        </References>
        <Value>
            <uax:Double>3.0</uax:Double>
        </Value>
    </UAVariable>

</UANodeSet>
```

### MTConnect Device XML

```xml
<?xml version="1.0" encoding="UTF-8"?>
<MTConnectDevices xmlns="urn:mtconnect.org:MTConnectDevices:1.7"
                  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                  xsi:schemaLocation="urn:mtconnect.org:MTConnectDevices:1.7">

    <Header creationTime="2025-11-17T12:00:00Z" sender="localhost" instanceId="1" version="1.7.0.1"/>

    <Devices>
        <Device id="motor101" name="Motor 101" uuid="M101-UUID-12345">

            <Description manufacturer="ABB" model="M3BP 315 SMB 4" serialNumber="ABC123456">
                Induction Motor - Production Line 1
            </Description>

            <DataItems>
                <DataItem category="CONDITION" id="motor_condition" type="SYSTEM" name="MotorCondition"/>
            </DataItems>

            <Components>

                <!-- Vibration Monitoring Component -->
                <Sensor id="vibration_sensor" name="Vibration Sensor" uuid="VIB-001-UUID">
                    <DataItems>
                        <DataItem category="SAMPLE" id="vibration_rms" type="VIBRATION" subType="RMS" units="MILLIMETER/SECOND">
                            <Constraints>
                                <Maximum>10.0</Maximum>
                            </Constraints>
                        </DataItem>

                        <DataItem category="SAMPLE" id="vibration_peak" type="VIBRATION" subType="PEAK" units="MILLIMETER/SECOND"/>

                        <DataItem category="EVENT" id="vibration_status" type="VIBRATION_STATUS">
                            <Constraints>
                                <Value>NORMAL</Value>
                                <Value>WARNING</Value>
                                <Value>ALARM</Value>
                            </Constraints>
                        </DataItem>
                    </DataItems>
                </Sensor>

                <!-- Temperature Monitoring Component -->
                <Sensor id="temp_sensor" name="Bearing Temperature" uuid="TEMP-001-UUID">
                    <DataItems>
                        <DataItem category="SAMPLE" id="bearing_temp" type="TEMPERATURE" units="CELSIUS">
                            <Constraints>
                                <Minimum>0</Minimum>
                                <Maximum>120</Maximum>
                            </Constraints>
                        </DataItem>

                        <DataItem category="CONDITION" id="temp_condition" type="TEMPERATURE"/>
                    </DataItems>
                </Sensor>

                <!-- Operational Status Component -->
                <Controller id="controller" name="Motor Controller" uuid="CTRL-001-UUID">
                    <DataItems>
                        <DataItem category="EVENT" id="exec_state" type="EXECUTION">
                            <Constraints>
                                <Value>READY</Value>
                                <Value>ACTIVE</Value>
                                <Value>INTERRUPTED</Value>
                                <Value>STOPPED</Value>
                            </Constraints>
                        </DataItem>

                        <DataItem category="SAMPLE" id="load" type="LOAD" units="PERCENT"/>

                        <DataItem category="EVENT" id="emergency_stop" type="EMERGENCY_STOP"/>
                    </DataItems>
                </Controller>

            </Components>
        </Device>
    </Devices>

</MTConnectDevices>
```

---

**Document Version**: 1.0
**Companion To**: Industrial Communication Protocols Encyclopedia & Quick Reference Guide
**Last Updated**: 2025-11-17
**Note**: All code examples are for educational purposes. Production implementations should include proper error handling, logging, security hardening, and compliance with relevant standards.
