import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/bill.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BillingProvider with ChangeNotifier {
  final List<Product> _products = [];
  final List<BillItem> _currentBillItems = [];
  final List<Bill> _bills = [];
  String _customerName = '';
  String? _customerPhone;
  bool _isLoading = false;
  late SharedPreferences _prefs;

  List<Product> get products => _products;
  List<BillItem> get currentBillItems => _currentBillItems;
  List<Bill> get bills => _bills;
  String get customerName => _customerName;
  String? get customerPhone => _customerPhone;
  bool get isLoading => _isLoading;

  double get totalAmount =>
      _currentBillItems.fold(0, (sum, item) => sum + item.totalPrice);

  double get totalCGST =>
      _currentBillItems.fold(0, (sum, item) => sum + item.totalCGST);

  double get totalSGST =>
      _currentBillItems.fold(0, (sum, item) => sum + item.totalSGST);

  double get subtotal =>
      _currentBillItems.fold(0, (sum, item) => sum + item.subtotal);

  BillingProvider() {
    _initializeProvider();
  }

  Future<void> _initializeProvider() async {
    _isLoading = true;
    notifyListeners();

    try {
      _prefs = await SharedPreferences.getInstance();
      await _loadProducts();

      if (_products.isEmpty) {
        await _addSampleProducts();
      }
    } catch (e) {
      debugPrint('Error initializing provider: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadProducts() async {
    try {
      final productsJson = _prefs.getStringList('products') ?? [];
      _products.clear();
      _products.addAll(
        productsJson.map((json) => Product.fromJson(jsonDecode(json))),
      );
    } catch (e) {
      debugPrint('Error loading products: $e');
    }
  }

  Future<void> _saveProducts() async {
    try {
      final productsJson =
          _products.map((product) => jsonEncode(product.toJson())).toList();
      await _prefs.setStringList('products', productsJson);
    } catch (e) {
      debugPrint('Error saving products: $e');
    }
  }

  Future<void> _addSampleProducts() async {
    final sampleProducts = [
      Product(
        id: 1,
        name: 'Laptop',
        price: 45000,
        gstPercentage: 18,
        description: 'High-performance laptop with 16GB RAM',
      ),
      Product(
        id: 2,
        name: 'Smartphone',
        price: 15000,
        gstPercentage: 18,
        description: 'Latest model with 128GB storage',
      ),
      Product(
        id: 3,
        name: 'Headphones',
        price: 2000,
        gstPercentage: 12,
        description: 'Wireless noise-cancelling headphones',
      ),
      Product(
        id: 4,
        name: 'Mouse',
        price: 500,
        gstPercentage: 12,
        description: 'Wireless optical mouse',
      ),
      Product(
        id: 5,
        name: 'Keyboard',
        price: 1200,
        gstPercentage: 12,
        description: 'Mechanical gaming keyboard',
      ),
      Product(
        id: 6,
        name: 'Monitor',
        price: 12000,
        gstPercentage: 18,
        description: '24-inch Full HD display',
      ),
      Product(
        id: 7,
        name: 'USB Drive',
        price: 800,
        gstPercentage: 5,
        description: '64GB USB 3.0 flash drive',
      ),
      Product(
        id: 8,
        name: 'Webcam',
        price: 2500,
        gstPercentage: 12,
        description: '1080p HD webcam with microphone',
      ),
      Product(
        id: 9,
        name: 'Printer',
        price: 8000,
        gstPercentage: 18,
        description: 'All-in-one wireless printer',
      ),
      Product(
        id: 10,
        name: 'Tablet',
        price: 25000,
        gstPercentage: 18,
        description: '10-inch tablet with 128GB storage',
      ),
    ];

    _products.addAll(sampleProducts);
    await _saveProducts();
  }

  Future<void> addProduct(Product product) async {
    final newId = _products.isEmpty
        ? 1
        : (_products.map((p) => p.id!).reduce((a, b) => a > b ? a : b) + 1);
    final newProduct = Product(
      id: newId,
      name: product.name,
      price: product.price,
      gstPercentage: product.gstPercentage,
      description: product.description,
    );
    _products.add(newProduct);
    await _saveProducts();
    notifyListeners();
  }

  void addItemToBill(Product product, int quantity) {
    final existingItemIndex = _currentBillItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingItemIndex != -1) {
      _currentBillItems[existingItemIndex] = BillItem(
        product: product,
        quantity: _currentBillItems[existingItemIndex].quantity + quantity,
      );
    } else {
      _currentBillItems.add(BillItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeItemFromBill(int index) {
    _currentBillItems.removeAt(index);
    notifyListeners();
  }

  void updateItemQuantity(int index, int quantity) {
    if (quantity > 0) {
      _currentBillItems[index] = BillItem(
        product: _currentBillItems[index].product,
        quantity: quantity,
      );
      notifyListeners();
    } else {
      removeItemFromBill(index);
    }
  }

  void setCustomerDetails(String name, String? phone) {
    _customerName = name;
    _customerPhone = phone;
    notifyListeners();
  }

  Future<Bill> generateBill() async {
    final now = DateTime.now();
    final billNumber = 'BILL${DateFormat('yyyyMMddHHmmss').format(now)}';

    final bill = Bill(
      id: _bills.isEmpty
          ? 1
          : (_bills.map((b) => b.id!).reduce((a, b) => a > b ? a : b) + 1),
      customerName: _customerName,
      customerPhone: _customerPhone,
      items: List.from(_currentBillItems),
      dateTime: now,
      billNumber: billNumber,
    );

    _bills.add(bill);
    clearBill();
    return bill;
  }

  void clearBill() {
    _currentBillItems.clear();
    _customerName = '';
    _customerPhone = null;
    notifyListeners();
  }

  List<Bill> getBills() {
    return _bills;
  }
}
