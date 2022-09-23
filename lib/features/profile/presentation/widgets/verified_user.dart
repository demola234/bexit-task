
import 'package:flutter/material.dart';

import '../../data/models/user_by_id_model.dart';

class VerifiedUser extends StatelessWidget {
  UserById data;
  VerifiedUser({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      child: Center(
          child: Icon(
        Icons.check,
        color: Colors.white,
        size: 14,
      )),
    );
  }
}
