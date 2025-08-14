class ProductListModel {
  final int id;
  final double amount;
  final String ledgerName;
  final String company;
  final String orderNo;
  final double gstAmount;
  final String orderDate;
  final double finalAmount;
  final String orderStatus;

  ProductListModel({
    required this.id,
    required this.amount,
    required this.ledgerName,
    required this.company,
    required this.orderNo,
    required this.gstAmount,
    required this.orderDate,
    required this.finalAmount,
    required this.orderStatus,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['id'] ?? 0,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      ledgerName: json['ledger']?['name'] ?? '',
      company: json['company'] ?? '',
      orderNo: json['order_no'] ?? '',
      gstAmount: (json['gst_amount'] as num?)?.toDouble() ?? 0.0,
      orderDate: json['order_date'] ?? '',
      finalAmount: (json['final_amount'] as num?)?.toDouble() ?? 0.0,
      orderStatus: json['order_status'] ?? '',
    );
  }
}
