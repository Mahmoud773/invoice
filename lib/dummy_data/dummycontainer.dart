// Container(
// key: ObjectKey(widget.billTextModel.serialMap[index]),
// margin: EdgeInsets.all(5),
// width: width*80/100,
// child: Directionality(
// textDirection: TextDirection.rtl,
// child: Row(
// mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Container(
// width: width*50/100,
// child: TextFormField(
// onTapOutside: (event){
// // FocusManager.instance.primaryFocus?.unfocus();
// FocusScope.of(context).unfocus();
// },
// textInputAction: TextInputAction.next,
// focusNode: focusList[index],
// onFieldSubmitted: (v){
// focusList[index+1].requestFocus();
// },
// initialValue:widget.billTextModel.serialMap[index].contains('sanf') ?
// widget.billTextModel.serialMap[index].substring(7).trim():
// widget.billTextModel.serialMap[index].substring(widget.billTextModel.serialMap[index].indexOf(',')+1).trim(),
// decoration: InputDecoration(
//
// focusedBorder: OutlineInputBorder(
// borderSide:
// BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
// borderRadius: BorderRadius.circular(50.0),
// ),
// filled: true,
// alignLabelWithHint: false,
// label: Text((widget.billTextModel.serialMap[index].contains('/sanf'))?
// 'كود الصنف':'سيريال ',
// style: TextStyle(fontWeight: FontWeight.bold ,
// color:widget.billTextModel.serialMap[index].contains('/sanf') ?
// Colors.black:
// Colors.black), textAlign: TextAlign.right,),
// fillColor: widget.billTextModel.serialMap[index].contains('/sanf') ?
// Colors.green :
// Colors.black.withOpacity(0.1),
// enabledBorder: OutlineInputBorder(
// borderSide:
// BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
// borderRadius: BorderRadius.circular(50.0),
// ),
// ),
// validator: (value){
// if(value!.isEmpty ||value.length<1)
// {return ' please Enter Valid value' ;}
// else return null ;
//
// },
//
// // onChanged: (value){
// //
// //   if(value!.isNotEmpty && value.length>0){
// //     // var x=sanfList22[index].substring(0 , sanfList22[index].indexOf(',')+1);
// //     // sanfList22[index]= '$x $value';
// //     var x=widget.billTextModel.serialMap[index].substring(0 ,
// //         widget.billTextModel.serialMap[index].indexOf(',')+1);
// //     // widget.billTextModel.serialMap[index]= '$x $value';
// //     // print('onchangedsanfList22 $sanfList22');
// //     if(widget.billTextModel.serialMap[index].contains("sanf")){
// //       widget.billTextModel.serialMap[index]="$x ${value}";
// //     }
// //     if(!widget.billTextModel.serialMap[index].contains("sanf")){
// //       widget.billTextModel.serialMap[index]='$x $value'
// //       ;
// //     }
// //   }
// //
// //   if(value.trim().characters.length==13)
// //   {
// //   focusNode: focus;
// //   // TextInputAction.next ;
// //   FocusScope.of(context).requestFocus(focusList[index+1]);
// //   }
// // },
//
// onSaved: (v){
// if(v!.trim().isNotEmpty && v.trim().length>0){
// // var x=sanfList22[index].substring(0 ,
// //     sanfList22[index].indexOf(',')+1);
// // sanfList22[index]= '$x $v';
// var x=widget.billTextModel.serialMap[index].substring(0 ,
// widget.billTextModel.serialMap[index].indexOf(',')+1);
// widget.billTextModel.serialMap[index]="${x.trim()} ${v.trim()}";
// // widget.billTextModel.serialMap[index]= '$x $v';
// // if(widget.billTextModel.serialMap[index].contains("sanf")){
// //   widget.billTextModel.serialMap[index]="$x ${v}";
// // }
// // if(!widget.billTextModel.serialMap[index].contains("sanf")){
// //   widget.billTextModel.serialMap[index]='$x $v'
// //   ;
// // }
// serialMap['${index}']=v!;
// }
// },
// ),
// ),
// Column(
// mainAxisSize: MainAxisSize.max,
//
// children: [
// Row(
// mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Container(
// width: width*10/100,
// child: IconButton(
// onPressed: (){
//
// // widget.billTextModel.serialMap.removeAt(index);
// // if(itemsList[index].contains('sanf')==true){
// //
// //   itemsList.removeWhere((element) => element.contains(
// //       '${itemsList[index]
// //       }'));
// //   setState(() {
// //
// //   });
// // }
//
//
// if(widget.billTextModel.serialMap[index].contains("sanf")){
//
// showDialog(context: context, builder:
// (context){
// return AlertDialog(
// actions: [
// TextButton(onPressed:(){
// var y =0;
// var x =widget.billTextModel.serialMap[index].
// substring(0,  (widget.billTextModel.serialMap[index].indexOf('/'))) ;
// y=int.parse(x);
// print(x);
// print(y);
//
// widget.billTextModel.serialMap.removeRange(index, index+y+1);
// Navigator.of(context).pop();
// setState(() {
//
// });
// } , child: Text('نعم', style:
// TextStyle(color: Colors.white , fontSize: 30 ,
// fontWeight: FontWeight.bold))),
// TextButton(onPressed: (){
// Navigator.of(context).pop();
// }, child: Text('لا' ,
// style:
// TextStyle(color: Colors.white , fontSize: 30 ,
// fontWeight: FontWeight.bold)))
// ],
// content: Directionality(
// textDirection: TextDirection.rtl,
// child: Text('هل تريد حذف الصنف بقائمة السيريال التابعة له', style:
// TextStyle(color: Colors.white , fontSize: 30 ,
// fontWeight: FontWeight.bold),
// ),
// ),
// backgroundColor: Colors.green,
// );
// });
//
// }
// else {
//
// var u=widget.billTextModel.serialMap[index].substring(0,
// widget.billTextModel.serialMap[index].indexOf(',') ,
// );
// widget.billTextModel.serialMap.forEach((element) {
// if(element.contains('sanf') && element.contains(u)){
// print('element1 is sanf??? $element');
// var y =0;
// var x =element.
// substring(0,  (element.indexOf('/'))) ;
//
// y=int.parse(x);
// print('xxx $x');
// print('yyyy $y');
// var pos = widget.billTextModel.serialMap.indexOf(element);
// var newSanf= element.substring(1);
// print('newSanf $newSanf');
// var secondSanf= '${y-1}$newSanf';
// print('secondSanf $secondSanf');
// widget.billTextModel.serialMap[pos]=secondSanf;
//
// print('element1 $element');
// }
//
// });
// widget.billTextModel.serialMap.removeAt(index);
// // sanfList22.removeAt(index);
// setState(() {
//
// });
// }
//
//
//
//
// },
// icon: Icon(Icons.delete)),
// ),
// IconButton(
// onPressed: () async {
// String x='';
// String barcodeScanRes;
//
// try{
// barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666',
// 'الغاء',
// true,
// ScanMode.BARCODE);
// print(barcodeScanRes);
//
// }on PlatformException  {
// barcodeScanRes='فشل المسح';
// }if(!mounted)return ;
// if(widget.billTextModel.serialMap[index].contains("sanf")){
// sanfXXX=widget.billTextModel.serialMap[index].substring(4 ,
// widget.billTextModel.serialMap[index].indexOf(',')+1);
// print('xxx $x');
//
//
// widget.billTextModel.serialMap[index]="sanf ${barcodeScanRes}";
// widget.billTextModel.serialMap.forEach((element) {
// if(element.contains(x)){
// element.substring(0 ,
// widget.billTextModel.serialMap[index].indexOf(',')+1);
// element='${barcodeScanRes}, $element' ;
// }
// });
//
// }
// if(!widget.billTextModel.serialMap[index].contains("sanf")){
// var x=widget.billTextModel.serialMap[index].substring(0 ,
// widget.billTextModel.serialMap[index].indexOf(',')+1);
// widget.billTextModel.serialMap[index]='$x $barcodeScanRes';
// }
// setState(() {
//
// });
// },
// icon: Icon(Icons.scanner)),
// ],
// ),
// TextButton(onPressed: () {
// var x=widget.billTextModel.serialMap[index].substring(5) ;
//
// widget.billTextModel.serialMap.insert(index+1,'$x, ');
// setState(() {
//
// });
// },
// child: Text('اضافة سيريال'))
// ],
// ),
//
// ],
// ),
// ),
// ) ;