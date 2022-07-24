import 'package:flutter/material.dart';

class AlertDialogItem extends StatefulWidget {
  late IconData icon;
  late String action;

  AlertDialogItem({required this.action, required this.icon, Key? key}) : super(key: key);

  @override
  State<AlertDialogItem> createState() => _AlertDialogItemState();
}

class _AlertDialogItemState extends State<AlertDialogItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(widget.icon),
        const SizedBox(width: 10),
        Text(widget.action)
      ],
    );
  }
}
