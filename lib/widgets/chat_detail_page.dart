import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_application_2/models/chat_message.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [
    ChatMessage(
        text: 'Hello, I have a question about my order',
        isMe: true,
        time: '10:30 AM'),
    ChatMessage(
        text: 'Hello, how can I help you?',
        isMe: false,
        time: '10:32 AM'),
    ChatMessage(
        text: 'I ordered a blue t-shirt but received a red one',
        isMe: true,
        time: '10:33 AM'),
    ChatMessage(
        text:
            'I apologize for the inconvenience. We can arrange a return and send you the correct item.',
        isMe: false,
        time: '10:35 AM'),
  ];

  bool _isTyping = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isMe: true,
        time: 'Now',
      ));
      _messageController.clear();
    });

    _scrollToBottom();
    _simulateTypingAndReply();
  }

  void _simulateTypingAndReply() {
    setState(() => _isTyping = true);
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(
          text: 'Thank you for the info. We’ll handle it shortly.',
          isMe: false,
          time: 'Now',
        ));
      });
      _scrollToBottom();
    });
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: message.isMe ? Colors.deepPurple : Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(message.isMe ? 16 : 0),
          bottomRight: Radius.circular(message.isMe ? 0 : 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.text,
            style: TextStyle(
              color: message.isMe ? Colors.white : Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              message.time,
              style: TextStyle(
                color: message.isMe ? Colors.white70 : Colors.grey,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Customer is typing...',
          style: TextStyle(color: Colors.black54, fontSize: 13),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: const [
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/shop.png'),
            ),
            SizedBox(width: 8),
            Text('Customer Service'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return _buildTypingIndicator();
                }
                final msg = _messages[index];
                return Align(
                  alignment:
                      msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: _buildMessageBubble(msg),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  onPressed: () {},
                  color: Colors.deepPurple,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
