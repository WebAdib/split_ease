import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:intl/intl.dart';

class AddDebtScreen extends StatefulWidget {
  @override
  _AddDebtScreenState createState() => _AddDebtScreenState();
}

class _AddDebtScreenState extends State<AddDebtScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedFriend;
  DateTime? selectedDate;
  bool isYouOwe = true;

  List<String> friends = ["Alice", "Bob", "Charlie", "David"];

  void _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _submitDebt() {
    if (selectedFriend == null ||
        _amountController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill in all fields!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate back to HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Debt")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Friend Selection Dropdown
            Text("Select Friend",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder()),
              value: selectedFriend,
              items: friends.map((friend) {
                return DropdownMenuItem(value: friend, child: Text(friend));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFriend = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Amount Field
            Text("Amount",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            SizedBox(height: 16),

            // Description Field
            Text("Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "E.g., Lunch money",
              ),
            ),
            SizedBox(height: 16),

            // Date Picker
            Text("Transaction Date",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            InkWell(
              onTap: () => _pickDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  selectedDate == null
                      ? "Select Date"
                      : DateFormat("dd/MM/yyyy").format(selectedDate!),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Type Toggle
            Text("Debt Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => isYouOwe = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isYouOwe ? Colors.blue : Colors.grey[300],
                      foregroundColor: isYouOwe ? Colors.white : Colors.black,
                    ),
                    child: Text("You Owe"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => isYouOwe = false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !isYouOwe ? Colors.blue : Colors.grey[300],
                      foregroundColor: !isYouOwe ? Colors.white : Colors.black,
                    ),
                    child: Text("You Are Owed"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: _submitDebt,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text("Submit", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
