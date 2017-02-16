//
//  NewTeaModel.h
//  Poem
//
//  Created by wyzc on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewTeaModel : NSObject

/*今日新茶*/

//话题id
@property(nonatomic,strong)NSString * topicId;
//用户id
@property(nonatomic,strong)NSString * createdUserId;
//题目
@property(nonatomic,strong)NSString * Title;
//内容
@property(nonatomic,strong)NSString * data_description;
//回复量
@property(nonatomic,strong)NSNumber * reply;
//查看量
@property(nonatomic,strong)NSNumber * view;
//用户名
@property(nonatomic,strong)NSString * createdNickname;
//用户头像
@property(nonatomic,strong)NSString * createdPortrait;

//热门群聊ID
@property(nonatomic,strong)NSString * groupId;

/*今日热议*/
//
@property(nonatomic,strong)NSString * img;
//
@property(nonatomic,strong)NSNumber * memberCount;
//
@property(nonatomic,strong)NSString * name;
//
@property(nonatomic,strong)NSString * lastReplyTime;

/*小舍*/
@property(nonatomic,strong)NSNumber * topicCount;

/*回帖*/
//赞的数量
@property(nonatomic,strong)NSNumber * praise;
//评论的数量
@property(nonatomic,strong)NSNumber * comment;
//回复时间
@property(nonatomic,strong)NSString * createdTime;
//内容
@property(nonatomic,strong)NSString * content;

//群聊成员头像
@property(nonatomic,strong)NSString * portrait;

@property(nonatomic,strong)NSString *  nickname;

@property(nonatomic,strong)NSString *  userId;
@end
