import 'package:calling_feature_socket/webrtc_server.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'webrtc_service.dart';

class SocketService {
  IO.Socket? socket;
  WebRTCService webRTCService = WebRTCService();

  void connect() {
    // Step 1: Initialize the socket
    socket = IO.io('http://192.168.1.4:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Step 2: Connect to the server
    socket!.connect();

    // Step 3: Handle socket events
    socket!.onConnect((_) {
      print('Connected to server');
    });

    socket!.onDisconnect((_) {
      print('Disconnected from server');
    });

    // Step 4: Listen for incoming calls
    socket!.on('incomingCall', (data) {
      print('Incoming call from: ${data['from']}');
      // Trigger WebRTC service to handle the incoming call
      webRTCService.handleIncomingCall(data['offer']);
    });
  }

  void makeCall(String to) {
    print('this is the id : ${to}');
    socket!.emit('call', {'from': socket!.id, 'to': to});
  }

  void disconnect() {
    socket!.disconnect();
  }
}
