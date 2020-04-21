import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jianshu/components/article_list.dart';
import 'package:jianshu/pages/search_page.dart';
import 'package:jianshu/utils/event_bus.dart';
import 'package:nav_router/nav_router.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  Animation<double> animation;

  AnimationController animationController;

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

  /// 列表滚动监听器
  var homeScrollDirectionEvent;

  @override
  void initState() {
    super.initState();

    // 初始化tabbar
    tabController = TabController(
      length: tabList.length,
      vsync: this
    );

    // 注册列表滚动监听器
    homeScrollDirectionEvent = eventBus.on<HomeScrollDirectionEvent>().listen((event) {
      String scrollDirection = event.scrollDirection;
      if (scrollDirection == 'down') {
        animationController.forward();
      } else if (scrollDirection == 'up') {
        animationController.reverse();
      }
    });

    animationController = AnimationController(
        duration: Duration(milliseconds: 100),
        vsync: this
    );


    // 创建一个动画
    animation = new Tween(
        begin: double.parse('${80.sp}'),
        end: 0.0
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0, 1.0,
        curve: Curves.linear,
      ),
    ))..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    homeScrollDirectionEvent.cancel();
    animationController.dispose();
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          IconData(0xe69d, fontFamily: 'iconfont'),
          color: Colors.white,
          size: 50.sp,
        ),
        onPressed: () {

        },
      ),
    );
  }

  /// 顶部搜索栏
  Widget _buildSearchBar (BuildContext context) {
    Widget searchBar = InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 60.w,
        decoration: BoxDecoration(
            color: Color(0xfff4f4f4),
            borderRadius: BorderRadius.circular(60.w)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              IconData(0xe653, fontFamily: 'iconfont'),
              size: 28.sp,
              color: Color(0xff999999),
            ),
            Text('  搜索感兴趣的内容', style: TextStyle(
                fontSize: 24.sp,
                color: Color(0xff999999),
                fontWeight: FontWeight.w500
            ),)
          ],
        ),
      ),
      onTap: () {
        routePush(SearchPage(), RouterType.fade);
      },
    );

    Widget container = Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40.w
      ),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      height: animation.value,
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