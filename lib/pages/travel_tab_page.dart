import 'package:flutter/material.dart';
import 'package:flutter_app/dao/travel_dao.dart';
import 'package:flutter_app/model/travel_model.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const PAGE_SIZE = 10;

const _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;

  TravelTabPage({this.travelUrl, this.groupChannelCode});

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  //with TickerProviderStateMixin //SingleTickerProviderStateMixin
//  TabController _controller;
//  List<TravelTab> tabs = [];
//  TravelTabModel travelTabModel;
  List<TravelItem> travelItems;
  int pageIndex = 1;


  @override
  void initState() {
//    _controller = TabController(length: 0, vsync: this);
//    TravelTabDao.fetch().then((TravelTabModel model) {
//      _controller = TabController(length: model.tabs.length, vsync: this);
//      setState(() {
//        tabs = model.tabs;
//        travelTabModel = model;
//      });
//    }).catchError((e) {
//      print(e);
//    });
    _loadData();
    super.initState();
  }

  void _loadData() {
    TravelDao.fetch(widget.travelUrl ?? _TRAVEL_URL, widget.groupChannelCode,
        pageIndex, PAGE_SIZE)
        .then((TravelItemModel model) {
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    }).catchError((e) => print(e));
  }

  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    if (resultList == null) return [];
    List<TravelItem> filterItems = [];
    resultList.forEach((item) {
      if (item.article != null) {
        filterItems.add(item); //移除article为空的模型
      }
    });
    return filterItems;
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: travelItems?.length ?? 0,
          itemBuilder: (BuildContext context, int index) =>
              _TravelItem(index: index,item: travelItems[index]),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),

        )

//      Center(child: Column(
//          children: <Widget>[
//            Container(
//              color: Colors.white,
//              padding: EdgeInsets.only(top: 30),
//              child: TabBar(
//                  controller: _controller,
//                  isScrollable: true,
//                  labelColor: Colors.black,
//                  labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
//                  indicator: UnderlineTabIndicator(
//                    borderSide: BorderSide(
//                      color: Color(0xff2fcfbb),
//                      width: 3,
//                    ),
//                    insets: EdgeInsets.only(bottom: 10),
//                  ),
//                  tabs: tabs.map<Tab>((TravelTab tab) {
//                    return Tab(
//                      text: tab.labelName,
//                    );
//                  }).toList()),
//            ),
//            Flexible(
//                child: TabBarView(
//                    controller: _controller,
//                    children: tabs.map((TravelTab tab) {
//                      return Text(tab.groupChannelCode);
//                    }).toList()))
//          ],
//        ),
//      ),
    );
  }
}
class _TravelItem extends StatelessWidget {
  final int index;
  final TravelItem item;

  const _TravelItem({Key key, this.index, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('$index'),);

  }
}

