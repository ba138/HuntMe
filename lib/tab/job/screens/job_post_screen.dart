import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/utills/colors.dart';
import 'package:hunt_me/utills/search_container.dart';

import '../../../home/home.dart';
import '../controller/job_Controller.dart';

class JobPost extends ConsumerStatefulWidget {
  const JobPost({super.key});

  @override
  ConsumerState<JobPost> createState() => _JobPostState();
}

class _JobPostState extends ConsumerState<JobPost> {
  int countWord({required String text}) {
    final trimmedText = text.trim();

    if (trimmedText.isEmpty) {
      return 0;
    } else {
      return trimmedText.split(RegExp('\\S=')).length;
    }
  }

  int _radio1 = 1;
  String gigiValu = 'gigs';
  bool isLoading = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController multiController = TextEditingController();
  static const menuItems = <String>[
    'Remotely',
    'Onsite',
    'Hybired',
  ];
  static const jobMenu = <String>[
    'General Labour',
    'Construction and Trades',
    'Driver and Secuirty',
    'Child Care',
    'Bar,Food & Hospitality',
    'Adimn/Office',
    'Accounting and Finance',
    'Health Care',
    'Cleaning and HouseKeeping',
    'Sales and Retail Sales',
    'Customer Service',
    'Part Time & Student',
    'Programmers & Computer',
    'Salon & Beauty',
    'Graphic & Web Development',
    'TV,Media & Fashion',
    'Legal/Paralegal',
    'Other',
  ];
  final List<DropdownMenuItem<String>> jobMenuItems = jobMenu
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<DropdownMenuItem<String>> dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  String btn1SelectedVal = 'Onsite';
  String jobVal = 'General Labour';
  void postJob() {
    // if (titleController.text.isNotEmpty &&
    //     locationController.text.isEmpty &&
    //     multiController.text.isEmpty) {
    ref.watch(jobController).postJob(
          gigiValu,
          titleController.text.trim(),
          btn1SelectedVal,
          locationController.text.trim(),
          jobVal,
          multiController.text.trim(),
        );
    // } else {
    //   Fluttertoast.showToast(msg: 'Please fill all the Fields');
    // }
  }

  bool isSpin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Post',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: isSpin
              ? const Center(
                  child: CircularProgressIndicator(
                    color: buttonColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: 1,
                              groupValue: _radio1,
                              onChanged: (value) {
                                setState(() {
                                  _radio1 = value!;
                                  gigiValu = 'Gigs';
                                });
                              }),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('Gigs')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: 2,
                              groupValue: _radio1,
                              onChanged: (value) {
                                setState(() {
                                  _radio1 = value!;
                                  gigiValu = 'Services';
                                });
                              }),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('Services')
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Gigs',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff717171),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            hintText: 'Add the title you are hiring for',
                            labelText: 'Title'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: multiController,
                        maxLines: 10,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          counterText:
                              '${countWord(text: multiController.text)}words',
                          labelText: 'Discription',
                          hintText: 'Enter the discription',
                          alignLabelWithHint: true,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text(
                            'workplace type',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff717171),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 7 / 2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            elevation: 0,
                            items: dropDownMenuItems,
                            value: btn1SelectedVal,
                            onChanged: (String? value) {
                              if (value != null) {
                                setState(() {
                                  btn1SelectedVal = value;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Job Location',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff717171),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textAlign: TextAlign.start,
                        controller: locationController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            hintText: 'Enter your Job Location',
                            labelText: 'Location'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Job Type',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff717171),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 7 / 2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            elevation: 0,
                            items: jobMenuItems,
                            value: jobVal,
                            onChanged: (String? value) {
                              if (value != null) {
                                setState(() {
                                  jobVal = value;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          postJob();

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const Home(),
                              ),
                              (route) => false);
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: const KeyContainer(title: 'Post'),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
