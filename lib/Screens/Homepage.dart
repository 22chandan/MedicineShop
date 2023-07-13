import 'package:flutter/material.dart';
import 'package:medicineshop/helper/SharedPrefernce.dart';
import 'package:medicineshop/helper/internetConnectivity.dart';
import 'package:medicineshop/widget/ScheduleOfmedicine.dart';
import 'package:medicineshop/Screens/profilePage.dart';
import 'package:medicineshop/widget/CurrentDays.dart';

import 'Addcontent.dart';
import 'ReportContent.dart';

class HomePage extends StatefulWidget {
  bool flag;
  HomePage({Key? key, this.flag = false}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int change = 0;
  bool? flag;
  String ProfilePhoto = "";
  @override
  void initState() {
    super.initState();
    flag = widget.flag;
    GetUserPhoto();
  }

  List pages = [
    Home(),
    ReportContent(),
  ];
  GetUserPhoto() async {
    await LocalData.getUserphoto().then((value) => {
          if (value != null)
            {
              setState(() {
                ProfilePhoto = value;
              }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi Harry!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "5 Medicines Left",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.medical_services,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: CircleAvatar(
                  backgroundImage: ProfilePhoto == ""
                      ? Image.asset('assets/profile1.png').image
                      : NetworkImage(ProfilePhoto),
                  radius: 18,
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (content) => AddContent()));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          height: 70,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      change = 0;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        change == 0 ? Icons.home_rounded : Icons.home_outlined,
                        color: Colors.blue,
                        size: change == 0 ? 40 : 30,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      change = 1;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        change == 1 ? Icons.report : Icons.report_outlined,
                        color: Colors.blue,
                        size: change == 1 ? 40 : 30,
                      ),
                      Text(
                        "Report",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: pages[change]);
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool flag = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await LocalData.getContent().then((value) => {
          if (value != null)
            {
              setState(() {
                flag = value;
              }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: WeekDaysScroll()),
                      ),
                    ],
                  ),
                ),
              ),
              flag == false
                  ? Container(
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset('assets/box.png'),
                      ),
                    )
                  : HomeContent(),
            ],
          ),
        ),
      ),
    );
  }
}
