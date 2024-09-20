// import 'package:bmi_proj/resultfile.dart';
// import "package:bmi_proj/style.dart";
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi/resultfile.dart';
import 'iconfiles.dart';
import 'containerfile.dart';
import 'calculateFile.dart';
import 'style.dart';

enum Gender {
  male, female
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? selectGender;
  int SliderHeight = 180; // Fixed typo
  int SliderWeight = 60;  // Fixed typo
  int SliderAge = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1D1E33),
        centerTitle: true,
        title: const Center(
          child: Text(
            'BMI Calculator',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RepeatContainerCode(
                    onPressed: () {
                      setState(() {
                        selectGender = Gender.male;
                      });
                    },
                    colors: selectGender == Gender.male ? activecolor : deactivecolor,
                    cardwidget: repeticontext(
                      iconData: FontAwesomeIcons.male,
                      lable: 'Male',
                    ),
                  ),
                ),
                Expanded(
                  child: RepeatContainerCode(
                    onPressed: () {
                      setState(() {
                        selectGender = Gender.female;
                      });
                    },
                    colors: selectGender == Gender.female ? activecolor : deactivecolor,
                    cardwidget: repeticontext(
                      iconData: FontAwesomeIcons.female,
                      lable: 'Female',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RepeatContainerCode(
              colors: Color(0xFF1D1E33),
              cardwidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Height',
                      style: kstyleclass,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        SliderHeight.toString(),
                        style: knumberstyle,
                      ),
                      Text(
                        'cm',
                        style: kstyleclass,
                      ),
                    ],
                  ),
                  Slider(
                    max: 220.0,
                    min: 0,
                    value: SliderHeight.toDouble(),
                    activeColor: Color(0xFFEB1555),
                    inactiveColor: Color(0xFF8D8E98),
                    onChanged: (double Newvalue) {
                      setState(() {
                        SliderHeight = Newvalue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RepeatContainerCode(
                    colors: Color(0xFF1D1E33),
                    cardwidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Weight',
                          style: kstyleclass,
                        ),
                        Text(
                          SliderWeight.toString(),
                          style: knumberstyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedIcon(
                              iconData: FontAwesomeIcons.minus,
                              onPress: () {
                                setState(() {
                                  SliderWeight--;
                                });
                              },
                            ),
                            SizedBox(width: 10.0,),
                            RoundedIcon(
                              iconData: FontAwesomeIcons.plus,
                              onPress: () {
                                setState(() {
                                  SliderWeight++;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RepeatContainerCode(
                    colors: Color(0xFF1D1E33),
                    cardwidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Age',
                          style: kstyleclass,
                        ),
                        Text(
                          SliderAge.toString(),
                          style: knumberstyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedIcon(
                              iconData: FontAwesomeIcons.minus,
                              onPress: () {
                                setState(() {
                                  SliderAge--;
                                });
                              },
                            ),
                            SizedBox(width: 10.0,),
                            RoundedIcon(
                              iconData: FontAwesomeIcons.plus,
                              onPress: () {
                                setState(() {
                                  SliderAge++;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              double bmi = calculateBMI(SliderHeight, SliderWeight);
              String statusMessage = getStatusMessage(bmi);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    result: bmi.toStringAsFixed(1), // Rounded to one decimal place
                    statusMessage: statusMessage,
                  ),
                ),
              );
            },
            child: Container(
              child: Center(
                child: Text(
                  'Calculate',
                  style: kstyleclass, // Fixed typo
                ),
              ),
              color: Colors.pink,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({
    Key? key,
    required this.iconData,
    required this.onPress,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(iconData),
      onPressed: onPress,
      elevation: 6,
      constraints: BoxConstraints.tightFor(
        width: 50.0,
        height: 50.0,
      ),
      shape: CircleBorder(),
      fillColor: Colors.white,
    );
  }
}
