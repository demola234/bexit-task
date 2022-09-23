
import 'package:flutter/material.dart';

import '../../../../core/utils/config.dart';
import '../../data/models/user_by_id_model.dart';

class ProfileImage extends StatelessWidget {
  UserById data;
  ProfileImage({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
            child: Text(
          data.user.email[0].toUpperCase(),
          style: Config.h1(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        )),
      ),
    );
  }
}
