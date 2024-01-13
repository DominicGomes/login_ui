import 'package:flutter/material.dart';
import 'package:flutter_assignment/app/utilities/extra_colors.dart';
import 'package:flutter_assignment/global/global_inputfield.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              Text(
                'Enter your phone number and explore :)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
              ),
              SizedBox(height: 10.0),
              GlobalTextField.view(
                  controller: controller.phone,
                  prefix: Icon(Icons.person_rounded),
                  initialValue: controller.phone.text,
                  hint: "Enter your phone number"),
              Obx(
                () => GlobalTextField.view(
                    controller: controller.password,
                    prefix: Icon(Icons.key_rounded),
                    obsecure: controller.visible.value,
                    inputType: TextInputType.visiblePassword,
                    suffix: IconButton(
                        onPressed: () {
                          controller.visible.value = !controller.visible.value;
                        },
                        icon: Icon(
                          controller.visible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        )),
                    initialValue: controller.password.text,
                    hint: "Enter password"),
              ),
              GestureDetector(
                  onTap: () => controller.login(),
                  child: Obx(
                    () => controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Container(
                            height: 55,
                            width: Get.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ExtraColors.PRIMARY_100,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  )),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
