import 'dart:convert';

import 'package:flutter_assignment/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  RxMap<String, dynamic> userProfileData = <String, dynamic>{}.obs;
  RxString lastFourDigits = ''.obs;
  RxList<Map<String, dynamic>> tradeList = <Map<String, dynamic>>[].obs;

  late String token;
  late String phone;
  Future<void> fetchUserProfileData() async {
    try {
      var accountInfoResponse = await post(
        Uri.parse(
            'https://peanut.ifxdb.com/api/ClientCabinetBasic/GetAccountInformation'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"login": phone, "token": token}),
      );

      if (accountInfoResponse.statusCode == 200) {
        userProfileData.value = json.decode(accountInfoResponse.body);
        print('value----------------->${accountInfoResponse.body}');
      } else {
        print(
            'Error fetching account information: ${accountInfoResponse.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchLastNumber() async {
    try {
      var lastFourNumbersResponse = await post(
        Uri.parse(
            'https://peanut.ifxdb.com/api/ClientCabinetBasic/GetLastFourNumbersPhone'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"login": phone, "token": token}),
      );

      if (lastFourNumbersResponse.statusCode == 200) {
        final String lastFourNumbers = lastFourNumbersResponse.body;
        lastFourDigits.value = lastFourNumbers;
        print('Last Four Numbers: $lastFourNumbers');
      } else {
        print(
            'Error fetching last four numbers of phone: ${lastFourNumbersResponse.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchTradeList() async {
    try {
      var tradeResponse = await post(
        Uri.parse(
            'https://peanut.ifxdb.com/api/ClientCabinetBasic/GetOpenTrades'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"login": phone, "token": token}),
      );

      if (tradeResponse.statusCode == 200) {
        final List<dynamic> trades = json.decode(tradeResponse.body);
        tradeList.clear();

        tradeList.addAll(trades.cast<Map<String, dynamic>>());

        print('Trade List: $tradeList');
      } else {
        print('Error fetching trade list: ${tradeResponse.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void logout() {
    userProfileData.clear();
    lastFourDigits.value = '';
    tradeList.clear();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> arguments = Get.arguments ?? {};
    token = arguments['token'] ?? '';
    phone = arguments['phone'] ?? '';
    fetchUserProfileData();
    fetchLastNumber();
    fetchTradeList();
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
