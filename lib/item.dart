import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:financeapp/expense_model.dart';

class Item extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback onDelete;

  const Item({
    Key? key,
    required this.expense,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 9,
        bottom: 7,
        left: 12,
        right: 11,
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 0.4),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(11.5),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const SizedBox(width: 17),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.item,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  DateFormat.yMMMMd().format(expense.date),
                  style: const TextStyle(
                    fontSize: 14.7,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              expense.amount.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 20.5,
                color: expense.isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}