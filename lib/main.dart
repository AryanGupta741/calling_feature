import 'package:calling_feature_socket/socket_server.dart';
import 'package:flutter/material.dart';
// import 'services/socket_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SocketService socketService = SocketService();

  @override
  Widget build(BuildContext context) {
    // Step 1: Connect to the socket
    socketService.connect();
   // Step 2: Initialize WebRTC service
    socketService.webRTCService.initialize();
    return MaterialApp(
      title: 'Voice Calling App',
      home: Scaffold(
        appBar: AppBar(title: Text('Voice Calling App')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Example: Make a call to a specific user
              socketService.makeCall('userSocketId');
            },
            child: Text('Make Call'),
          ),
        ),
      ),
    );
  }
}
