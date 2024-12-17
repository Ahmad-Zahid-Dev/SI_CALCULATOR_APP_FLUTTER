import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
       title: "Simple Interest Calculator",
       home:SIForm(),
    ),
  );
}
class SIForm extends StatefulWidget {
  const SIForm({super.key});

  @override
  State<SIForm> createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  var  _currencies = ['Rupees' , 'Dollors' , 'Pounds'];
  //String newValueSelected = "";
  var _currentValueSelected = "Rupees";
  @override
  void initState(){
    super.initState();
    _currentValueSelected = _currencies[0];
  }
  TextEditingController prcontrolled = TextEditingController();
  TextEditingController rcontrolled = TextEditingController();
  TextEditingController tcontrolled = TextEditingController();
  var finalResult= "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.purple.shade500,
      ),
      body: Form(
        key: _formkey,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff1ed7b5),Color(0xfff0f9a7)
              ])
          ),
          
          //color: Colors.green.shade200,
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image.asset('assets/images/money2.png')
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                 inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
                  keyboardType: TextInputType.number,
                 
                  controller: prcontrolled,
                  validator: ( value){
                    if(value!.isEmpty){
                      return "Please enter the principal amount";
                  }
                 
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade900,
                      ),
                    focusColor: Colors.white,
                    labelText: 'Principal',
                    hintText: 'Enter Principal e.g: 12000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  
                ),
                
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: rcontrolled,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),],
                    keyboardType: TextInputType.number,
                    validator: ( value){
                    if(value!.isEmpty){
                      return "Please enter the rate of interest";
                  }
                  },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade900,
                      ),
                      focusColor: Colors.white,
                      labelText: 'Rate of Interest',
                      hintText: 'Enter rate of interest e.g: 12%',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    
                  ),
              ),
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextFormField(
                          controller: tcontrolled,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.,]+'))],
                          keyboardType: TextInputType.number,
                          validator: ( value){
                    if(value!.isEmpty){
                      return "Please enter the Term (years)";
                  }
                  },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade900,
                      ),
                          focusColor: Colors.white,
                          labelText: 'Term',
                          hintText: 'Enter Term e.g: 1 year',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                                            ),
                                            
                                          ),
                                          
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: DropdownButton<String>(
                            items: _currencies.map((String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _currentValueSelected,
                            onChanged: ( newValueSelected) {
                              _ondropdown(newValueSelected!);
                          
                              
                            },
                          )
                        )
                        
                      ],
                    ),
                 ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10,right: 5,left: 5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.green.shade500
                                  ),
                                  onPressed: () {
                                    setState(() {
                                     if(_formkey.currentState!.validate()){
                                      this.finalResult = _calculatedAmount();
                                     }
                                    });
                                  },
                                 child: Text('Calculate',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10,right: 5,left: 5),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red.shade400
                                  ),
                                    onPressed: () {
                                      setState(() {
                                        _reset();                                    });
                                    },
                                      
                                   child: Text("Reset",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),)),
                              ),
                            ),
        
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Center(
                            child: Text(this.finalResult,
                            style: 
                            TextStyle(fontSize: 20,
                            fontWeight: FontWeight.w300),),
                          ),
                        )
            ],
          ),
          ),
      ),

      
      
    );
  }
  void _ondropdown( String newValueSelected){
  setState(() {
    this._currentValueSelected = newValueSelected;
  
  });
}
String _calculatedAmount(){
  double p = double.parse(prcontrolled.text);
  double r = double.parse(rcontrolled.text);
  double t = double.parse(tcontrolled.text);
  double amt = p + (p*r*t)/100;
  String result;
  if(_currentValueSelected == "Rupees"){
  result = "After $t years, your investment or Amount will be worth ${amt.toStringAsFixed(2)} $_currentValueSelected";
  }
  else if(_currentValueSelected == "Dollors"){
    double dollor = amt*0.012;
     result = "After $t years, your investment or Amount will be worth ${dollor.toStringAsFixed(2)} $_currentValueSelected";
  }
  else{
    double pound = amt*0.0095;
     result = "After $t years, your investment or Amount will be worth ${pound.toStringAsFixed(2)} $_currentValueSelected";
  };
  
  return result;
}
void _reset(){
  prcontrolled.text = ""; 
  rcontrolled.text = "" ;
  tcontrolled.text= "" ;
  finalResult = "";
  _currentValueSelected = _currencies[0];


}

}



