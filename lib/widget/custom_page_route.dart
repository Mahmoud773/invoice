import 'package:flutter/material.dart';
void myNavigator(BuildContext context , Widget child){
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          Widget child,
          ) {
        // animation = CurvedAnimation(
        //   parent: animation,
        //   curve: Curves.elasticInOut,
        // );
        return ScaleTransition(
          scale: animation,
          alignment: Alignment.center,
          child: child,
        );
      },
      pageBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          ) {
        return child;;
      },
    ),
  );
}
void myNavigatorWithNoreturnToLeft(BuildContext context , Widget child){
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      transitionDuration: Duration(seconds:1),
      reverseTransitionDuration: Duration(seconds:1),
      transitionsBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          Widget child,
          ) {
        // animation = CurvedAnimation(
        //   parent: animation,
        //   curve: Curves.elasticInOut,
        // );
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(1, 0), end:Offset.zero ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          ) {
        return child;;
      },
    ),
  );
}
void myNavigatorWithNoreturnToRight(BuildContext context , Widget child){
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      transitionDuration: Duration(seconds:1),
      reverseTransitionDuration: Duration(seconds:1),
      transitionsBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          Widget child,
          ) {
        // animation = CurvedAnimation(
        //   parent: animation,
        //   curve: Curves.elasticInOut,
        // );
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(-1, 0), end:Offset.zero ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          ) {
        return child;;
      },
    ),
  );
}
void myNavigatorWithNoreturnToUp(BuildContext context , Widget child){
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      transitionDuration: Duration(seconds:1),
      reverseTransitionDuration: Duration(seconds:1),
      transitionsBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          Widget child,
          ) {
        // animation = CurvedAnimation(
        //   parent: animation,
        //   curve: Curves.elasticInOut,
        // );
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 1), end:Offset.zero ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          ) {
        return child;;
      },
    ),
  );
}
void myNavigatorWithNoreturnToDown(BuildContext context , Widget child){
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      transitionDuration: Duration(seconds:1),
      reverseTransitionDuration: Duration(seconds:1),
      transitionsBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          Widget child,
          ) {
        // animation = CurvedAnimation(
        //   parent: animation,
        //   curve: Curves.elasticInOut,
        // );
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(-1, 0), end:Offset.zero ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondAnimation,
          ) {
        return child;;
      },
    ),
  );
}