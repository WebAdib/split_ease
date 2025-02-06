import 'package:flutter/material.dart';
import 'AddDebtScreen.dart';
import 'TransactionDetailsScreen.dart';
import 'Login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for balance overview
    double amountOwed = 150.00;
    double amountYouOwe = 80.00;

    // Dummy transaction list
    List<Map<String, dynamic>> transactions = [
      {
        "friendName": "Alice",
        "amount": 50.00,
        "description": "Dinner bill",
        "date": "2024-02-06",
        "status": "Pending",
        "isOwedToYou": false
      },
      {
        "friendName": "Bob",
        "amount": 30.00,
        "description": "Movie tickets",
        "date": "2024-02-04",
        "status": "Accepted",
        "isOwedToYou": true
      },
      {
        "friendName": "Charlie",
        "amount": 70.00,
        "description": "Loan repayment",
        "date": "2024-01-30",
        "status": "Settled",
        "isOwedToYou": false
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Money Manager'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to Profile Screen (To be implemented)
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Overview
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Balance Overview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('You Owe:', style: TextStyle(fontSize: 16)),
                        Text('\$${amountYouOwe.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Owed to You:', style: TextStyle(fontSize: 16)),
                        Text('\$${amountOwed.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Recent Transactions
            Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        '${transaction["friendName"]} - \$${transaction["amount"].toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(transaction["description"]),
                      leading: Icon(
                        transaction["isOwedToYou"]
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: transaction["isOwedToYou"]
                            ? Colors.green
                            : Colors.red,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionDetailsScreen(
                                    friendName: transaction["friendName"],
                                    amount: transaction["amount"],
                                    description: transaction["description"],
                                    date: transaction["date"],
                                    status: transaction["status"],
                                    isOwedToYou: transaction["isOwedToYou"],
                                  )),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button to Add Debt
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDebtScreen()),
          );
        },
      ),
    );
  }
}
