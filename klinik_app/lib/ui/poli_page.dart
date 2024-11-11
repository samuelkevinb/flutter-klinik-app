import 'package:flutter/material.dart';
import 'package:klinik_app/ui/poli_sidebar.dart'; 
import '../model/poli.dart'; 
import '../service/poli_service.dart'; 
import 'package:klinik_app/ui/poli_detail.dart'; 
import 'poli_form.dart'; 
import 'poli_item.dart'; 

class PoliPage extends StatefulWidget { 
  const PoliPage({super.key}); 
  @override
  _PoliPageState createState() => _PoliPageState(); 
} 

class _PoliPageState extends State<PoliPage> { 
  Stream<List<Poli>> getList() async* { 
    List<Poli> data = await PoliService().listData(); 
    yield data; 
  } 

  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      drawer: const PoliSidebar(), 
      appBar: AppBar( 
        title: const Text("Data Poli"), 
        actions: [ 
          GestureDetector( 
            child: const Icon(Icons.add), 
            onTap: () { 
              Navigator.push( 
                  context, MaterialPageRoute(builder: (context) => const PoliForm())); 
            }, 
          ) 
        ], 
      ), 
      body: StreamBuilder( 
        stream: getList(), 
        builder: (context, AsyncSnapshot snapshot) { 
          if (snapshot.hasError) { 
            return Text(snapshot.error.toString()); 
          } 
          if (snapshot.connectionState != ConnectionState.done) { 
            return const Center( 
              child: CircularProgressIndicator(), 
            ); 
          } 
          if (!snapshot.hasData && snapshot.connectionState == ConnectionState.done) { 
            return const Text('Data Kosong'); 
          } 

          return ListView.builder( 
            itemCount: snapshot.data.length, 
            itemBuilder: (context, index) { 
              return PoliItem(poli: snapshot.data[index]); 
            }, 
          ); 
        }, 
      ), 
    ); 
  } 
}
