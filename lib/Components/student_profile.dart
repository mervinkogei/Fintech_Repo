import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  String? name;
  String? stream;
  StudentProfile({Key? key, this.name, this.stream}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
 TextEditingController _editStudent = TextEditingController();
 TextEditingController _editStream = TextEditingController();


  @override
  void initState() {
    setState(() {
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: const Text("Edit Student Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              color: Colors.white,
                    elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Edit Name: "),
                    Padding(
             padding: const EdgeInsets.only(left: 0.0, right: 30, top: 10, bottom: 10),
             child: TextField(            
              controller: _editStudent,
              decoration:InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 10.0),
                    counterText: '',
                    filled: true,
                    hintText:widget.name ,
                    fillColor: Colors.grey.withOpacity(0.5),
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
                    const Text("Edit Stream:"),
                    Padding(
             padding: const EdgeInsets.only(left: 0.0, right: 30, top: 10, bottom: 10),
             child: TextField(            
              controller: _editStream,
              decoration:InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 10.0),
                    counterText: '',
                    filled: true,
                    hintText:widget.stream ,
                    fillColor: Colors.grey.withOpacity(0.5),
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
           const SizedBox(height: 30),

           Center(
             child: SizedBox(
              height: 45,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        // side: BorderSide(color: Theme.of(context).buttonColor)
                        )),
                onPressed: (){
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Dashboard()));
                },
                child: Text( 'Update',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 18),
                )
              ),
          ),
           ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}