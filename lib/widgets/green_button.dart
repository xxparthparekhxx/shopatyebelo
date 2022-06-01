import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  const GreenButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);
  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
            child: Padding(padding: const EdgeInsets.all(15.0), child: child),
          ),
        ),
      ),
    );
  }
}
