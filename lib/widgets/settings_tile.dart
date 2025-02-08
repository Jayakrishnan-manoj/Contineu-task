import 'package:contineu/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.onTap,
    required this.trailing,
    required this.title,
  });

  final VoidCallback? onTap;
  final Widget trailing;
  final String title;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color:themeProvider.isDarkTheme ? CupertinoColors.darkBackgroundGray : CupertinoColors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), trailing],
            ),
          ),
        ),
      ),
    );
  }
}
