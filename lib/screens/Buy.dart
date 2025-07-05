import 'package:flutter/material.dart';

class BillingScreen extends StatefulWidget {
  @override
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final List<TextEditingController> _itemControllers = [];
  final List<TextEditingController> _priceControllers = [];
  final List<TextEditingController> _quantityControllers = [];
  final TextEditingController _discountController = TextEditingController();

  double _totalPrice = 0.0;
  double _finalPrice = 0.0;

  void _addItem() {
    setState(() {
      _itemControllers.add(TextEditingController());
      _priceControllers.add(TextEditingController());
      _quantityControllers.add(TextEditingController());
    });
  }

  void _calculateTotal() {
    double total = 0.0;

    for (int i = 0; i < _priceControllers.length; i++) {
      final price = double.tryParse(_priceControllers[i].text) ?? 0.0;
      final quantity = int.tryParse(_quantityControllers[i].text) ?? 0;
      total += price * quantity;
    }

    final discount = double.tryParse(_discountController.text) ?? 0.0;
    final discountedPrice = total - (total * discount / 100);

    setState(() {
      _totalPrice = total;
      _finalPrice = discountedPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _itemControllers.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _itemControllers[index],
                          decoration: const InputDecoration(
                            labelText: 'Item Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _priceControllers[index],
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _quantityControllers[index],
                          decoration: const InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _addItem,
            child: const Text('Add Item'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _discountController,
            decoration: const InputDecoration(
              labelText: 'Discount (%)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculateTotal,
            child: const Text('Calculate Total'),
          ),
          const SizedBox(height: 20),
          Text(
            'Total Price: \$${_totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Final Price (after discount): \$${_finalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
