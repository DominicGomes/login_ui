import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_assignment/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  RxString token = ''.obs;
  RxMap<String, dynamic> userProfileData = <String, dynamic>{}.obs;
  final box = GetStorage();
  RxBool visible = false.obs;
  RxBool isLoading = false.obs;

  Future<void> login() async {
    try {
      var response = await post(
        Uri.parse(
            'https://peanut.ifxdb.com/api/ClientCabinetBasic/IsAccountCredentialsCorrect'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"login": phone.text, "password": password.text}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        box.write('phone', phone.text);
        box.write('password', password.text);
        token.value = responseData['token'];

        Get.offNamed(Routes.HOME,
            arguments: {'token': token.value, 'phone': phone.text});
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    phone.text = box.read('phone') ?? '';
    password.text = box.read('password') ?? '';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
