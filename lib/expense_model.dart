class ExpenseModel {
  final String item;
  final int amount;
  final bool isIncome;
  final DateTime date;
  ExpenseModel({
    required this.item,
    required this.amount,
    required this.isIncome,
    required this.date,
  });
}