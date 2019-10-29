class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({this.id, this.title, this.amount, this.date})
      : assert(title != null && amount != null && date != null && id != null);
}

class WeeklyTransaction {
  final String weekDay;
  final double totalAmount;

  WeeklyTransaction({this.weekDay, this.totalAmount});
}
