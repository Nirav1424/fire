import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;

  final double radius;
  final VoidCallback onPressed;
  bool loading = false;

  RoundedButton({
    Key? key,
    required this.text,
    this.loading = false,
    this.radius = 10.0, // Default radius
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Material(
        color: Colors.deepPurple,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: 
                 Center(
                  
                    child:loading
                ? CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ): Center(
                    child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ),
                  ),
          ),
        ),
      ),
    );
  }
}
