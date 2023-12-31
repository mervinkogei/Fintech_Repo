import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kilimo_portal/Components/student_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kilimo_portal/Components/addStudent.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  
final TextEditingController _addStudent = TextEditingController();
final TextEditingController _searchStudent = TextEditingController();

var items = [
    'Education',
    'Marriage',
    'Health',
    'Kids',
    'Wealth',
    'Occupation',
    'Foreign Travels'
  ];
  String dropdownvalue = 'Form 1A';

    List<String>? streamList= [];
    List<String>? studentList = [];
    List<String> filteredList = [];

  getStreams() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      streamList = prefs.getStringList("streamList");
      studentList = prefs.getStringList("studentList")!;
    });

  }

  @override
  void initState() {
    setState(() {
      
    });
     getStreams();   
    super.initState();
  }

  getData(){
     filteredList = studentList!;
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
        centerTitle: true,
        title: const Text("Students List"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left:30.0),
              child: Text("Students Name"),
            ),
            Padding(
               padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10, bottom: 10),
               child: TextField(
                controller: _addStudent,
                decoration:InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 10.0),
                      counterText: '',
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColorLight, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: Theme.of(context).buttonColor, width: 2.0),
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.black, // <-- Change this
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
            ),
             ),
            Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Select Stream: "),
                          StatefulBuilder(
                              builder: (context, StateSetter dropDownState) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: dropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: streamList!.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  dropDownState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            );
                          })
                        ],
                      ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          )
                ),
                onPressed: ()async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                   if(_addStudent.text.isNotEmpty){                  
                    prefs.setString("addStudent", _addStudent.text);
                  }
      
                  List<String>? prefList = prefs.getStringList('studentList');
                  
                    var itemList = prefs.getString('addStudent');
                  if(prefList == null){     
                    setState((){
                    prefList = [];
                    });
                    }
                  
                    if (prefList != null) {
                    prefList?.add(itemList!);
                    }else{
                      prefList!.add(itemList!);
                    }
      
                  prefs.setStringList("studentList", prefList!);
                  
                 Fluttertoast.showToast(msg: "Student Successfully Added");
                  _addStudent.clear();
                  setState(() {
                    
                  });
                  getStreams();
                 
                }, child: const Text('Add Student')),
            ),
      
      
             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: TextField(
                  controller: _searchStudent,
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search Student',
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.fromLTRB(8, 5, 10, 5),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
              ),
      
            SingleChildScrollView(
              child: Column(
                children: [
                  studentList!.length ==0  ? const Center(child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text("No Student List Available", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),
                  )) :
                   ListView.builder(
                itemCount: studentList!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 10,
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StudentProfile(name: studentList![index], stream: streamList![index],)));
                      },
                      leading: Icon(Icons.edit, color: Theme.of(context).selectedRowColor,),
                      title: Text("Student Name :${studentList![index]}", style: TextStyle(color: Theme.of(context).selectedRowColor),) ,
                      subtitle: Text("Stream :$dropdownvalue", style: TextStyle(color: Theme.of(context).selectedRowColor),),
                      trailing: InkWell(
                        onTap: () async{ 
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          studentList!.removeAt(index);
                        List<String>? myList = prefs.getStringList('studentList');
                        myList?.removeAt(index);
                      await prefs.setStringList('studentList', myList!);
                      setState(() {
                        
                      });
                        },
                        child: const Icon(Icons.delete, color: Colors.red,)),
                    ),
                  ),
                );
              })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}