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
          Duration(seconds: 2), // How many seconds the animation will last
      vsync:
          this, // it means that this class is dealing with the animation and has the ticket provider mixin
    );

    // Tween: position configuration - initial: 0px, end: 100px
    catAnimation = Tween(begin: 0.0, end: 100.0).animate(
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
        child: buildAnimation(),
        onTap: onTap,
      ),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) { //Stopped at the end
      // Reverse the animation
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed){ // Stopped at the beginning
      // triggers the animation
      catController.forward();
    }
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,

      // child is our single instance of the widget that we'll be animated
      builder: (context, child) {
        // if cat were declarated here, it would be re-created
        // everytime.
        return Container(
          child: child,
          // As long the animation goes, we need to change its margin
          // otherwise our cat would be out of the screen
          margin: EdgeInsets.only(top: catAnimation.value),
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
}
