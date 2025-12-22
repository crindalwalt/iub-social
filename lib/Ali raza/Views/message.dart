import 'package:flutter/material.dart';

class MessengerChatScreen extends StatefulWidget {
  const MessengerChatScreen({super.key});

  @override
  State<MessengerChatScreen> createState() => _MessengerChatScreenState();
}

class _MessengerChatScreenState extends State<MessengerChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final Color primaryBlue = const Color(0xFF1877F2); // Messenger blue
  final Color lightBlue = const Color(0xFFE8F1FF);

  final List<Map<String, dynamic>> messages = [
    {"text": "Hey, what's up?", "isMe": false, "time": "09:41"},
    {"text": "All good! Working on our new app 😄", "isMe": true, "time": "09:42"},
    {"text": "Nice! Can't wait to see it.", "isMe": false, "time": "09:44"},
    {"text": "Yeah, it’s coming along great!", "isMe": true, "time": "09:45"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leadingWidth: 30,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {},
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/profile.jpg'),
              backgroundColor: Colors.grey,
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John Doe",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Active now",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.call, color: Colors.black54)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.videocam, color: Colors.black54)),
        ],
      ),

      // Messages
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg["isMe"];

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe ? primaryBlue : lightBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft:
                            isMe ? const Radius.circular(16) : Radius.zero,
                        bottomRight:
                            isMe ? Radius.zero : const Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          msg["text"],
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg["time"],
                          style: TextStyle(
                            color: isMe ? Colors.white70 : Colors.black45,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined,
                      color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_outlined,
                        color: Colors.grey)),
                const SizedBox(width: 2),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: primaryBlue,
                  child:
                      const Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
