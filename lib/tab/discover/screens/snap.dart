import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/utills/gig_card.dart';

class Snap extends ConsumerStatefulWidget {
  const Snap({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SnapState();
}

class _SnapState extends ConsumerState<Snap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Jobs',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                GigsCard(),
              ],
            ),
          ),
        )));
  }
}
