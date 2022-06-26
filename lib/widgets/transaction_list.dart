import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '../models/transaction.dart';
import '../utilities/sql_helper.dart';
import 'package:sqflite/sqflite.dart' as sqlflite;
import '../models/transaction.dart';
class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  //final List<Transaction> transactionsList;
  TransactionList(this.transactions, this.deleteTx);
  SQL_Helper helper = new SQL_Helper();
  int count = 0;
  @override

  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  '! قائمة النفقات فارغة',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('${widget.transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    widget.transactions[index].title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(widget.transactions[index].date!),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                    icon: Icon(Icons.delete),
                    label: Text('Delete',style: TextStyle(fontWeight: FontWeight.bold),),
                    textColor: Theme.of(context).errorColor,
                    onPressed: () => widget.deleteTx(widget.transactions[index].id),
                  )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => widget.deleteTx(widget.transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: widget.transactions.length,
          );
  }
}
