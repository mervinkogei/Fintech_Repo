import 'package:flutter/material.dart';
import 'package:kilimo_portal/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Streams extends StatefulWidget {
  Streams({Key? key}) : super(key: key);

  @override
  State<Streams> createState() => _StreamsState();
}

class _StreamsState extends State<Streams> {

  String? name = '';
  List<String>? streamList = [];

  final TextEditingController _search = TextEditingController();

  getStreams() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stream = prefs.getString("addStream");    
    setState(() {
      name = stream;
      streamList = prefs.getStringList("streamList")!;
    });
    print(stream);
    
   getData();

  }
  List<String> filteredList = [];

  @override
  void initState() {
    getStreams();
    super.initState();
  }
  getData(){
     filteredList = streamList!;
  }

   void filterSearchResults(String query) {
    setState(() {
      filteredList = streamList!
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=> Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) =>   HomeScreen())),
          child: const Icon(Icons.add)),
        title: const Text("Streams Available"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: _search,
                onChanged: (value) {
                  filterSearchResults(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search Stream',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.fromLTRB(8, 5, 10, 5),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
            ),



          ListView.builder(
            itemCount: filteredList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 10,
                child: ListTile(
                  leading: Icon(Icons.edit, color: Theme.of(context).selectedRowColor,),
                  title: Text(filteredList[index], style: TextStyle(color: Theme.of(context).selectedRowColor),) ,
                  trailing: const Icon(Icons.delete, color: Colors.red,),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}