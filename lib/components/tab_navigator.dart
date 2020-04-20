import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jianshu/components/custom_bottom_tab_bar/bottom_tab_bar_item.dart';
import 'package:jianshu/components/custom_bottom_tab_bar/bottom_tab_bar_main.dart';
import 'package:jianshu/pages/follow_page.dart';
import 'package:jianshu/pages/home_page.dart';
import 'package:jianshu/pages/message_page.dart';
import 'package:jianshu/pages/my_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  /// tab控制器
  final _controller = PageController(initialPage: 0);

  /// 当前tab的索引
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return _buildTabBar(context);
  }

  Widget _buildTabBar (BuildContext context) {
    // 未选中的样式
    TextStyle _labelStyle = TextStyle(fontSize: 20.sp, color: Colors.grey, fontWeight: FontWeight.bold);

    // 选中的样式
    TextStyle _labelActiveStyle = TextStyle(fontSize: 20.sp, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold);

    // icon颜色
    Color _iconColor = Colors.grey;

    // icon大小
    double _iconSize = 46.sp;

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          HomePage(),
          FollowPage(),
          MessagePage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomTabBar(
        isInkResponse: Platform.isAndroid ? true : false,
        elevation: 0,
        items: <BottomTabBarItem> [
          BottomTabBarItem(
            icon: Icon(IconData(0xe7d8, fontFamily: 'iconfont'), color: _iconColor, size: _iconSize,),
            activeIcon: Icon(IconData(0xe7d8, fontFamily: 'iconfont'), size: _iconSize),
            title: Text(
              "首页",
              style: _currentTab == 0 ? _labelActiveStyle : _labelStyle,
            )
          ),
          BottomTabBarItem(
              icon: Icon(IconData(0xe7e6, fontFamily: 'iconfont'), color: _iconColor, size: _iconSize),
              activeIcon: Icon(IconData(0xe7e6, fontFamily: 'iconfont'), size: _iconSize),
              title: Text(
                "关注",
                style: _currentTab == 1 ? _labelActiveStyle : _labelStyle,
              )
          ),
          BottomTabBarItem(
            badgeNo: '10',
              icon: Icon(IconData(0xe7e2, fontFamily: 'iconfont'), color: _iconColor, size: _iconSize),
              activeIcon: Icon(IconData(0xe7e2, fontFamily: 'iconfont'), size: _iconSize),
              title: Text(
                "消息",
                style: _currentTab == 2 ? _labelActiveStyle : _labelStyle,
              )
          ),
          BottomTabBarItem(
              icon: Icon(IconData(0xe7d9, fontFamily: 'iconfont'), color: _iconColor, size: _iconSize),
              activeIcon: Icon(IconData(0xe7d9, fontFamily: 'iconfont'), size: _iconSize),
              title: Text(
                "我的",
                style: _currentTab == 3 ? _labelActiveStyle : _labelStyle,
              )
          )
        ],
        badgeColor: Colors.red,
        currentIndex: _currentTab,
        type: BottomTabBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
          _controller.jumpToPage(index);
        },
      ),
    );
  }
}