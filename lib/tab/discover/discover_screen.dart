import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/tab/discover/screens/search%20_screen.dart';
import 'package:hunt_me/tab/discover/screens/service_screen.dart';
import 'package:hunt_me/tab/discover/screens/snap.dart';
import 'package:hunt_me/tab/job/screens/job_post_screen.dart';
import 'package:hunt_me/utills/gig_card.dart';
import 'package:hunt_me/utills/loader.dart';
import 'package:hunt_me/utills/search_container.dart';
import 'package:hunt_me/utills/service_card.dart';

import '../job/controller/job_Controller.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height / 10 / 4,
                ),
                StreamBuilder(
                    stream: ref.watch(jobController).getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loader();
                      }
                      if (!snapshot.hasData) {
                        const Text('No User To Display');
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(snapshot.data!.profilePic),
                          ),
                          SizedBox(
                            width: size.width * 0.1 - 30,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data!.bio,
                              ),
                              Text(
                                snapshot.data!.phoneNumber,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: size.height / 50,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const SearchScreen()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 8 / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: const [
                          Icon(Icons.search),
                          SizedBox(
                            width: 12,
                          ),
                          Text('Search here'),
                        ],
                      ),
                    ),
                  ),
                ),
                // const BarForSearch(),
                SizedBox(
                  height: size.height / 70 + 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'people Nearby',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const JobPost(),
                          ),
                        );
                      },
                      child: const Text('post +'),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height / 70 + 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const KeyContainer(
                      title: 'All',
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => const Snap()));
                      },
                      child: const KeyContainer(
                        title: 'Jobs',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const ServiceScreen()));
                      },
                      child: const KeyContainer(
                        title: 'Services',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 70 + 3,
                ),
                const Text(
                  'Jobs',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height / 70 + 3,
                ),
                const GigsCard(),
                SizedBox(
                  height: size.height / 70 + 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Services',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 70 + 3,
                ),
                const ServiceCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
