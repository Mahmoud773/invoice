
import 'package:flutter/material.dart';
import 'package:invoice/widget/grid_photo.dart';



Widget buildGridImage(int ind){
  List<GridPhoto> gridItems=[
   GridPhoto(path: 'assets/images/txt.png', title: 'التصدير والاستيراد ') ,
    GridPhoto(path: 'assets/images/shop.webp', title: 'الفواتير') ,
    GridPhoto(path: 'assets/images/recycle.jpg', title: 'تصفير الفواتير') ,
    GridPhoto(path: 'assets/images/exit.jpg', title: 'خروج') ,

  ];
  return  Card(
    margin: EdgeInsets.all(5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8)
    ),
    child: Container(
      margin: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('${gridItems[ind].path}' ,
              fit: BoxFit.cover,
            height: 90,),
            SizedBox(height: 20,),
            Flexible(
              child: Text('${gridItems[ind].title}' ,
                style: TextStyle(color: Colors.black ,
                    fontSize: 15 ,fontWeight: FontWeight.bold  ),
                textAlign: TextAlign.center,
              ),
            )

          ],
        ),
      ),
    ),
  );
}