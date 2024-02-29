import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  
  String? message;
  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const SizedBox(width: 6,),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green) ,
              ),
              const SizedBox(width: 26,),
              Text(message!, style: TextStyle(color: Colors.grey, fontSize: 12,),)
            ],
          ),
        ),
      ),
    );
  }
}

