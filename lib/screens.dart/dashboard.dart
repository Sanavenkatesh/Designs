import 'package:Designs/controller/feedback_controller.dart';
import 'package:Designs/model/feedback_form.dart';
import 'package:Designs/model/form.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import 'displayPage.dart';

class DashBaordPage extends StatefulWidget {
  final List<DataForm> items;

  const DashBaordPage({Key key, this.items}) : super(key: key);
  @override
  _DashBaordPageState createState() => _DashBaordPageState();
}

class _DashBaordPageState extends State<DashBaordPage> {
  final colorpallate = ColorPallate();
   List<DataForm> dataItems = List<DataForm>();
  List<DataForm> filterdataItems = List<DataForm>();
  List<String> names = List<String>();
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool _isDrawerOpen = false;
  int _page = 0;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController typeController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
   void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
          typeController.text,
          feedbackController.text);

      FeedbackController formController = FeedbackController();

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FeedbackController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  
  String active = '';
  @override
  void initState() {
    super.initState();
      setState(() {
        this.dataItems = widget.items;
        _getNames();
        _filterData(names[0]);
      });
  }

  _getNames(){
    for(int j = 0; j<dataItems.length; j++){
      if(!names.contains(dataItems[j].type) && dataItems[j].type != ""){
        names.add(dataItems[j].type);
      }
    }
     names.sort();
     active = names[0];
  }

   _filterData(String type){
     filterdataItems.clear();
    for(int i=0; i<dataItems.length; i++){
      if(dataItems[i].type == type){
        filterdataItems.add(dataItems[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          drawerScreen(),
          homeScreen(),
        ],
      ),
    );
    
  }
  homeScreen(){
      return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(_isDrawerOpen ? 40 : 0),
        ),
        color: Colors.white,
        child: IndexedStack(
          index: _page,
              children: [
                pageOne(),
                pageTwo()
              ],
        ),
      );
    }
  pageOne(){
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.transparent,
          ),

          Container(
            height: screenHeight,
            width: screenWidth/5,
            color: colorpallate.leftBarColor,
          ),
          Positioned(
            left: screenWidth/5,
            child: Container(
               height: screenHeight,
               width: screenWidth - (screenWidth/5),
               color: Colors.white,
            ),
            ),
          Positioned(
            top: 20.0,
            left: 20.0,
            child: _isDrawerOpen ? 
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
                  setState(() {
                    xOffset = 0;
                    yOffset = 0;
                    scaleFactor = 1;
                    _isDrawerOpen= false;
                  });
                }) :
                IconButton(icon: Icon(Icons.menu), onPressed: (){
                  setState(() {
                    xOffset = 230;
                    yOffset = 150;
                    scaleFactor = 0.6;
                    _isDrawerOpen= true;
                  });
                }),
          ),
          

          // Positioned(
          //   top: 35.0,
          //   right: 20.0,
          //   child: Icon(
          //     Icons.shopping_cart,
          //   ),
          // ),

          Positioned(
            top: screenHeight - (screenHeight - 100),
            left:  (screenWidth / 5) + 25,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Designs',
                    style: TextStyle(color: Color(0xFF23163D), fontSize: 40.0)
                  ),
                  // Text(
                  //   'Designs',
                  //   style: TextStyle(color: Color(0xFF23163D), fontSize: 15.0)
                  // ),

                  // SizedBox(height: 20),

                  // Container(
                  //   height: 40,
                  //   width: 225,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5.0),
                  //         borderSide: BorderSide(
                  //           color: Colors.grey.withOpacity(0.4)
                  //         ),
                  //       ),
                  //       contentPadding: EdgeInsets.only(top: 10, left: 10),
                  //       hintText: 'search...',
                  //       hintStyle: TextStyle(color: Color(0xFFA59FB0), fontSize: 15.0),
                  //       suffixIcon: Icon(
                  //         Icons.search,
                  //         color: Colors.grey.withOpacity(0.4)
                  //       )
                  //     ),
                  //   ),
                  // ),

                  
                ]
              ),
            ),
            ),

            buildSideNavigationBar(),

            Positioned(
              top: (screenHeight / 3) - 75.0,
              left: (screenWidth / 5) + 25,
              child: Container(
                  height: screenHeight - (screenHeight / 4.4),
                  width: screenWidth - ((screenWidth / 5) + 30),
                  // color: Colors.red,
                  child:  ListView(
                    children: [
                      for(int i = 0; i< filterdataItems.length; i++)
                      getFoodCard(filterdataItems[i].image, filterdataItems[i].price),
                    ],
                  )
                ),
              ),
        ]
        
      );
  }
  pageTwo(){
    return Scaffold(
      
      key: _scaffoldKey,  
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: _isDrawerOpen ? 
                IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: (){
                  setState(() {
                    xOffset = 0;
                    yOffset = 0;
                    scaleFactor = 1;
                    _isDrawerOpen= false;
                  });
                }) :
                IconButton(icon: Icon(Icons.menu, color: Colors.black), onPressed: (){
                  setState(() {
                    xOffset = 230;
                    yOffset = 150;
                    scaleFactor = 0.6;
                    _isDrawerOpen= true;
                  });
                }),
        title: Text("Feedback", style: TextStyle(color: Colors.black),),
        
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: typeController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Reason';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Issue/Suggestion'),
                        ),
                        
                        TextFormField(
                          controller: feedbackController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(labelText: 'Feedback'),
                        ),
                      ],
                    ),
                  )),
              // RaisedButton(
              //   color: Colors.blue,
              //   textColor: Colors.white,
              //   onPressed: _submitForm,
              //   child: Text('Submit Feedback'),
              // ),
              Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xFFFCC07E),
                    
                  ),
                  child: InkWell(
                    onTap: _submitForm,
                    child: Center(
                      child: Text('Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        )
                      ),
                    ),
                  ),
                ),

            ],
          )
      )
    
    );
  }
  buildSideNavigationBar(){
      return Positioned(
        top: 75,
        child: RotatedBox(
          quarterTurns: 3,
          child: Container(
            width: MediaQuery.of(context).size.height - 100,
            height: MediaQuery.of(context).size.width / 5,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children:[
                  for(int i = 0;i<names.length; i++) buildOption(names[i]),
                  
                ]
              
            ),
          ),
        )
        );
    }
    buildOption(String name){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
                onTap: (){
                  setState(() {
                    active = name;
                    _filterData(name);
                  });
                },
          child: Padding(
            padding: EdgeInsets.all(20),
                child: Text(
              name,
              style: TextStyle(
                fontSize: 18,
                color: name == active ? Colors.black : Colors.grey,
                ),
              ),
            )
          )
        ],
      );
    }

getFoodCard(String imgPath, String price){

        return Padding(
          padding: EdgeInsets.only(left: 10.0,right: 10.0, top: 10.0, bottom: 10.0),
          child: InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute( builder: (context) => DisplayImg(herotag: imgPath)));
      },
          child: Container(
            height: 230.0,
            width: (MediaQuery.of(context).size.width/2)-20.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1.5,
            )
          ]
        ),

        child: Column(
          children: <Widget>[
                Hero(
                  tag: imgPath,
                  child: Container(
                    height: 195.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                      image: DecorationImage(
                        image: NetworkImage(imgPath),
                        fit: BoxFit.cover,

                      )
                    ),
                  ),
                ),

            SizedBox(height: 10.0,),

             Text("₹ $price",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            ),

          ],
        ),
    ),
    ),
  );

}
drawerScreen(){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(0xFF416D6D),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          SizedBox(height: 200),
          InkWell(
            onTap: (){
              setState(() {
                _page = 0;
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                _isDrawerOpen= false;
              });
            },
            child: Padding(padding: EdgeInsets.all(20), child:Text("Home", style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),)),),
            InkWell(
            onTap: (){
              setState(() {
                _page = 1;
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                _isDrawerOpen= false;
              });
            },
           child: Padding(padding: EdgeInsets.all(20), child:Text("Feedback",style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),)),),
        ]
      ),
    );
  }
    

}