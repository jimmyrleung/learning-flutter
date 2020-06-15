import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  // Lifecycle method
  initState() {
    super.initState();

    catController = AnimationController(
      duration:
          Duration(milliseconds: 400), // How many seconds the animation will last
      vsync:
          this, // it means that this class is dealing with the animation and has the ticket provider mixin
    );

    // Tween: position configuration - initial: 0px, end: 100px
    catAnimation = Tween(begin: -35.0, end: -85.0).animate(
      // CurvedAnimation specifies the rate that our animation will change
      // In this case we gonna use the duration configuration of the catController
      // And the animation will be the easeIn (starts slow and end quickly)
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat animation!'),
      ),
      body: GestureDetector(
        // Align the stack container in the center of the screen
        // nOTE: the center widget tries to fit the whole screen
        child: Center(
          child: Stack(
            // align the items inside our stack in the center of this widget
            alignment: Alignment.center,
            // Pay attention here, the order matters
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
            ],

            // by default, the stack widget clips any content that overflow
            // its bounds. When you want to use positioning (like that case)
            // you probably want to set this to visible
            overflow: Overflow.visible,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      //Stopped at the end
      // Reverse the animation
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      // Stopped at the beginning
      // triggers the animation
      catController.forward();
    }
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,

      // child is our single instance of the widget that we'll be animated
      builder: (context, child) {
        // if cat were declarated here, it would be re-created
        // everytime.

        // Positioned is similar to position absolute, relative, etc
        // Margins are bad because they change the container size (height/width)
        // But positioning can be challenging too, because it means that the
        // container won't consider the child element size (that's why we set)
        // the Overflow to 'visible'
        return Positioned(
          child: child,
          top: catAnimation.value,

          // left and right 0.0 makes the positioned (and its content)
          // shrink and fit inside the parent container (stack)
          left: 0.0,
          right: 0.0,
        );
      },

      // Whenever we are working with animations, it might run like 60x/s,
      // so if you place a widget only inside the builder function, it will be
      // re-created up to 60x/s and then you'll lose performance.
      // To avoid that performance issue, we can declare which widget we gonna
      // animate, so flutter will generate a single instance and the animation builder will
      // only change its properties (like its position, color, size, etc)
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      // color: Colors.brown,
      decoration: BoxDecoration(
        color: Colors.brown,
        border: Border.all(
          width: 2.0,
          color: Colors.grey,
          style: BorderStyle.solid,
        ),
      ),
    );
  }
}
