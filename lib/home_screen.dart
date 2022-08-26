import 'dart:math';

import 'package:bmi_demo/age_weight_widget.dart';
import 'package:bmi_demo/gender_widget.dart';
import 'package:bmi_demo/height_widget.dart';
import 'package:bmi_demo/score_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _height = 150;
  int _age = 30;
  int _weight = 50;
  bool _isFinished = false;
  double _bmiScore = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        centerTitle: true,
        title: const Text('BMI CALCULATOR'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(50),
          child: Card(
            elevation: 30,
            shape: const RoundedRectangleBorder(),
            child: Column(
              children: [
                GenderWidget(
                  onChange: (genderVal){
                  },
                ),
                HeightWidget(
                  onChange: (heightVal){
                    _height = heightVal;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AgeWeightWidget(
                      onChange: (ageVal){
                        _age = ageVal;
                      },
                      title: "Age",
                      initValue:30,
                      min:0,
                      max:100),
                    AgeWeightWidget(
                       onChange: (weightVal) {
                         _weight = weightVal;
                       },
                       title:"Weight(Kg)",
                       initValue:50,
                       min:0,
                       max:200)
                    ],
                ),
                Padding(padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 50),
                  child: SwipeableButtonView(
                    isFinished: _isFinished,
                    onFinish: () async {
                      await Navigator.push(context, PageTransition(
                        child: ScoreScreen(
                          bmiScore: _bmiScore,
                          age: _age,
                        ),
                        type: PageTransitionType.fade));
                      setState(() {
                        _isFinished = false;
                      });
                    },
                    onWaitingProcess: () {
                      calculateBmi();

                      Future.delayed(const Duration(seconds: 1), (){
                        setState(() {
                          _isFinished = true;
                          });
                        });
                      },
                      activeColor: Colors.grey.shade700,
                      buttonWidget: const Icon(Icons.arrow_forward_ios_rounded),
                      buttonColor: Colors.grey,
                      buttonText: '',),
                  ),

              ],
            ),
          ),
        ),
      )
    );
  }

  void calculateBmi() {
    _bmiScore = _weight / pow(_height / 100, 2);
  }
}
