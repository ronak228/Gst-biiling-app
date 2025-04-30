import 'package:flutter/material.dart';
import 'products_screen.dart';
import 'billing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.storefront_outlined, size: 32),
              SizedBox(width: 12),
              Text('TATA Retail Solutions'),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.inventory_2_outlined,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'Products',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.point_of_sale_outlined,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'Billing',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
                indicator: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                  ),
                ),
                dividerColor: Colors.transparent,
              ),
            ),
          ),
        ),
        body: const SafeArea(
          child: TabBarView(
            children: [
              ProductsScreen(),
              BillingScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
