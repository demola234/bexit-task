import 'package:flutter/material.dart';

import '../../../../core/utils/config.dart';
import '../../data/models/user_by_id_model.dart';

class EmailText extends StatelessWidget {
  UserById data;
  EmailText({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data.user.email,
      style: Config.b2(context).copyWith(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
