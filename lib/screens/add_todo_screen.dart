import 'package:contineu/provider/theme_provider.dart';
import 'package:contineu/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key, this.todoTitle, this.id});

  final String? todoTitle;
  final String? id;

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _controller = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    if (widget.todoTitle != null) {
      _controller.text = widget.todoTitle!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: Colors.transparent,
        middle: Text(
          widget.id != null ? "Edit Todo" : "Add Todo",
          style: TextStyle(
            fontSize: 32,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              // const SizedBox(height: 100,),
              SizedBox(
                height: 100,
                child: CupertinoTextField(
                  controller: _controller,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: themeProvider.isDarkTheme
                            ? CupertinoColors.white
                            : CupertinoColors.darkBackgroundGray,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              FilledButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CupertinoColors.darkBackgroundGray,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (widget.id != null) {
                    if (_controller.text.isNotEmpty) {
                      await _databaseService
                          .editTodo(_controller.text, widget.id!)
                          .whenComplete(() {
                        Navigator.of(context).pop();
                        _controller.clear();
                      });
                    }
                  } else {
                    await _databaseService
                        .addTodo(_controller.text)
                        .whenComplete(() {
                      _controller.clear();
                      Navigator.of(context).pop();
                    });
                  }
                },
                icon: const Icon(CupertinoIcons.add),
                label: Text(widget.id != null ? "Update Todo" : "Add Todo"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
