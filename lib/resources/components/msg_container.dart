// ignore_for_file: sized_box_for_whitespace

import 'package:chat_app/resources/constants.dart';
import 'package:flutter/material.dart';

class MsgContainer extends StatefulWidget {
  String msg;
  MsgContainer({super.key, required this.msg});

  @override
  State<MsgContainer> createState() => _MsgContainerState();
}

class _MsgContainerState extends State<MsgContainer> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.msg;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(),
        ),
        InkWell(
          onDoubleTap: () {
            editDialog(context);
          },
          onLongPress: () {
            deleteDialog(context);
          },
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(vertical: 10),
            // height: 50,
            // width: MediaQuery.of(context).size.width * .6,
            decoration: BoxDecoration(
              color: pColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  textAlign: TextAlign.end,
                  widget.msg,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> deleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Container(
              height: 100,
              width: 300,
              child: AlertDialog(
                title: Text(
                  "Do you want to delete this message?",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(sColor),
                            backgroundColor: MaterialStatePropertyAll(pColor)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No"),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(sColor),
                            backgroundColor: MaterialStatePropertyAll(pColor)),
                        onPressed: () {},
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  Future<dynamic> editDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            width: 300,
            child: AlertDialog(
              title: Text(
                "Edit message",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: TextField(
                controller: textEditingController,
                cursorColor: pColor,
                decoration: InputDecoration(
                  hintText: textEditingController.text,
                  filled: true,
                  fillColor: textFieldBg,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(sColor),
                          backgroundColor: MaterialStatePropertyAll(pColor)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(sColor),
                          backgroundColor: MaterialStatePropertyAll(pColor)),
                      onPressed: () {},
                      child: Text("Edit"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
