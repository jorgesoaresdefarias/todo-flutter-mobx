import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx/store/list_store.dart';
import 'package:todo_mobx/store/login_store.dart';
import 'package:todo_mobx/widgets/custom_icon_button.dart';
import 'package:todo_mobx/widgets/custom_text_field.dart';

import 'login_screen.dart';

class ListScreen extends StatelessWidget {
  ListStore listStore = ListStore();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Tarefas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<LoginStore>(context, listen: false)
                            .logOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      icon: Icon(Icons.exit_to_app),
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 16,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Observer(builder: (_) {
                        return CustomTextField(
                          controller: controller,
                          hint: 'Tarefa',
                          onChanged: listStore.setNewTodoTile,
                          suffix: !listStore.isFormValid
                              ? CustomIconButton(
                                  radius: 32,
                                  iconData: Icons.add,
                                  onTap: () {
                                    listStore.addTodo();
                                    controller.clear();
                                  },
                                )
                              : null,
                        );
                      }),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(child: Observer(
                        builder: (_) {
                          return ListView.separated(
                            itemCount: listStore.todoList.length,
                            itemBuilder: (_, index) {
                              return Observer(
                                builder: (_) {
                                  return ListTile(
                                    title: Text(
                                      listStore.todoList[index].title,
                                      style: TextStyle(
                                          decoration:
                                              listStore.todoList[index].done
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                          color: listStore.todoList[index].done
                                              ? Colors.grey
                                              : Colors.black),
                                    ),
                                    onTap: listStore.todoList[index].toggleDone,
                                  );
                                },
                              );
                            },
                            separatorBuilder: (_, __) {
                              return Divider();
                            },
                          );
                        },
                      ))
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
