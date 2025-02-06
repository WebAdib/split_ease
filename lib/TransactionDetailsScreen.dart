import 'package:flutter/material.dart';
import 'AddRepaymentScreen.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String friendName;
  final double amount;
  final String description;
  final DateTime date;
  final String status;
  final bool isOwedToYou;

  TransactionDetailsScreen({
    required this.friendName,
    required this.amount,
    required this.description,
    required this.date,
    required this.status,
    required this.isOwedToYou,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transaction Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Friend Name
            Text(
              "Friend:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              friendName,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 16),

            // Amount
            Text(
              "Amount:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(height: 16),

            // Description
            Text(
              "Description:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Date
            Text(
              "Date:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "${date.day}/${date.month}/${date.year}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Status
            Text(
              "Status:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: status == "Pending"
                    ? Colors.orange
                    : status == "Accepted"
                        ? Colors.blue
                        : Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Repayment Button (Only if status is not "Settled")
            if (status != "Settled")
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddRepaymentScreen(
                              friendName: friendName, amount: amount)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    isOwedToYou ? "Request Repayment" : "Make Repayment",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
