import 'package:flutter/material.dart';
import 'data.dart';
import 'dart:math';




class Home extends StatefulWidget {
  @override
  State createState() {
    return HomeState();
  }
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class HomeState extends State with TickerProviderStateMixin {
  var currentPage = images.length - 1.0;

  bool showNames = false;
  bool showCard = false;
  bool showHBD = false;
  bool showNextButton = false;
  bool showNameLabel = false;
  bool showWarning = false;
  bool alignTop = false;
  bool increaseLeftPadding = false;
  bool showGreetings = false;
  bool showQuoteCard = false;
  bool showBoo = true;
  String name = '';


  double screenWidth;
  double screenHeight;

  AnimationController _controller;
  Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this, value: 0.1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: _getGreetingLabelWidget(),
          ),
          _getAnimatedAlignWidget(),
          _getHBD(),
          _getAnimatedPositionWidget(controller),

/*          Align(
            alignment: Alignment.center,
            child: _getQuoteCardWidget(),
          ),*/
          Align(
            alignment: Alignment.bottomCenter,
            child: _getAnimatedOpacityButton(),
          ),


        ],
      ),
    );
  }

  _firstAnimation() {
    _changeBoo();
    return AnimatedCrossFade(
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 200),
      firstChild: _getBoo(),
      secondChild: _getAnimatedAlignWidget(),
      crossFadeState: showBoo
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond
      ,
    );
  }

  /*
  _firstAnimation(){
    _changeBoo();
    return AnimatedCrossFade(
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 500),
      firstChild: _getBoo(),
      secondChild: _getAnimatedAlignWidget(),
      crossFadeState: showBoo
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond
      ,
    );
  }
  */


  _changeBoo() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showBoo = false;
      });
    });
  }

  _getBoo() {
    return ScaleTransition(
      scale: _animation,
      alignment: Alignment.center,
      child: Text(
          'Boo',
          style: TextStyle(
            fontSize: 54.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          )
      ),
    );
  }

  _getWarning() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: AnimatedOpacity(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          opacity: showWarning ? 1 : 0,
          child: Text(
              "Sorry, you're not my girl",
              style: TextStyle(
                color: Colors.redAccent,
              )
          ),
        ),
      ),
    );
  }


  _getAnimatedOpacityButton() {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      opacity: showNextButton ? 1 : 0,
      child: _getButton(),
    );
  }


  _getAnimatedCrossfade() {
    _changeBoo();
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 1000),
      firstChild: _getBoo(),
      secondChild: _getAnimatedCrossfadeB(),
      crossFadeState: showBoo
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond
      ,
    );
  }

  _getAnimatedCrossfadeB() {
    return AnimatedCrossFade(
      duration: Duration(seconds: 1),
      alignment: Alignment.center,
      reverseDuration: Duration(seconds: 1),
      firstChild: _getNameInputWidget(),
      firstCurve: Curves.easeInOut,
      secondChild: _getNameLabelWidget(),
      secondCurve: Curves.easeInOut,
      crossFadeState: showNameLabel ? CrossFadeState.showSecond : CrossFadeState
          .showFirst,
    );
  }


  _getAnimatedAlignWidget() {
    return AnimatedAlign(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      alignment: alignTop ? Alignment.topLeft : Alignment.center,
      child: _getAnimatedPaddingWidget(),
    );
  }

  _getAnimatedPaddingWidget() {
    return AnimatedPadding(
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      padding: increaseLeftPadding ? EdgeInsets.only(left: 40.0) : EdgeInsets
          .only(left: 0),
      child: _getAnimatedCrossfade(),
    );
  }

  _getFirstName() {
    return
      Text(name,
        style: TextStyle(fontSize: 44.0,
            color: Colors.grey),
      );
  }

  //showNames ? _getOtherNames() : _getFirstName(),

  _getNameLabelWidget() {
    return Padding(
        padding: EdgeInsets.fromLTRB(30.0, 38.0, 2.0, 8.0),
        child: Container(
          width: screenWidth / 2,
          height: 75.0,
          child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation,);
                },
                child: _getFirstName(),
              )
          ),
        )
    );
  }

  _getNameInputWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: screenWidth / 2,
        height: 75.0,
        child: Column(
          children: <Widget>[
            Center(
              child: TextField(
                style: TextStyle(color: Colors.grey),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  hintText: 'Your name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                textAlign: TextAlign.left,
                textCapitalization: TextCapitalization.words,
                onChanged: (v) {
                  name = v;
                  if (v.length > 0) {
                    setState(() {
                      showNextButton = true;
                    });
                  } else {
                    setState(() {
                      showNextButton = false;
                    });
                  }
                },
              ),
            ),
            _getWarning(),

          ],
        ),
      ),
    );
  }

  _getGreetingLabelWidget() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      opacity: showGreetings ? 1.0 : 0.0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 38.0, 2.0, 8.0),
        child: Container(
            width: screenWidth / 2,
            height: 75.0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hi,", style: TextStyle(fontSize: 44.0, color: Colors.grey),),
            )
        ),
      ),
    );
  }

  _showGreetings() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showGreetings = true;
      });
    });
  }

  _showHBD() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showHBD = true;
      });
    });
  }

  _showCards() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showCard = true;
      });
    });
  }

  _getAnimatedPositionWidget(PageController controller) {
    return AnimatedPositioned(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      child: _getCardWidget(controller),
      top: showCard ? screenHeight/2 - 100 : screenHeight,
      left: !showCard ? screenWidth/2 : 12,
    );
  }

  _getCardWidget(PageController controller) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.transparent,
      child: _getAnimatedSizeWidget(controller),
    );
  }

  _getAnimatedSizeWidget(PageController controller) {
    return AnimatedSize(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      vsync: this,
      child: _getCards(controller),
    );
  }

  _getCards(PageController controller){
    return
    Container(
      height: showCard ? screenHeight - 350 : 0,
      width: showCard ? screenWidth - 32 : 0,
      child: Stack(
        children: <Widget>[
          CardScrollWidget(currentPage),
          Positioned.fill(
            child: PageView.builder(
              itemCount: images.length,
              controller: controller,
              reverse: true,
              itemBuilder: (context, index) {
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }



  _getHBD() {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      opacity: showHBD ? 1 : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120.0, horizontal: 8.0),
        child: Text(
          'Happy Birthday Jaan',
          style: TextStyle(fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: 52.0,
              color: Colors.white),
        ),
      ),
    );
  }


  _increaseLeftPadding() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        increaseLeftPadding = true;
      });
    });
  }

  _nameCheck(name) {
    if ((name == 'Anisha') ||
        (name == 'anisha') ||
        (name == 'Mayfu') ||
        (name == 'mayfu') ||
        (name == 'Anisha Hossain') ||
        (name == 'anisha hossain') ||
        (name == 'Gadha')) {
      return true;
    }
    return false;
  }

  _getButton() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: FloatingActionButton(
        onPressed: () {
          if (_nameCheck(name)) {
            setState(() {
              showNameLabel = true;
              alignTop = true;
              showWarning = false;
              showNextButton = false;
            });

            _increaseLeftPadding();
            _showGreetings();
            _showHBD();
            _showCards();
          } else {
            setState(() {
              showWarning = true;
            });
          }
        },
        mini: true,
        child: Icon(Icons.arrow_forward, color: Colors.white,),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  _getAppBar() {
    return AppBar(
      title: Text("Boo", style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),),
      backgroundColor: Colors.lightBlue,
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;
        bool textColor = false;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;


          if ((i == 7) || (i ==8) || (i==4) || (i==12)) {
            textColor = true;
          } else {
            textColor = false;
          }
          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(images[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(title[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: textColor ? FontWeight.bold : FontWeight.normal,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
