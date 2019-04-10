import 'package:carousel/model/detail.dart';
import 'package:flutter/material.dart';

final imagesList = [
  "assets/images/capetown1.jpg",
  "assets/images/capetown2.jpg",
  "assets/images/capetown3.jpg",
  "assets/images/losangeles1.jpg",
  "assets/images/losangeles2.jpg",
  "assets/images/losangeles3.jpg",
  "assets/images/losangeles4.jpg",
  "assets/images/losangeles.jpg",
];

final colorList = [
  Colors.redAccent.shade100,
  Colors.blueAccent.shade100,
  Colors.amber.shade50,
  Colors.grey.shade50,
  Colors.tealAccent.shade100,
  Colors.greenAccent.shade200,
  Colors.yellowAccent.shade100,
  Colors.orangeAccent.shade200
];

class CityExplorePage extends StatefulWidget {
  @override
  _CityExplorePageState createState() => _CityExplorePageState();
}

class _CityExplorePageState extends State<CityExplorePage> {

  int currentPage = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.8
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: colorList[currentPage],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 600.0,
                child: PageView.builder(
                  itemBuilder: (context, index){
                    return itemBuilder(index);
                  },
                  controller: _pageController,
                  pageSnapping: true,
                  onPageChanged: _onPageChanged,
                  itemCount: imagesList.length,
                  physics: ClampingScrollPhysics() ,
                ),
              ),
              _detailsBuilder(currentPage)
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailsBuilder(index){
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        double value = 1;
        if(_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
        }
        return Expanded(
          child: Transform.translate(
            offset: Offset(0.0, 100.0 + (-value * 100.0)),
            child: Opacity(
              opacity: value,
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      detailsList[index].title,
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Text(
                      detailsList[index].description,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Container(
                      width: 80.0,
                      height: 5.0,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      "Read More...",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  Widget itemBuilder(index){

    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child){
        double value = 1;
        if(_pageController.position.haveDimensions){
          value = _pageController.page - index;
          value = (1 - (value.abs()*0.5)).clamp(0.0, 1.0);
          return  Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(left: 30.0, right: 25.0, bottom: 10.0),
              height: Curves.easeIn.transform(value)*600,
              child: child,
            ),
          );
        }else{
          return  Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              height: Curves.easeIn.transform(index==0 ? value : value*0.5)*600,
              child: child,
            ),
          );

        }
      },
      child: Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              child: Image.asset(imagesList[index], fit: BoxFit.fitHeight,)
          ),
        ),
      ),
    );
  }

  _onPageChanged(int index){
    setState(() {
      currentPage = index;
    });
  }
}
