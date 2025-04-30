import 'package:gst_billing_app/models/product.dart';

class BillItem {
  final Product product;
  final int quantity;

  BillItem({
    required this.product,
    required this.quantity,
  });

  double get subtotal => product.price * quantity;
  double get totalCGST => product.cgst * quantity;
  double get totalSGST => product.sgst * quantity;
  double get totalPrice => product.totalPrice * quantity;

  Map<String, dynamic> toMap() {
    return {
      'productId': product.id,
      'quantity': quantity,
      'price': product.price,
      'gstPercentage': product.gstPercentage,
    };
  }
}

class Bill {
  final int? id;
  final String customerName;
  final String? customerPhone;
  final List<BillItem> items;
  final DateTime dateTime;
  final String billNumber;

  Bill({
    this.id,
    required this.customerName,
    this.customerPhone,
    required this.items,
    required this.dateTime,
    required this.billNumber,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.subtotal);
  double get totalCGST => items.fold(0, (sum, item) => sum + item.totalCGST);
  double get totalSGST => items.fold(0, (sum, item) => sum + item.totalSGST);
  double get totalAmount => items.fold(0, (sum, item) => sum + item.totalPrice);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'dateTime': dateTime.toIso8601String(),
      'billNumber': billNumber,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map, List<BillItem> items) {
    return Bill(
      id: map['id'],
      customerName: map['customerName'],
      customerPhone: map['customerPhone'],
      dateTime: DateTime.parse(map['dateTime']),
      billNumber: map['billNumber'],
      items: items,
    );
  }

  Bill copyWith({
    int? id,
    String? customerName,
    String? customerPhone,
    List<BillItem>? items,
    DateTime? dateTime,
    String? billNumber,
  }) {
    return Bill(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      items: items ?? this.items,
      dateTime: dateTime ?? this.dateTime,
      billNumber: billNumber ?? this.billNumber,
    );
  }
}
