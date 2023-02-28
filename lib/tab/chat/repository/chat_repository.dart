import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hunt_me/Models/contacts_model.dart';
import 'package:hunt_me/Models/message_model.dart';
import 'package:hunt_me/utills/message_enum.dart';
import 'package:uuid/uuid.dart';

import '../../../Models/user_model.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance),
);

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({required this.firestore, required this.auth});
  void saveMessagetoMessageSubCollection({
    required String receiverId,
    required String text,
  }) async {
    try {
      var messageId = const Uuid().v1();
      var timesent = DateTime.now();
      var receiverUserData =
          await firestore.collection('users').doc(receiverId).get();
      var receiverData = UserModel.fromMap(receiverUserData.data()!);
      var senderUserData =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
      var senderData = UserModel.fromMap(senderUserData.data()!);
      final message = Message(
          senderId: senderData.uid,
          recieverId: receiverData.uid,
          text: text,
          type: MessageEnum.text,
          timeSent: timesent,
          messageId: messageId,
          isSeen: false);
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());
      await firestore
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .set(message.toMap());
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  void _sendMessageToContact(
    UserModel senderModel,
    String text,
    UserModel receiverModel,
    DateTime timeSend,
    String receiverUserId,
  ) async {
    // users -> reciever user id => chats -> current user id -> set data
    var timesent = DateTime.now();
    var receiverChatContact = ContactMessage(
        text: text,
        userId: senderModel.uid,
        timeSend: timesent,
        bio: senderModel.bio,
        profilePic: senderModel.profilePic,
        name: senderModel.name);
    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(
          receiverChatContact.toMap(),
        );
    // users -> current user id   => chats ->reciever user id -> set data
    var senderChatContact = ContactMessage(
        text: text,
        userId: receiverModel.uid,
        timeSend: timeSend,
        bio: receiverModel.bio,
        profilePic: receiverModel.profilePic,
        name: receiverModel.name);
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  void sendTextMssage(
      {required String receiveruid,
      required String text,
      required UserModel userModel}) async {
    try {
      var timeSend = DateTime.now();
      var recesiverUserData =
          await firestore.collection('users').doc(receiveruid).get();
      var receiverData = UserModel.fromMap(recesiverUserData.data()!);
      _sendMessageToContact(
          userModel, text, receiverData, timeSend, receiveruid);
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  Stream<List<ContactMessage>> getContactsData() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .map((event) {
      List<ContactMessage> contactData = [];
      for (var documents in event.docs) {
        contactData.add(
          ContactMessage.fromMap(documents.data()),
        );
      }
      return contactData;
    });
  }

  Stream<List<Message>> getMessageData(String recesiverId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recesiverId)
        .collection('message')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messageData = [];
      for (var document in event.docs) {
        messageData.add(Message.fromMap(document.data()));
      }
      return messageData;
    });
  }

  void deleteMessage(String receiverUser, String messageId) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUser)
        .collection('messages')
        .doc(messageId)
        .delete();
    await firestore
        .collection('users')
        .doc(receiverUser)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  void deleteChatCard(String receiverId) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .delete();
    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(auth.currentUser!.uid)
        .delete();
  }
}
