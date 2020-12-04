import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/auth/auth_bloc.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/utils/dots_indicator/src/dots_decorator.dart';
import 'package:myevent/src/utils/dots_indicator/src/dots_indicator.dart';
import 'package:myevent/src/utils/strings.dart';
import 'package:myevent/src/widgets/extension.dart';

class LadingPage extends StatefulWidget {
  @override
  LadingPageState createState() => LadingPageState();
}

class LadingPageState extends State<LadingPage> {
  int currentIndexPage = 0;
  var titles = [
    SLIDER_HEADING_1,
    SLIDER_HEADING_2,
    SLIDER_HEADING_3,
    SLIDER_HEADING_4
  ];

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(whiteColor);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PageView(
            children: <Widget>[
              WalkThrough(
                  textContent: SLIDER_DESC_1,
                  bgImg: "assets/images/walk1.png",
                  walkImg: "assets/images/event.png"),
              WalkThrough(
                  textContent: SLIDER_DESC_2,
                  bgImg: "assets/images/walk3.png",
                  walkImg: "assets/images/gestion.png"),
              WalkThrough(
                  textContent: SLIDER_DESC_3,
                  bgImg: "assets/images/walk2.png",
                  walkImg: "assets/images/notification.png"),
              WalkThrough(
                  textContent: SLIDER_DESC_4,
                  walkImg: "assets/images/start.png"),
            ],
            onPageChanged: (value) {
              setState(() => currentIndexPage = value);
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DotsIndicator(
                dotsCount: 4,
                position: currentIndexPage,
                decorator: DotsDecorator(
                  size: const Size.square(8.0),
                  activeSize: const Size.square(12.0),
                  color: greyColor,
                  activeColor: primaryColor,
                )),
          ),
        )
      ],
    ));
  }
}

class WalkThrough extends StatelessWidget {
  final String textContent;
  final String bgImg;
  final String walkImg;

  WalkThrough({Key key, this.textContent, this.bgImg, this.walkImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: h * 0.05),
                height: h * 0.5,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    bgImg != null
                        ? Image.asset(bgImg,
                            width: width, height: h * 0.5, fit: BoxFit.fill)
                        : Container(),
                    Image.asset(walkImg, width: width * 0.8, height: h * 0.6),
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.08,
              ),
              text(textContent,
                  textColor: primaryColor,
                  fontSize: 18.0,
                  fontFamily: MEDIUM,
                  maxLine: 3,
                  isCentered: true),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                child: text(SLIDER_DESC_4,
                    fontSize: 14.0, maxLine: 3, isCentered: true),
              )
            ],
          ),
        ),
        bgImg == null
            ? Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      AuthFirst(),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 50),
                    alignment: Alignment.center,
                    height: width / 8,
                    child: text(GO, textColor: whiteColor, isCentered: true),
                    decoration: boxDecoration(bgColor: primaryColor, radius: 8),
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
