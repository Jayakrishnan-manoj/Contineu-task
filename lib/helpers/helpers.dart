import 'package:flutter/cupertino.dart';

class Helpers {

  void showCupertinoToast(BuildContext context, String message, bool isDarkTheme) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50, // Adjust position
        left: 20,
        right: 20,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:isDarkTheme ? CupertinoColors.darkBackgroundGray.withOpacity(0.9) : CupertinoColors.systemGrey.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              message,
              style: TextStyle(color: CupertinoColors.white,fontFamily: "Lato",),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(Duration(seconds: 3), () => overlayEntry.remove());
  }

   bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  
}
