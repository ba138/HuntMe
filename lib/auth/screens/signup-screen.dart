// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/auth/controller/auth_controller.dart';
import 'package:hunt_me/utills/colors.dart';

import '../../utills/pick_image_from_gallery.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();

  File? image;
  bool isLoading = false;
  void pickImage() async {
    setState(() async {
      image = await pickImageFromGallery(context);
    });
  }

  void createUser() async {
    String name = nameController.text.trim();
    String bio = bioController.text.trim();
    String email = emailController.text.trim();
    String number = numberController.text.trim();
    String password = passwordController.text.trim();

    ref.watch(authControllerProvider).saveData(
          name,
          bio,
          email,
          number,
          image,
          context,
          password,
        );
  }

  @override
  void dispose() {
    super.dispose();
    bioController.dispose();
    emailController.dispose();
    nameController.dispose();
    numberController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                        child: image == null
                            ? const CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://nakedsecurity.sophos.com/wp-content/uploads/sites/2/2013/08/facebook-silhouette_thumb.jpg',
                                ),
                                radius: 64,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  image!,
                                ),
                                radius: 64,
                              )),
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
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'please enter your Name',
                      labelText: 'User Name'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: bioController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'please enter your bio',
                      labelText: 'Bio'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'please enter your Email',
                      labelText: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: numberController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'please enter your Number',
                      labelText: 'Number'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'please enter your Password',
                      labelText: 'Password'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    createUser();
                  },
                  child: Container(
                    height: 64,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: isLoading
                        ? const Text(
                            'Wait',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: buttonColor),
                          )
                        : const Center(
                            child: Text(
                              'create',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: buttonColor),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
