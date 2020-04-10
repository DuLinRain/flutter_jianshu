import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  /// 搜索框控制器
  TextEditingController textEditingController = TextEditingController();

  List hotSearchList  = [
    {
      "index": 1,
      "title": "《安家》宋老师与江老太的爱情：那个年代，车马很慢，一生只够爱一人！",
      "read": "607"
    },
    {
      "index": 2,
      "title": "罗志祥周扬青恋爱9年分手：不想跟你结婚的男人，不如让他滚吧！",
      "read": "607"
    }
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
              color: Color(0xff888888)
          ),
          title: _buildSearchBar(context),
          titleSpacing: 0,
        ),
        preferredSize: Size.fromHeight(90.w),
      ),
      body: Column(
        children: <Widget>[
          _buildSearchTitle(context),
          _buildHotSearchList(context)
        ],
      ),
    );
  }

  /// 搜索框
  Widget _buildSearchBar (BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            height: 60.w,
            decoration: BoxDecoration(
                color: Color(0xfff4f4f4),
                borderRadius: BorderRadius.circular(60.w)
            ),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: textEditingController,
                    style: TextStyle(
                        fontSize: 28.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        locale: Locale('en', 'US')
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.w,
                          horizontal: 30.w
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      hintText: '搜索文章、专题、用户、文集',
                      hintStyle: TextStyle(
                          color: Color(0xff888888)
                      ),
                    ),
                    cursorWidth: 2,
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.search,
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 30.w,
                    ),
                    child: Container(
                      height: 30.w,
                      width: 1,
                      decoration: BoxDecoration(
                        color: Color(0xfffcccccc)
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 30.w,
                      left: 20.w
                    ),
                    child: Icon(
                      IconData(0xe653, fontFamily: 'iconfont'),
                      size: 26.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            width: 30.w,
          ),
        )
      ],
    );
  }

  /// 标题
  Widget _buildSearchTitle (BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 10.w
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xffededed),
            width: 1
          )
        )
      ),
      child: Row(
        children: <Widget>[
          Icon(
            IconData(0xe629, fontFamily: 'iconfont'),
            color: Theme.of(context).primaryColor,
            size: 26.sp,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.w
            ),
            child: Text(
              '搜索趋势',
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Color(0xff555555),
                  fontWeight: FontWeight.w600
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 热搜list
  Widget _buildHotSearchList (BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: hotSearchList.map((item) {
            return _buildHotSearchItem(context, item);
          }).toList(),
        ),
      ),
    );
  }

  /// 热搜item
  Widget _buildHotSearchItem (BuildContext context, dynamic item) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 30.w
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xffededed)
            )
          )
        ),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Text('${item["index"]}', style: TextStyle(
                  fontSize: 40.sp,
                  color: item["index"] <= 3 ? Theme.of(context).primaryColor : Color(0xffb1b1b1)
              ),),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 30.w
                ),
                child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        height: 1.3
                      ),
                        children: [
                          TextSpan(
                              text: item["title"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                              )
                          ),
                          TextSpan(
                              text: '  阅读 ${item["read"]}',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  color: Color(0xff777777)
                              )
                          )
                        ]
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
