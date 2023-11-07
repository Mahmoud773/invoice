import 'package:flutter/material.dart';

class ListViewCard extends StatefulWidget {
  final double width;
  final int index;
  final Key key;
  final List<String> todoList;
  VoidCallback callback;

  ListViewCard(this.index, this.key, this.todoList, this.callback, this.width);
  @override
  _ListViewCard createState() => _ListViewCard();
}

class _ListViewCard extends State<ListViewCard> {
  List<FocusNode> focusList=[];
  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    for(var i=0 ; i <widget.todoList.length ;i++){
      focusList.insert(i, FocusNode());
    }
    return Container(
      width:widget.width,
      margin: EdgeInsets.all(5),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(

          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width:widget.width*70/100,
              child: TextFormField(
                initialValue:widget.todoList[widget.index].contains('sanf') ?
                widget.todoList[widget.index].substring(5):
                widget.todoList[widget.index],
                decoration: InputDecoration(

                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  filled: true,
                  alignLabelWithHint: false,
                  label: Text((widget.todoList[widget.index].startsWith('sanf'))?'اسم الصنف':'سيريال رقم '
                      '${widget.index}',
                    style: TextStyle(fontWeight: FontWeight.bold ,
                        color:widget.todoList[widget.index].startsWith('sanf') ? Colors.black:
                        Colors.black), textAlign: TextAlign.right,),
                  fillColor: widget.todoList[widget.index].startsWith('sanf') ?Colors.green :
                  Colors.black.withOpacity(0.1),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(width: 3, color: Colors.transparent ), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                   focusNode: focusList[widget.index],
                onChanged: (value){
                  if(widget.todoList[widget.index].contains("sanf")){
                    widget.todoList[widget.index]="sanf ${value}";
                  }
                  if( !widget.todoList[widget.index].contains("sanf")){
                    widget.todoList[widget.index]=value;
                  }
                  if(value.trim().characters.length==13)
                  {
                    focusNode: focus;
                    if(widget.index==widget.todoList.length){
                      FocusScope.of(context).unfocus();
                    }if(widget.index !=widget.todoList.length)
                      {
                        TextInputAction.next ;
                        FocusScope.of(context).requestFocus(focusList[widget.index+1]);
                      }
                  }
                },
                onSaved: (v){
                  if(v!.isNotEmpty && v.length>0){
                    if(widget.todoList[widget.index].contains("sanf")){
                      widget.todoList[widget.index]="sanf ${v}";
                    }if(!widget.todoList[widget.index].contains("sanf")){
                      widget.todoList[widget.index]=v;
                    }
                    // serialMap['${index}']=v!;
                  }
                },
              ),
            ),
            Container(
              width: widget.width*10/100,
              child: IconButton(onPressed: (){
                widget.todoList.removeAt(widget.index);
               widget.callback();
                        /*setState(() {
                          todos.removeAt(widget.index);
                        });*/
                if(!widget.todoList[widget.index].contains('serial')){

                  setState(() {
                    widget.todoList.removeWhere((element) => element.contains(
                        '${widget.todoList[widget.index]
                        }'));
                  });
                }
                if(widget.todoList[widget.index].contains('serial')){

                  setState(() {
                    widget.todoList.removeAt(widget.index);
                  });
                }


              },
                  icon: Icon(Icons.delete)),
            ),
          ],
        ),
      ),
    );
      Card(
      child: ListTile(
        title: Text(widget.todoList[widget.index]),
        trailing:
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
           widget.todoList.removeAt(widget.index);
            widget.callback();
            /*setState(() {
              todos.removeAt(widget.index);
            });*/
          },
        ),
        onTap: () {},
      ),
    );
      // Card(
    //   child: ListTile(
    //     title: TextFormField( initialValue: widget.todoList[widget.index],),
    //     trailing:
    //     IconButton(
    //       icon: Icon(Icons.delete),
    //       onPressed: () {
    //        widget.todoList.removeAt(widget.index);
    //         widget.callback();
    //         /*setState(() {
    //           todos.removeAt(widget.index);
    //         });*/
    //       },
    //     ),
    //     onTap: () {},
    //   ),
    // );

  }
}