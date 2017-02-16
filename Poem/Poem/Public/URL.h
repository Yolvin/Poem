//
//  URL.h
//  Poem
//
//  Created by wyzc on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#ifndef URL_h
#define URL_h

//今日新茶
//http://kkpoembbs.duowan.com/api/topic/list.do?top=1&pageNo=1&pageSize=20
#define NEWTEAURL(top,page,size) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/topic/list.do?top=%d&pageNo=%d&pageSize=%d",top,page,size]

//热门群聊
//http://kkpoembbs.duowan.com/api/im/getHotGroupList.do?size=3
#define HOTCOMMNETURL(size) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/im/getHotGroupList.do?size=%d",size]

//
//http://kkpoembbs.duowan.com/api/group/list.do?sort=1&pageNo=1&pageSize=10
#define LIAOTIANTURL(page) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/group/list.do?sort=1&pageNo=%d&pageSize=10",page]


//今日新茶点进去的主体
//http://kkpoembbs.duowan.com/api/topic/get.do?topicId=dfc0583af1d946538b3fd836af0732ef&random=1988457577
#define COMMENTTHEMEURL(topicID) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/topic/get.do?topicId=%@&random=1988457577",topicID]

//回复内容
//http://kkpoembbs.duowan.com/api/article/list.do?topicId=74832fec6aac4020baeebf3be8fa4535&uuid=AuvqAgAl4K5Ma6xFaBIARWZmC_3mwceF3_FDtvMSB7JX&sort=2&pageNo=1&pageSize=10
#define COMMENTREPLYURL(topicID,sort) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/article/list.do?topicId=%@&uuid=AuvqAgAl4K5Ma6xFaBIARWZmC_3mwceF3_FDtvMSB7JX&sort=%d&pageNo=1&pageSize=10",topicID,sort]

//得到热门群聊话题个数
//http://kkpoembbs.duowan.com/api/group/get.do?groupId=820c9bc1ae2c45da8663b5270a873108
#define TOPICCONTENTURL(groupID) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/group/get.do?groupId=%@",groupID]

//得到热门群聊成员个数
//http://kkpoembbs.duowan.com/api/im/getGroupInfo.do?groupId=dc0c72bc40be4114a15c0339b169452a
#define TOPICMEMBERNUMURL(groupID) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/im/getGroupInfo.do?groupId=%@",groupID]

//小舍点进去
//http://kkpoembbs.duowan.com/api/group/topicList.do?groupId=3b76f34d3f2b4f239a990aed2ef1c2e3&pageNo=1&pageSize=10
#define XIAOSHEDETAILURL(groupID) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/group/topicList.do?groupId=%@&pageNo=1&pageSize=10",groupID]

//个人主页
//http://kkpoembbs.duowan.com/api/profile/userInfo.do?fuid=f065bc1d827d45028718a9d0b3216a13
#define GERENURL(userId) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/profile/userInfo.do?fuid=%@",userId]

//群聊成员
//http://kkpoembbs.duowan.com/api/im/getGroupMembers.do?groupId=dc0c72bc40be4114a15c0339b169452a&pageNo=2&pageSize=10
#define MEMBERSURL(groupId,pageNo) [NSString stringWithFormat:@"http://kkpoembbs.duowan.com/api/im/getGroupMembers.do?groupId=%@&pageNo=%d&pageSize=10",groupId,pageNo]

#endif /* URL_h */
