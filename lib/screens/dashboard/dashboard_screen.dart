import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/loginProvider.dart';
import '../../provider/product_list.dart';
import '../../utils/userInformation.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJlMGNkYWUwNy00M2IyLTRlMDMtODk5MS00ODk5NTY4MjE3M2MiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiRGVtbyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImRlbW9AZ21haWwuY29tIiwiSWQiOiI1N2IxZDk4OC01NmQ3LTQ1N2MtYTNhNS00Zjk1YzQ2M2ViOTUiLCJVc2VySWQiOiIyMSIsIkNvbXBhbnlJZCI6IjkiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBZG1pbiIsImV4cCI6MTc1NTE1NzkxMX0.WYSWWFFGaCbfGmfShSP4U2U4js6JLAh5H6jI3wkCo5o";
  Map<String, String?> _userInfo = {};

  @override
  void initState() {
    super.initState();

    // Product list API call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductListProvider>(context, listen: false)
          .fetchUserData(token);
    });

    // Load user info from SharedPreferences
    UserInformation.getUserBasicInfo().then((info) {
      setState(() {
        _userInfo = info;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductListProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 80.h),
          child: Column(
            children: [
              Text(loginProvider.userModel?.username ?? "Guest"),
              Text(loginProvider.userModel?.email ?? "Not found"),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
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
