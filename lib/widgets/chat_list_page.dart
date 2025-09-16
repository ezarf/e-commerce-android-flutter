import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/chat_detail_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/shop.jpg'),
            ),
            title: Text(
              index == 0 ? 'Customer Service' : 'Fashion Store ${index + 1}',
              style: TextStyle(
                fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(
              index == 0
                  ? 'Hello, how can I help you?'
                  : 'Your order has been shipped',
              style: TextStyle(
                fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                color: index == 0 ? Colors.black : Colors.grey,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${index + 1}h ago',
                  style: TextStyle(
                    color: index == 0 ? Colors.deepPurple : Colors.grey,
                    fontSize: 12,
                  ),
                ),
                if (index == 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatDetailPage()),
              );
            },
          );
        },
      ),
    );
  }
}