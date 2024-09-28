import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;

  // Step 1: Initialize the WebRTC connection
  Future<void> initialize() async {
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
    });

    // Step 2: Create a peer connection
    _peerConnection = await createPeerConnection({});

    // Step 3: Add local stream to the connection
    _peerConnection!.addStream(_localStream!);

    // Handle remote stream
    _peerConnection!.onAddStream = (stream) {
      // You can handle the remote stream here (e.g., play audio)
    };
  }

  // Step 4: Make a call
  Future<void> makeCall(String offer) async {
    // Step 5: Set remote description
    await _peerConnection!.setRemoteDescription(RTCSessionDescription(offer, 'offer'));

    // Step 6: Create an answer
    RTCSessionDescription answer = await _peerConnection!.createAnswer();
    await _peerConnection!.setLocalDescription(answer);

    // Emit the answer back to the caller
    // Use your Socket.IO instance to emit the answer here
  }

  // Step 7: Handle the incoming call
  void handleIncomingCall(String offer) {
    // Set remote description and create an answer
    makeCall(offer);
  }
}
