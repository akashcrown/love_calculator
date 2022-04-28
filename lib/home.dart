import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final TextEditingController hisname = TextEditingController();
  final TextEditingController hername = TextEditingController();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat();
    super.initState();
  }

  void reset() {
    setState(() {
      hisname.text = '';
      hername.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;

    void press() {
      final text1 = hisname.text;
      final text2 = hername.text;

      if (text1 != "" && text2 != "") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: LiquidCustomProgressIndicator(
                        direction: Axis.vertical,
                        shapePath: _buidHeartpath(),
                        center: Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                        value: _animationController.value,
                        backgroundColor: Colors.pinkAccent,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: Text('$text1 💖 $text2'),
                    )
                  ],
                ),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Enter the detail"),
              );
            });
      }
      reset();
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1559435578-231f6137aac5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2)),
                child: TextField(
                  controller: hisname,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.male, size: 30),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20),
                      hintText: 'His Name',
                      contentPadding: EdgeInsets.only(left: 20, top: 12),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 2)),
                child: TextField(
                  controller: hername,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.female,
                        size: 30,
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20),
                      hintText: 'Her Name',
                      contentPadding: EdgeInsets.only(left: 20, top: 12),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  press();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Calculate',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.black, width: 5),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Path _buidHeartpath() {
    return Path()
      ..moveTo(55, 15)
      ..cubicTo(55, 12, 50, 0, 30, 0)
      ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..cubicTo(0, 55, 20, 77, 55, 95)
      ..cubicTo(90, 77, 110, 55, 110, 37.5)
      ..cubicTo(110, 37.5, 110, 0, 80, 0)
      ..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }
}
