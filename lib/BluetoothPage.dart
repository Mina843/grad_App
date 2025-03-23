import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'MainMenuPage.dart';
import 'control_page.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {

  final _bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  bool _isScanning = false;

  void _navigateToControlPage() {
    if (_connection != null && _connection!.isConnected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainMenuPage(connection: _connection)!),


      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ يرجى الاتصال بجهاز البلوتوث أولاً!")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });
    _bluetooth.onStateChanged().listen((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });
  }
  void disableBluetooth() async {
    if (await Permission.bluetoothConnect.isGranted) {
      await FlutterBluetoothSerial.instance.requestDisable();
    } else {
      print("يجب منح إذن BLUETOOTH_CONNECT أولاً!");
    }
  }



  Future<void> requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
    ].request();
  }


  Future<void> _getDevices() async {
    setState(() => _isScanning = true);
    var res = await _bluetooth.getBondedDevices();
    setState(() {
      _devices = res;
      _isScanning = false;
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    setState(() => _isConnecting = true);
    try {
      _connection = await BluetoothConnection.toAddress(device.address);
      setState(() {
        _deviceConnected = device;
        _isConnecting = false;
      });
      print("✅ متصل بجهاز البلوتوث: \${device.name}");
    } catch (e) {
      setState(() => _isConnecting = false);
      print("❌ خطأ في الاتصال: $e");
    }
  }

  void _sendData(String data) async {
    if (_connection != null && _connection!.isConnected) {
      _connection!.output.add(ascii.encode(data));
      await _connection!.output.allSent;
      print("📡 تم إرسال: $data");
    } else {
      print("⚠️ غير متصل بالبلوتوث!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth Control')),
      body: Column(
        children: [
          SwitchListTile(
            title: Text(_bluetoothState ? "Bluetooth ON" : "Bluetooth OFF"),
            value: _bluetoothState,
            onChanged: (value) async {
              value ? await _bluetooth.requestEnable() : await _bluetooth.requestDisable();
            },
          ),
          ListTile(
            title: Text("Connected to: \${_deviceConnected?.name ?? None}"),
            trailing: _connection?.isConnected ?? false
                ? TextButton(
              onPressed: () async {
                await _connection?.finish();
                setState(() => _deviceConnected = null);
              },
              child: const Text("Disconnect"),
            )
                : _isScanning
                ? const CircularProgressIndicator()
                : TextButton(
              onPressed: _getDevices,
              child: const Text("Scan Devices"),
            ),
          ),
          _isConnecting
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView(
              children: _devices.map((device) {
                return ListTile(
                  title: Text(device.name ?? device.address),
                  trailing: TextButton(
                    child: const Text("Connect"),
                    onPressed: () => _connectToDevice(device),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _navigateToControlPage,
              child: const Text("Main Menu"),
            ),
          ),
        ],
      ),
    );
  }
}
