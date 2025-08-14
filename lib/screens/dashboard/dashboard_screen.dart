import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/product_list.dart';
import '../../utils/userInformation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final userInfo = await UserInformation.getUserBasicInfo();
    String token = userInfo["token"];
    name = userInfo["name"];
    email = userInfo["email"];

    Provider.of<ProductListProvider>(
      context,
      listen: false,
    ).fetchUserData(token);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductListProvider>(context);

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 80.h),
          child: Column(
            children: [Text(name ?? "Guest"), Text(email ?? "Not found")],
          ),
        ),
      ),
      appBar: AppBar(title: const Text("Dashboard")),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
          ? Center(child: Text(provider.error!))
          : provider.productList.isEmpty
          ? const Center(child: Text("No data available"))
          : ListView.builder(
              itemCount: provider.productList.length,
              itemBuilder: (context, index) {
                final item = provider.productList[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item.ledgerName),
                    subtitle: Text(
                      "Order No: ${item.orderNo} | Status: ${item.orderStatus}",
                    ),
                    trailing: Text("₹${item.finalAmount}"),
                  ),
                );
              },
            ),
    );
  }
}
