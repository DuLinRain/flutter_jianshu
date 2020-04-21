import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  String _markdownData = """
ThinkPHP 6.0
===============

> 运行环境要求PHP7.1+。

ThinkPHPV6.0版本由[亿速云](https://www.yisu.com/)独家赞助发布。

## 主要新特性

* 采用`PHP7`强类型（严格模式）
* 支持更多的`PSR`规范
* 原生多应用支持
* 更强大和易用的查询
* 全新的事件系统
* 模型事件和数据库事件统一纳入事件系统
* 模板引擎分离出核心
* 内部功能中间件化
* SESSION/Cookie机制改进
* 对Swoole以及协程支持改进
* 对IDE更加友好
* 统一和精简大量用法

## 安装

~~~
composer create-project topthink/think tp 6.0.*
~~~

如果需要更新框架使用
~~~
composer update topthink/framework
~~~

## 文档

[完全开发手册](https://www.kancloud.cn/manual/thinkphp6_0/content)

## 参与开发

请参阅 [ThinkPHP 核心框架包](https://github.com/top-think/framework)。

## 版权信息

ThinkPHP遵循Apache2开源协议发布，并提供免费使用。

本项目包含的第三方源码和二进制文件之版权信息另行标注。

版权所有Copyright © 2006-2020 by ThinkPHP (http://thinkphp.cn)

All rights reserved。

ThinkPHP® 商标和著作权所有者为上海顶想信息科技有限公司。

更多细节参阅 [LICENSE.txt](LICENSE.txt)
""";

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0.0,
          titleSpacing: 0.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
              color: Color(0xff888888)
          ),
          title: _buildTitleBar(context),
          actions: <Widget>[
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.more_vert),
              onPressed: () {

              },
            )
          ],
        ),
        preferredSize: Size.fromHeight(100.w),
      ),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  /// titleBar
  Widget _buildTitleBar (BuildContext context) {
    return Container(
      height: 70.w,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60.w),
              child: Image.network(
                  "https://img2.yizhipin.com/50cc5cd2d0161ba67b7e3efce9b22f34.jpg",
                width: 60.w,
                height: 60.w,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w
              ),
              child: Text(
                "写bug的程序员",
                style: TextStyle(
                    fontSize: 26.sp,
                    color: Color(0xff666666)
                ),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              alignment: Alignment.center,
              width: 110.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: Color(0xff49BE39),
                borderRadius: BorderRadius.circular(60.w)
              ),
              child: Text(
                '+ 关注',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 页面主框架
  Widget _buildBody (BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xffededed),
            width: 1
          )
        )
      ),
      child: ListView(
        children: <Widget>[
          _buildArticleDetail(context)
        ],
      ),
    );
  }

  /// 文章详情
  Widget _buildArticleDetail (BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 20.w
      ),
      child: MarkdownBody(
        selectable: true,
        data: _markdownData,
      ),
    );
  }
}