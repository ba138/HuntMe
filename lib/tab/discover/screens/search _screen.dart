import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utills/colors.dart';
import '../../../utills/loader.dart';
import '../../chat/screens/mobile_chat_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/discover_controller.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String post = 'post';
  String user = 'users';
  String query = '';
  String dateFormat(Timestamp postTime) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(postTime.seconds * 1000);
    return DateFormat().format(dateTime);
  }

  bool allJobs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 8 / 2,
                      width: MediaQuery.of(context).size.width / 0.6 / 2 - 16,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            query = val.toLowerCase().trim();
                            allJobs = false;
                          });
                        },
                        decoration: const InputDecoration(
                            hintText: 'Search by tag/keyword',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                            disabledBorder: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_1_outlined),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                allJobs
                    ? StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('post')
                            .snapshots(),
                        // ref.watch(discoverControllerProvider).getJob(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Loader(),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('No Jobs To Show'),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              var gigData = snapshot.data!.docs[index];

                              return Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        4 /
                                        2,
                                    width: MediaQuery.of(context).size.width /
                                        0.5 /
                                        2,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 206, 201, 201)
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                gigData['title'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    gigData['jobType'],
                                                  ),
                                                  const Icon(
                                                    Icons.location_on,
                                                  ),
                                                  Text(
                                                    gigData['location'],
                                                  ),
                                                ],
                                              ),
                                              Text(dateFormat(
                                                  gigData['postTime'])),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FirebaseAuth.instance.currentUser!
                                                          .uid ==
                                                      gigData['userId']
                                                  ? Container(
                                                      color: Colors.transparent,
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (c) =>
                                                                MobileChatScreen(
                                                              bio: gigData[
                                                                  'bio'],
                                                              name: gigData[
                                                                  'name'],
                                                              profilePic: gigData[
                                                                  'profilePic'],
                                                              uid: gigData[
                                                                  'userId'],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 70,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: buttonColor,
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            'Chat',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        0.5 /
                                        2,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 206, 201, 201)
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Description',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              gigData['discrption'],
                                              maxLines: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    : StreamBuilder<QuerySnapshot>(
                        stream: ref
                            .watch(discoverControllerProvider)
                            .searchQuery(query),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Loader(),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('no data to show'),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var gigData = snapshot.data!.docs[index];

                              return Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        4 /
                                        2,
                                    width: MediaQuery.of(context).size.width /
                                        0.5 /
                                        2,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 206, 201, 201)
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                gigData['title'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    gigData['jobType'],
                                                  ),
                                                  const Icon(
                                                    Icons.location_on,
                                                  ),
                                                  Text(
                                                    gigData['location'],
                                                  ),
                                                ],
                                              ),
                                              Text(dateFormat(
                                                  gigData['postTime'])),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (c) =>
                                                          MobileChatScreen(
                                                        bio: gigData['bio'],
                                                        name: gigData['name'],
                                                        profilePic: gigData[
                                                            'profilePic'],
                                                        uid: gigData['userId'],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: buttonColor,
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Chat',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        0.5 /
                                        2,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 206, 201, 201)
                                          .withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Description',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              gigData['discrption'],
                                              maxLines: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
