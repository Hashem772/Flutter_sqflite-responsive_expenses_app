class Transaction {
   int? id;
   String? title;
   double? amount;
   DateTime? date;

  Transaction({
    this.id,
    this.title,
    this.amount,
    this.date,
  }
  );
  Transaction.witId(
      this.id,
      this.title,
      this.amount,
      this.date,
      );
   Map<String, dynamic> toJson() {
     return {
     "id" :this.id,
     "title" :this.title,
     "amount": this.amount,
     "date": this.date.toString(),
   };
   }
   Transaction.fromJson(Map<String, dynamic> map){
     this.id = map["id"];
     this.title = map["title"] ;
     this.amount = map["amount"];
     this.date = DateTime.parse(map["date"]);
    //map["date"] = DateTime.parse( DateFormat.yMMMd().format(map["date"]));
   }
}
