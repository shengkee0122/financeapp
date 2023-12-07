import 'package:financeapp/expense_model.dart';
import 'package:financeapp/item.dart';
import 'package:financeapp/fund_condition_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List options = ["expense", "income"];
List<ExpenseModel> expenses = [];

class _HomePageState extends State<HomePage> {
  final itemController = TextEditingController();
  final amountController = TextEditingController();
  int amount = 0;
  final dateController = TextEditingController();
  int totalMoney = 0;
  int spentMoney = 0;
  int income = 0;
  DateTime? pickedDate;
  String currentOption = options[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        height: 67,
        child: FloatingActionButton(
          backgroundColor: Colors.pinkAccent.shade100,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 400,
                  child: AlertDialog(
                    title: const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Add Transaction",
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          amount = int.parse(amountController.text);
                          // adding a new item
                          final expense = ExpenseModel(
                            item: itemController.text,
                            amount: amount,
                            isIncome: currentOption == "income" ? true : false,
                            date: pickedDate!,
                          );
                          expenses.add(expense);
                          if (expense.isIncome) {
                            income += expense.amount;
                            totalMoney += expense.amount;
                            setState(() {});
                          } else if (!expense.isIncome) {
                            spentMoney += expense.amount;
                            totalMoney -= expense.amount;
                            setState(() {});
                          }

                          itemController.clear();
                          amountController.clear();
                          dateController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "ADD",
                          style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                    content: SizedBox(
                      height: 340,
                      width: 400,
                      child: Column(
                        children: [
                          TextField(
                            controller: itemController,
                            decoration: const InputDecoration(
                              hintText: "Item",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Amount",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              onTap: () async {
                                // user can pick date
                                pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                String date =
                                DateFormat.yMMMMd().format(pickedDate!);
                                dateController.text = date;
                                setState(() {});
                              },
                              controller: dateController,
                              decoration: const InputDecoration(
                                labelText: "Date",
                                hintStyle: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                                filled: true,
                                prefixIcon: Icon(Icons.calendar_today),
                                prefixIconColor: Colors.pink,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(height: 15),
                          RadioMenuButton(
                            value: options[0],
                            groupValue: currentOption,
                            onChanged: (expense) {
                              currentOption = expense.toString();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          RadioMenuButton(
                            style: ButtonStyle(
                              iconSize: MaterialStateProperty.all(20),
                            ),
                            value: options[1],
                            groupValue: currentOption,
                            onChanged: (income) {
                              currentOption = income.toString();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add, size: 26),
        ),
      ),
      appBar: AppBar(
        title: const Text(
            "Expense Tracker",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent.shade100,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    child: FundCondition(
                    type: "DEPOSIT",
                    amount: "$totalMoney",
                    icon: "img_2",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                    child: FundCondition(
                      type: "EXPENSE",
                      amount: "$spentMoney",
                      icon: "img",

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 8),
                  child: SizedBox(
                      child: FundCondition(
                        type: "INCOME",
                        amount: "$income",
                        icon: "img_1",
                      ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Confirm to Delete the Item ?",
                              style: TextStyle(
                                fontSize: 19.0,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "CANCEL",
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  final myExpense = expenses[index];
                                  if (myExpense.isIncome) {
                                    income -= myExpense.amount;
                                    totalMoney -= myExpense.amount;
                                    setState(() {});
                                  } else if (!myExpense.isIncome) {
                                    spentMoney -= myExpense.amount;
                                    totalMoney += myExpense.amount;
                                    setState(() {});
                                  }
                                  expenses.remove(myExpense);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "DELETE",
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Item(
                      expense: ExpenseModel(
                        item: expenses[index].item,
                        amount: expenses[index].amount,
                        isIncome: expenses[index].isIncome,
                        date: expenses[index].date,
                      ),
                      onDelete: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}