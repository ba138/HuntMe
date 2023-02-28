import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/Models/user_model.dart';
import 'package:hunt_me/home/home.dart';

import '../../../utills/loader.dart';
import '../../../utills/pick_image_from_gallery.dart';
import '../../job/controller/job_Controller.dart';
import '../controller/setting_controller.dart';

class UserDailScreen extends ConsumerStatefulWidget {
  const UserDailScreen({super.key});

  @override
  ConsumerState<UserDailScreen> createState() => _UserDailScreenState();
}

class _UserDailScreenState extends ConsumerState<UserDailScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final educationController = TextEditingController();
  final languagesController = TextEditingController();
  final skillController = TextEditingController();
  File? image;
  bool isLoading = false;
  void pickImage() async {
    setState(() async {
      image = await pickImageFromGallery(context);
    });
  }

  void updateUserDetails(
    String name,
    String uid,
    File? profilePic,
    String phoneNumber,
    String bio,
    String email,
  ) {
    ref.watch(settingControllerProvider).updateUserDetails(
          name,
          uid,
          profilePic,
          phoneNumber,
          bio,
          email,
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: StreamBuilder<UserModel>(
            stream: ref.watch(jobController).getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Loader(),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No Data to show'),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: image == null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    snapshot.data!.profilePic,
                                  ),
                                  radius: 64,
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    image!,
                                  ),
                                  radius: 64,
                                ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 80,
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            onPressed: pickImage,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          hintText: 'User Name',
                          labelText: snapshot.data!.name),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: bioController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          hintText: 'Bio',
                          labelText: snapshot.data!.bio),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          hintText: 'Email',
                          labelText: snapshot.data!.email),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: numberController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          hintText: 'Number',
                          labelText: snapshot.data!.phoneNumber),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(32),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                                backgroundColor: Colors.transparent,
                                fontSize: 24,
                                color: Colors.grey),
                            minimumSize: const Size.fromHeight(56),
                            shape: const StadiumBorder()),
                        child: isLoading
                            ? const Text('Wait')
                            : const Text('Update'),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          if (nameController.text.isEmpty) {
                            nameController.text = snapshot.data!.name;
                          }
                          if (numberController.text.isEmpty) {
                            numberController.text = snapshot.data!.phoneNumber;
                          }
                          if (bioController.text.isEmpty) {
                            bioController.text = snapshot.data!.bio;
                          }
                          if (emailController.text.isEmpty) {
                            emailController.text = snapshot.data!.email;
                          }

                          updateUserDetails(
                            nameController.text.trim(),
                            snapshot.data!.uid,
                            image,
                            numberController.text.trim(),
                            bioController.text.trim(),
                            emailController.text.trim(),
                          );

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const Home(),
                              ),
                              (route) => false);
                        },
                      ),
                    )
                  ],
                ),
              );
            }),
      )),
    );
  }
}
