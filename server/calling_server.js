// Step 1: Import the necessary libraries
const express = require('express'); // For creating the server
const http = require('http'); // For creating an HTTP server
const socketIo = require('socket.io'); // For WebSocket functionality


// Step 2: Set up the Express app and the server
const app = express();
const server = http.createServer(app);
const io = socketIo(server); // Attach Socket.IO to the server
const users = {};  // To store users and their socket IDs

// Step 3: Set up a basic connection event
io.on('connection', (socket) => {
    console.log('A user connected: ' + socket.id); // Log when a user connects
      // When a user connects, add them to the user list (you may want to add more user info like username)
      
    // step 5 registration
    socket.on('register', (username) => {
        users[username] = socket.id;
        console.log(users); // Log the current users
    });
    // Step 4: Handle incoming call requests
    socket.on('call', (data) => {
        console.log('Call request from: ' + data.from + ' to: ' + data.to);
        socket.to(data.to).emit('incomingCall', { from: data.from }); // Notify the recipient
    });

    // Step 5: Handle disconnection
    socket.on('disconnect', () => {
        console.log('A user disconnected: ' + socket.id); // Log when a user disconnects
    });
});

// Step 6: Start the server
const PORT = process.env.PORT || 3000; // Use the environment port or default to 3000
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`); // Log when the server starts
});
