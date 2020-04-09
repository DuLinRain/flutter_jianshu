import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jianshu/components/article_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  /// tab栏列表
  List tabList = [
    {
      "text": "打榜",
      "value": "top"
    },
    {
      "text": "推荐",
      "value": "rmd"
    },
    {
      "text": "小岛",
      "value": "land"
    },
    {
      "text": "专题",
      "value": "topic"
    },
    {
      "text": "连载",
      "value": "read"
    },
  ];

  /// tab 控制器
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: tabList.length,
      vsync: this
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildSearchBar(context),
            _buildTabBar(context),
            _buildBody(context)
          ],
        ),
      ),
    );
  }

  /// 顶部搜索栏
  Widget _buildSearchBar (BuildContext context) {
    Widget searchBar = Container(
      alignment: Alignment.center,
      height: 60.w,
      decoration: BoxDecoration(
        color: Color(0xfff4f4f4),
        borderRadius: BorderRadius.circular(60.w)
      ),
      child: Text('搜索感兴趣的内容', style: TextStyle(
        fontSize: 22.sp,
        color: Color(0xff999999),
        fontWeight: FontWeight.w500
      ),),
    );

    Widget container = Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w
      ),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      height: 80.w,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: searchBar,
          )
        ],
      ),
    );

    return container;
  }

  /// TabBar
  Widget _buildTabBar (BuildContext context) {
    return Container(
      height: 80.w,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffededed),
            width: 1
          )
        )
      ),
      child: TabBar(
        controller: tabController,
        indicatorColor: Theme.of(context).primaryColor,
        labelColor: Colors.black,
        unselectedLabelColor: Color(0xff747474),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 4.w,
        indicatorPadding: EdgeInsets.only(
          left: 10.w,
          right: 10.w
        ),
        labelStyle: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal
        ),
        tabs: tabList.map((item) {
          return Tab(
            child: Text(item["text"]),
          );
        }).toList(),
      ),
    );
  }

  /// TabBarView
  Widget _buildTabBarView (BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: tabList.map((item) {
        Widget _page;
        switch (item["value"]) {
          case 'rmd':
            _page = ArticleList();
            break;
          default:
            _page = Text(item['text']);
        }

        return _page;
      }).toList(),
    );
  }

  /// 页面框架
  Widget _buildBody (BuildContext context) {
    return Expanded(
      child: _buildTabBarView(context),
    );
  }
}