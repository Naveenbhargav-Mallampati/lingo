import 'package:flutter/material.dart';
import 'package:mobile_chat_ui/custom_widgets/chat_input.dart';
import 'package:mobile_chat_ui/mobile_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_chat_ui/models/chat_theme.dart';
import 'package:mobile_chat_ui/models/user.dart';

import 'package:mobile_chat_ui/models/messages/message.dart';

class ChatArea extends ConsumerWidget {
  final User loggedInUser = User(
    id: "GtIqnUfq0KY5GfR6mD25jlVyNlDdl",
    name: "Putra Silas",
    avatarUrl: "https://randomuser.me/api/portraits/women/92.jpg",
  );

  final messages = StateProvider((ref) {
    return <Message>[];
  });

  ChatArea({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(child: Text("Mobile Chat UI"))),
      body: Chat(
        user: loggedInUser,
        messages: ref.watch(messages),
        onSend: (message) {
          ref.read(messages.notifier).state = [
            ...ref.read(messages.notifier).state,
            message
          ];
        },
        theme: DefaultChatTheme(
          userAvatarRadius: 12,
        ),
        input: ChatInput(
          onSend: (message) {
            ref.read(messages.notifier).state = [
              ...ref.read(messages.notifier).state,
              message
            ];
          },
          user: loggedInUser,
          padding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
