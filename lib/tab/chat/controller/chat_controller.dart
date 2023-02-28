import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/Models/contacts_model.dart';
import 'package:hunt_me/tab/chat/repository/chat_repository.dart';

import '../../../Models/message_model.dart';
import '../../../auth/controller/auth_controller.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({required this.chatRepository, required this.ref});
  void sendTextMessage(String receiveruid, String text) {
    ref.read(getDataProvider).whenData((value) {
      chatRepository.sendTextMssage(
        receiveruid: receiveruid,
        text: text,
        userModel: value!,
      );
    });
  }

  void saveMessage(String receiverId, String text) {
    chatRepository.saveMessagetoMessageSubCollection(
      receiverId: receiverId,
      text: text,
    );
  }

  Stream<List<ContactMessage>> getContactsData() {
    return chatRepository.getContactsData();
  }

  Stream<List<Message>> getMessage(String recesiverId) {
    return chatRepository.getMessageData(recesiverId);
  }

  void deleteMessage(String receiverUser, String messageId) {
    chatRepository.deleteMessage(receiverUser, messageId);
  }

  void deleteChatCard(String receiverId) {
    chatRepository.deleteChatCard(receiverId);
  }
}
