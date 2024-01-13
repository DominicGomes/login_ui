import 'package:flutter/material.dart';
import 'package:flutter_assignment/app/utilities/extra_colors.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.apple_rounded,
          color: Colors.grey,
          size: 50,
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.logout(),
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.logout_outlined,
                color: Colors.red,
                size: 35,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () => controller.userProfileData.isEmpty ||
                    controller.tradeList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: ExtraColors.PRIMARY_100,
                      strokeWidth: 0.75,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Details',
                        style: TextStyle(
                            color: ExtraColors.INFO_900,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildUserSection(context),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Trade List',
                        style: TextStyle(
                            color: ExtraColors.INFO_900,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      buildTradeList(context),
                    ],
                  ),
          )),
    );
  }

  Widget buildUserSection(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ExtraColors.PRIMARY_100, width: 0.75)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildIconWithText(Icons.person_rounded, 'Name:'),
                  Text(
                    controller.userProfileData['name'] ?? 'N/A',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                  ),
                ],
              ),
              buildDivider(Colors.grey.shade300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildIconWithText(Icons.phone_rounded, 'Last Four Numbers:'),
                  Text(
                    controller.lastFourDigits.value ?? 'N/A',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                  ),
                ],
              ),
              buildDivider(Colors.grey.shade300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildIconWithText(
                          Icons.location_city_rounded, 'Address:')),
                  Expanded(
                    child: Text(
                      controller.userProfileData['address'] ?? 'N/A',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade800),
                    ),
                  ),
                ],
              ),
              buildDivider(Colors.grey.shade300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildIconWithText(Icons.location_city, 'City:'),
                  Text(
                    controller.userProfileData['city'] ?? 'N/A',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                  ),
                ],
              ),
              buildDivider(Colors.grey.shade300),
              GestureDetector(
                onTap: () => showUserDetailsDialog(context),
                child: Container(
                  width: Get.width,
                  child: Text(
                    'Other Details',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 14,
                        color: ExtraColors.PRIMARY_100,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildIconWithText(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: ExtraColors.INFO_900,
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: ExtraColors.INFO_900),
        ),
      ],
    );
  }

  Widget buildDivider(Color? color) {
    return Divider(
      color: color,
      thickness: 0.75,
      height: 16,
    );
  }

  void showUserDetailsDialog(BuildContext context) {
    final country = controller.userProfileData['country'] ?? 'N/A';
    final balance = controller.userProfileData['balance'] ?? 0.0;
    final currentTradesCount =
        controller.userProfileData['currentTradesCount'] ?? 0;
    final equity = controller.userProfileData['equity'] ?? 0.0;
    final freeMargin = controller.userProfileData['freeMargin'] ?? 0.0;
    final isAnyOpenTrades =
        controller.userProfileData['isAnyOpenTrades'] ?? false;
    final isSwapFree = controller.userProfileData['isSwapFree'] ?? false;

    final totalTradesCount =
        controller.userProfileData['totalTradesCount'] ?? 0;
    final totalTradesVolume =
        controller.userProfileData['totalTradesVolume'] ?? 0.0;
    final type = controller.userProfileData['type'] ?? 0;
    final verificationLevel =
        controller.userProfileData['verificationLevel'] ?? 0;
    final zipCode = controller.userProfileData['zipCode'] ?? 'N/A';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ExtraColors.PRIMARY_100,
          titlePadding: EdgeInsets.only(left: 24, right: 12),
          contentPadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'User Details',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  size: 26,
                  color: Colors.greenAccent.withOpacity(0.5),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Container(
            height: 400,
            width: 600,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
                color: ExtraColors.PRIMARY_100,
                borderRadius: BorderRadius.circular(24)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Country:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$country",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Balance:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$balance",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Current Trades Count:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$currentTradesCount",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Equity:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "${double.parse(equity.toStringAsFixed(4))}",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Free Margin:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "${double.parse(freeMargin.toStringAsFixed(4))}",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Is Any Open Trades:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$isAnyOpenTrades",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Is Swap Free: $isSwapFree',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$isSwapFree",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Leverage:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$isSwapFree",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Trades Count:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$totalTradesCount",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Trades Volume:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$totalTradesVolume",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Type:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$type",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Verification Level:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$verificationLevel",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Zip Code:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$zipCode",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTradeList(BuildContext context) {
    double totalProfit = 0;

    for (var trade in controller.tradeList) {
      totalProfit += trade['profit'];
    }

    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var trade in controller.tradeList)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: ExtraColors.PRIMARY_100),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildIconWithText(Icons.checklist_rounded,
                            'Type: ${trade["type"] == 0 ? "Buy" : "Sell"}'),
                        Text('Profit: ${trade["profit"]}',
                            style: TextStyle(color: ExtraColors.INFO_900)),
                      ],
                    ),
                    SizedBox(height: 8),
                    buildIconWithText(Icons.local_atm_rounded,
                        'Open Price: ${trade["openPrice"]}'),
                    buildIconWithText(Icons.local_atm_rounded,
                        'Current Price: ${trade["currentPrice"]}'),
                    buildDivider(Colors.grey.shade300),
                    GestureDetector(
                      onTap: () => showTradeDetailsDialog(context),
                      child: Container(
                        width: Get.width,
                        child: Text(
                          'Other Details',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: ExtraColors.PRIMARY_100,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ));
  }

  void showTradeDetailsDialog(BuildContext context) {
    final symbol = controller.tradeList.isNotEmpty
        ? controller.tradeList[0]['symbol'] ?? 'N/A'
        : 'N/A';
    final volume = controller.tradeList.isNotEmpty
        ? controller.tradeList[0]['volume'] ?? 'N/A'
        : 'N/A';
    final openTime = controller.tradeList.isNotEmpty
        ? controller.tradeList[0]['openTime'] ?? 'N/A'
        : 'N/A';
    final ticket = controller.tradeList.isNotEmpty
        ? controller.tradeList[0]['ticket'] ?? 'N/A'
        : 'N/A';
    final digits = controller.tradeList.isNotEmpty
        ? controller.tradeList[0]['digits'] ?? 'N/A'
        : 'N/A';
    final swaps = controller.tradeList.isNotEmpty
        ? controller.tradeList[0]['swaps'] ?? 'N/A'
        : 'N/A';
    final sl = controller.tradeList.isNotEmpty
        ? controller.tradeList[0]['sl'] ?? 'N/A'
        : 'N/A';
    final tp = controller.tradeList.isNotEmpty
        ? controller.tradeList[0]['tp'] ?? 'N/A'
        : 'N/A';
    final comment = controller.tradeList.isNotEmpty
        ? controller.tradeList[0]['comment'] ?? 'N/A'
        : 'N/A';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ExtraColors.PRIMARY_100,
          titlePadding: EdgeInsets.only(left: 24, right: 12),
          contentPadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trade Details',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  size: 26,
                  color: Colors.greenAccent.withOpacity(0.5),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: Container(
            height: 330,
            width: 600,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
                color: ExtraColors.PRIMARY_100,
                borderRadius: BorderRadius.circular(24)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sl:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$sl",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Volume:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$volume",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Open Time:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$openTime",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ticket:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$ticket",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Digits:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$digits",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Swaps:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$swaps",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tp:',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      Text(
                        "$tp",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ],
                  ),
                  buildDivider(Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('Comment:',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                      Expanded(
                        child: Text(
                          "$comment",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
