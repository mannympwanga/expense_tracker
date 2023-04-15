import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactionList;
  final Function deleteTx;

  TransactionList({
    required this.userTransactionList,
    required this.deleteTx,
  });

  @override
  Widget build(BuildContext context) {
    return userTransactionList.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text("No transactions added as yet."),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
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
                        child: Text('R${userTransactionList[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    userTransactionList[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransactionList[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          onPressed: () =>
                              deleteTx(userTransactionList[index].id),
                          icon: Icon(Icons.delete),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                          label: Text("Delete"),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () =>
                              deleteTx(userTransactionList[index].id),
                        ),
                ),
              );

              //   return Card(
              //     child: Row(
              //       children: <Widget>[
              //         Container(
              //           margin: const EdgeInsets.symmetric(
              //             vertical: 10,
              //             horizontal: 15,
              //           ),
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               color: Theme.of(context).primaryColor,
              //               width: 2,
              //             ),
              //           ),
              //           padding: const EdgeInsets.all(10),
              //           child: Text(
              //             'R ${userTransactionList[index].amount.toStringAsFixed(2)}',
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //               color: Theme.of(context).primaryColor,
              //             ),
              //           ),
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Text(
              //               userTransactionList[index].title,
              //               style: const TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             Text(
              //               DateFormat.yMMMd()
              //                   .format(userTransactionList[index].date),
              //               style: const TextStyle(
              //                 color: Colors.grey,
              //               ),
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //   );
            },
            itemCount: userTransactionList.length,
          );
  }
}
