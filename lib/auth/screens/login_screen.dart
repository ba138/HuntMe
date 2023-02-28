import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/auth/controller/auth_controller.dart';
import 'package:hunt_me/auth/screens/signup-screen.dart';
import 'package:hunt_me/utills/colors.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool isSecure = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() {
    ref.watch(authControllerProvider).loginUser(
          _passwordController.text.trim(),
          _emailController.text.trim(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 6.5,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/h m logo-01.png'),
                          fit: BoxFit.fill)),
                ),
                const Text(
                  'HUNT ME',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff568DD6),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: 'please enter your email',
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 7 / 2,
                  child: TextFormField(
                    obscureText: isSecure,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      hintText: 'please enter your paaaword',
                      labelText: 'Password',
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            isSecure = true;
                          });
                        },
                        icon: Icon(
                            isSecure ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    loginUser();
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
                                color: buttonColor,
                                fontWeight: FontWeight.bold),
                          )
                        : const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: buttonColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don,t have Account?'),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const SignUpScreen(),
                          ),
                        );
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: buttonColor,
                            )
                          : const Text(
                              'SignUp',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
