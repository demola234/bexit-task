import 'dart:io';

import 'package:bex_it/core/utils/bexit_button.dart';
import 'package:bex_it/core/utils/config.dart';
import 'package:bex_it/core/utils/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';

import '../../../../core/error/toasts.dart';
import '../../../../core/utils/bexit_logout_button.dart';
import '../controller/profile_controller.dart';
import '../provider/profile_provider.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  List<File> image = [];
  void selectImage() async {
    List<Media>? res = await ImagesPicker.pick(
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.custom,
        cropType: CropType.rect,
      ),
      count: 1,
      pickType: PickType.image,
    );

    if (res != null) {
      setState(() {
        image.addAll(res.map((e) => File(e.path)));
        if (kDebugMode) {
          print(image.first.path);
        }
      });
      ref.watch(profileNotifierProvider.notifier).editProfileImage(image[0]);
    } else if (res == null) {
      Toasts.showErrorToast("No Image Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(getUserIdProvider);
    final getProfile = ref.watch(getProfileUser);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            YMargin(50),

            value.when(
              data: (data) => Align(
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
              ),
              loading: () => CircularProgressIndicator(),
              error: ((error, stackTrace) => Container()),
            ),

            YMargin(10),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  value.when(
                      data: (data) => Text(
                            data.user.email,
                            style: Config.b2(context).copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                      loading: () => CircularProgressIndicator(),
                      error: ((error, stackTrace) => Container())),
                  XMargin(5),
                  value.when(
                    data: (data) => data.user.status
                        ? Container(
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
                          )
                        : Center(
                            child: Icon(
                            Icons.cancel_rounded,
                            color: Colors.red,
                            size: 18,
                          )),
                    loading: () => CircularProgressIndicator(),
                    error: ((error, stackTrace) => Container()),
                  ),
                ],
              ),
            ),
            YMargin(50),
            // Edit Profile
            BexItButton(
                onTap: () {
                  selectImage();
                },
                text: "Edit Profile Image"),
            YMargin(35),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: getProfile.when(
                  data: (data) => Row(
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
                  ),
                  loading: () => CircularProgressIndicator(),
                  error: ((error, stackTrace) => Container()),
                )),
            Spacer(),
            BexitLogout(
              onTap: () {
                cache.clear();
                NavigationService().popToFirst();
              },
              text: "Log Out",
            )
          ],
        ),
      ),
    );
  }
}
