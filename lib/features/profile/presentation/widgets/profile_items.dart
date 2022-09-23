
import 'package:flutter/material.dart';

import '../../../../core/utils/config.dart';
import '../../data/models/profile_model.dart';

class ProfileItems extends StatelessWidget {
  UserProfileResponse data;
   ProfileItems({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // numberOfBusiness

        Column(
          children: [
            Text(
              "Business",
              style: Config.b1(context),
            ),
            Text(
              data.numberOfBusiness.toString(),
              style: Config.h2(context),
            )
          ],
        ),
        Container(
          height: 30,
          width: 2,
          color: Colors.grey.withOpacity(0.5),
        ),
        // numberOfProducts
        Column(
          children: [
            Text(
              "Products",
              style: Config.b1(context),
            ),
            Text(
              data.numberOfProducts.toString(),
              style: Config.h2(context),
            )
          ],
        ),
        Container(
          height: 30,
          width: 2,
          color: Colors.grey.withOpacity(0.5),
        ),
        // numberOfServices
        Column(
          children: [
            Text(
              "Services",
              style: Config.b1(context),
            ),
            Text(
              data.numberOfServices.toString(),
              style: Config.h2(context),
            )
          ],
        ),
      ],
    );
  }
}
