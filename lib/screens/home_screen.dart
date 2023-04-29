import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider/provider.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen( {super.key});


  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderTest>(context,listen: false).getData();
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: Consumer<ProviderTest>(
          builder: (context, data, _){
            return  data.isLoading?const CircularProgressIndicator():Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [

                Text(data.documentData.elementAt(0)!['phone'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:Colors.black ),),
                const SizedBox(height: 5.0,),

                Text(data.documentData.elementAt(0)!['email'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:Colors.black ),),
                const SizedBox(height: 5.0,),

                Text(data.documentData.elementAt(0)!['firstName'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:Colors.black ),),
                const SizedBox(height: 5.0,),

                Text(data.documentData.elementAt(0)!['lastName'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color:Colors.black ),),
                const SizedBox(height: 5.0,),
              ],
            );
          }

        ),
      ),
    );
  }

}