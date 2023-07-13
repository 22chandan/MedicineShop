import 'package:flutter/material.dart';

import 'Medicinedesign.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> Tablets = ["Calpol 500mg Tablet"];
    List<String> Timing = [
      "Before Breakfast",
      "After Food",
      "Before Sleep",
    ];
    List<String> done = [
      "Taken",
      "Missed",
      "Snoozed",
      "Left",
    ];
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Morning 08:00 am",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          Medicine(
            cl: Colors.pink,
            Day: '01',
            Med: Tablets[0],
            done: done[0],
            Time: Timing[0],
          ),
          Medicine(
            cl: Colors.blue,
            Day: '27',
            Med: Tablets[0],
            done: done[1],
            Time: Timing[0],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Afternoon 02:00 pm",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          Medicine(
            cl: const Color.fromARGB(103, 68, 137, 255),
            Day: '01',
            Med: Tablets[0],
            done: done[2],
            Time: Timing[1],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Night 09:00 pm",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          Medicine(
            cl: Colors.green,
            Day: '03',
            Med: Tablets[0],
            done: done[2],
            Time: Timing[2],
          ),
          Medicine(
            cl: Colors.yellow,
            Day: '01',
            Med: Tablets[0],
            done: done[2],
            Time: Timing[2],
          ),
        ],
      ),
    );
  }
}
