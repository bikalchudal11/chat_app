// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:chat_app/pages/view_page/chat_msg.dart';
import 'package:chat_app/resources/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckSender extends StatefulWidget {
  const CheckSender({super.key});

  @override
  State<CheckSender> createState() => _CheckSenderState();
}

class _CheckSenderState extends State<CheckSender> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future savePersonInfo(String name, int id) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("sender_name", name);
    prefs.setInt("sender_id", id);
    print("$name and $id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pColor,
        foregroundColor: sColor,
        title: Text("Group Messaging"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your name to join:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .8,
                  child: TextFormField(
                    controller: nameController,
                    validator: (inputText) {
                      if (inputText!.isEmpty) return "Enter your name";
                      if (inputText == null) return "Enter your name";
                      if (!inputText.contains(" ")) {
                        return "Enter your full name with space between them";
                      }
                      return null;
                    },
                    cursorColor: pColor,
                    decoration: InputDecoration(
                      focusColor: pColor,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(pColor),
                      foregroundColor: MaterialStatePropertyAll(sColor)),
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              var response = await http.post(
                                  Uri.parse("$apiURL/peoples/new"),
                                  headers: {"Content-Type": "application/json"},
                                  body: jsonEncode(
                                      {"name": nameController.text}));
                              if (response.statusCode == 200) {
                                var decoded = jsonDecode(response.body);
                                await savePersonInfo(
                                    decoded["data"]["person"]["name"],
                                    decoded["data"]["person"]["id"]);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatMsg(
                                            senderId: decoded["data"]["person"]
                                                ["id"])));
                              } else {
                                throw Exception(
                                    "Invalid response: ${response.body}");
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Error: ${e.toString()}")));
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            print("invalid");
                          }
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: sColor,
                          )
                        : Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
