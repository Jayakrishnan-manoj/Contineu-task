import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListtile extends StatelessWidget {
  const CustomListtile({
    super.key,
    required this.title,
    required this.onDelete,
    required this.onEdit,
  });

  final String title;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(title),
      background: Container(color: CupertinoColors.destructiveRed),
      onDismissed: (direction) {
        // Handle delete
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.white,
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
              children: [
                Text(title),
                Row(
                  children: [
                    CupertinoButton(
                      child: Icon(CupertinoIcons.pencil),
                      onPressed: () async {
                        onEdit();
                      },
                    ),
                    CupertinoButton(
                        child: Icon(CupertinoIcons.delete),
                        onPressed: () async {
                          onDelete();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
