import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auth_cubit_cubit.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNode = FocusNode();
  List<int> output = [];
  var controllerT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthCubitCubit userCubit = BlocProvider.of<AuthCubitCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('LoginPage'),
      ),
      body: BlocBuilder<AuthCubitCubit, AuthCubitState>(
        builder: (context, state) {
          if (state is AuthCubitInitial) {
            Future.delayed(const Duration(milliseconds: 400), () {
              FocusScope.of(context).requestFocus(_focusNode);
            });

            return Container(
              padding: EdgeInsets.all(20.0),
              child: Stack(
                children: <Widget>[
                  TextFormField(
                    enableInteractiveSelection: false,
                    focusNode: _focusNode,
                    controller: controllerT,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      print("Test value $value");
                      output.clear();
                      List<String> listnumber = value.split("");

                      for (int i = 0; i < listnumber.length; i++) {
                        setState(() {
                          output.add(int.parse(listnumber[i]));
                        });
                      }
                      if (output.length < listnumber.length) {
                        output.removeLast();
                      }
                      if (value.length == 4) {
                        FocusScope.of(context).unfocus();
                        userCubit.authUser(int.parse(value),
                            controler: controllerT, lists: output);
                      }
                      print(output.length);
                    },
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Text(
                          "Для входа введите пароль:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            output.length >= 1
                                ? _textNum(output[0].toString())
                                : _textNum(" "),
                            output.length >= 2
                                ? _textNum(output[1].toString())
                                : _textNum(" "),
                            output.length >= 3
                                ? _textNum(output[2].toString())
                                : _textNum(" "),
                            output.length >= 4
                                ? _textNum(output[3].toString())
                                : _textNum(" ")
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () {
                        if (_focusNode.hasFocus) {
                          FocusScope.of(context).unfocus();
                        } else {
                          FocusScope.of(context).requestFocus(_focusNode);
                        }
                      },
                      child: Icon(Icons.keyboard),
                    ),
                  )
                ],
              ),
            );
          } else if (state is AuthLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthLoadedState) {
            return Center(
              child: Icon(Icons.done),
            );
          } else if (state is AuthErorState) {
            controllerT.clear();
            output.clear();
            userCubit.error();
            return Center(
              child: Text(
                "Неверный пароль",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Widget _textNum(text) {
  return Container(
    height: 55,
    width: 25,
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10)),
    child: Center(
        child: Text(
      text,
      style: TextStyle(fontSize: 35),
    )),
  );
}
