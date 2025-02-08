import 'package:contineu/screens/add_todo_screen.dart';
import 'package:contineu/screens/settings_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => SettingsScreen(),
              ),
            );
          },
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
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => AddTodoScreen(),
              ),
            );
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
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => AddTodoScreen(
                              todoTitle: todo['title'],
                              id: todo['id'],
                            ),
                          ),
                        );
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
