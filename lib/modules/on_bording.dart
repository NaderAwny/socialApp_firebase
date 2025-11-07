/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class model {
  String? image;
  String? title;
  String? body;
  model({@required this.image, @required this.title, @required this.body});
}

class OnBording extends StatelessWidget {
  List<model> bording = [
    model(
      image: 'assets/image/logo.jpg',
      title: "first Title ",
      body: " first body",
    ),
    model(
      image: 'assets/image/logo.jpg',
      title: "second Title ",
      body: " second body",
    ),
    model(
      image: 'assets/image/logo.jpg',
      title: "three Title ",
      body: " three body",
    ),
  ];
  final bageController=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: bageController,
                  itemBuilder: (context, index) => buildBoardingItem(bording[index]),
                  itemCount: bording.length,
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Text("indector"),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
bageController.nextPage(duration: Duration(microseconds: 750), curve: Curves.easeInOut);

                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //work the comppnnet fromitem for bage view=== shhared commnet
  Widget buildBoardingItem(model model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage("${model.image}"))),
      SizedBox(height: 30),
      Text(
        "${model.title} ",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 15),
      Text(
        "${model.title} ",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
*/
import 'package:flutter/material.dart';
import 'package:shopapp/modules/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Model {
  String? image;
  String? title;
  String? body;

  Model({this.image, this.title, this.body});
}

class OnBording extends StatefulWidget {
  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording>
    with SingleTickerProviderStateMixin {
  bool islast = false;
  var pageController = PageController();

  late AnimationController animationController;
  late Animation<Offset> imageAnimation; // حركة الصورة
  late Animation<double> fadeAnimation; // شفافية النصوص
  late Animation<Offset> textAnimation; // حركة النصوص

  List<Model> bording = [
    Model(
      image: 'assets/image/logo.jpg',
      title: "First Title",
      body: "This is the first body",
    ),
    Model(
      image: 'assets/image/logo.jpg',
      title: "Second Title",
      body: "This is the second body",
    ),
    Model(
      image: 'assets/image/logo.jpg',
      title: "Third Title",
      body: "This is the third body",
    ),
  ];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    imageAnimation =
        Tween<Offset>(
          begin: Offset(0, 1), // من تحت
          end: Offset(0, 0), // مكانها الطبيعي
        ).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    textAnimation =
        Tween<Offset>(
          begin: Offset(0, 0.5), // النصوص جاية من تحت شوية
          end: Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(0.5, 1.0, curve: Curves.easeOut),
          ),
        );

    animationController.forward(); // يبدأ الأنيميشن أول ما يفتح
  }

  @override
  void dispose() {
    animationController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // شاشة بيضة
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => socialloginscreen()),
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (int index) {
                  if (index ==
                      bording.length - 1) // عرفنا اننا وصلنا لاخر  اليست
                  {
                    setState(() {
                      islast = true;
                    });
                    print(" last");
                  } else {
                    print("not last");
                    setState(() {
                      islast == false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(bording[index]),
                itemCount: bording.length,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                // Text("Indicator"),
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4, // space from indector
                  ),

                  controller: pageController,
                  count: bording.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => socialloginscreen()),
                      );
                    } else {
                      pageController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                      );
                      animationController.forward(from: 0);
                      // إعادة تشغيل الأنيميشن
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(Model model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ✨ الصورة متحركة
      Expanded(
        child: SlideTransition(
          position: imageAnimation,
          child: Center(child: Image.asset("${model.image}")),
        ),
      ),
      //   SizedBox(height: 30),
      // ✨ النصوص تظهر بتدريج
      FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: textAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.title}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "${model.body}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
