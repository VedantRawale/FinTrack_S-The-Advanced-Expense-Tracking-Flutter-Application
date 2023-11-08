import 'package:flutter/material.dart';
import '../../../../Services/api_services.dart';

class ListOfStocks extends StatefulWidget {
  final bool topG;
  const ListOfStocks({
    Key? key,
    required this.topG,
  }) : super(key: key);

  @override
  State<ListOfStocks> createState() => _ListOfStocksState();
}

class _ListOfStocksState extends State<ListOfStocks> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: GetModelFromApi().getModel(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading..");
          } else {
            List<StockModel> stockModel = snapshot.data as List<StockModel>;
            List<StockModel> filteredStocks = widget.topG
                ? stockModel.where((stock) => stock.change![0] != '-').toList()
                : stockModel.where((stock) => stock.change![0] == '-').toList();
            if (widget.topG) {
              filteredStocks.sort((a, b) => b.change!.compareTo(a.change!));
            } else {
              filteredStocks.sort((a, b) => a.change!.compareTo(b.change!));
            }
            return ListView.builder(
                itemCount: filteredStocks.length,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: SizedBox(
                              height: 30,
                              child: Image.asset(
                                  "android/assets/images/nifty_50.png"),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                    "Symbol:${filteredStocks[index].symbol.toString()}"),
                                const SizedBox(height: 5),
                                Text(
                                  "Change: ${filteredStocks[index].change.toString()}",
                                  style: TextStyle(
                                      color: (filteredStocks[index].change![0] != '-'
                                          ? Colors.green
                                          : Colors.red)),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                    "Last Price : ${filteredStocks[index].dayHigh.toString()}"),
                              ],
                            ),
                          ),
                        ],
                      ));
                });
          }
        },
      ),
    );
  }
}









// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: SizedBox(
//               height: 10, child: Image.asset("android/assets/nifty_50.png")),
//         ),
//         title: const Text("NIFTY-50 STOCKS",
//             style: TextStyle(color: Colors.white)),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//               child: Column(
//             children: [
//               Expanded(
//                 child: FutureBuilder(
//                   future: GetModelFromApi().getModel(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return const Text("Loading..");
//                     } else {
//                       List<StockModel> stockModel =
//                           snapshot.data as List<StockModel>;
//                       return ListView.builder(
//                           itemCount: stockModel.length,
//                           itemBuilder: (context, index) {
//                             return Card(
//                                 color: Colors.white,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(1.0),
//                                       child: SizedBox(
//                                         height: 30,
//                                         child: Image.asset(
//                                             "android/assets/images/nifty_50.svg"),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         children: [
//                                           Text(
//                                               "Symbol:${stockModel[index].symbol.toString()}"),
//                                           const SizedBox(height: 5),
//                                           Text(
//                                             "Change: ${stockModel[index].change.toString()}",
//                                             style: TextStyle(
//                                                 color:
//                                                     (stockModel[index].change! >
//                                                             0
//                                                         ? Colors.green
//                                                         : Colors.red)),
//                                           ),
//                                           const SizedBox(height: 5),
//                                           Text(
//                                               "Last Price : ${stockModel[index].dayHigh.toString()}"),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ));
//                           });
//                     }
//                   },
//                 ),
//               )
//             ],
//           )),
//         ],
//       ),
//     );
//   }
// }
