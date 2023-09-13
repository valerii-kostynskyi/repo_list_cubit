import 'package:flutter/cupertino.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: const CupertinoActivityIndicator(),
    );
  }
}