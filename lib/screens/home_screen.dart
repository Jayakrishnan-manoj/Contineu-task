import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contineu/screens/auth/login_screen.dart';
import 'package:contineu/services/auth_service.dart';
import 'package:contineu/services/database_service.dart';
import 'package:contineu/widgets/custom_listtile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();

  final TextEditingController _addTodoController = TextEditingController();

  final TextEditingController _editTodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.settings,
          ),
        ),
        middle: Text(
          "Contineu Tasks",
          style: TextStyle(
            fontSize: 32,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext builder) {
                  return CupertinoPopupSurface(
                    child: AnimatedPadding(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        width: double.infinity,
                        color: Colors.white,
                        height: 500,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: CupertinoTextField(
                                controller: _addTodoController,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey5,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            FilledButton(
                              onPressed: () async {
                                await _databaseService
                                    .addTodo(_addTodoController.text)
                                    .whenComplete(() {
                                  _addTodoController.clear();
                                  Navigator.of(context).pop();
                                });
                              },
                              child: Text("Add Task"),
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    CupertinoColors.darkBackgroundGray),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          icon: Icon(
            CupertinoIcons.add_circled,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: StreamBuilder(
            stream: _databaseService.getTodos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CupertinoActivityIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No todos yet!"));
              }
              var todos = snapshot.data!;

              return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    var todo = todos[index];
                    print(todo);
                    return CustomListtile(
                      title: todo['title'],
                      onDelete: () => _databaseService.removeTodo(
                        todo['id'],
                      ),
                      onEdit: () {
                        setState(() {
                          _editTodoController.text = todo['title'];
                        });
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext builder) {
                              return CupertinoPopupSurface(
                                child: AnimatedPadding(
                                  duration: const Duration(milliseconds: 300),
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    color: Colors.white,
                                    height: 500,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          child: CupertinoTextField(
                                            maxLength: 30,
                                            controller: _editTodoController,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    CupertinoColors.systemGrey5,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        FilledButton(
                                          onPressed: () async {
                                            if (_editTodoController
                                                .text.isNotEmpty) {
                                              await _databaseService
                                                  .editTodo(
                                                      _editTodoController.text,
                                                      todo['id'])
                                                  .whenComplete(() {
                                                Navigator.of(context).pop();
                                                _editTodoController.clear();
                                              });
                                            }
                                          },
                                          child: Text("Edit Task"),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    CupertinoColors
                                                        .darkBackgroundGray),
                                            shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}

