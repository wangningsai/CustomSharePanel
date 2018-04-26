//
//  ViewController.m
//  CustomSharePanel
//
//  Created by wangning on 2018/4/26.
//  Copyright © 2018年 王宁. All rights reserved.
//

#import "ViewController.h"
#import "ShareView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view,
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"分享" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareBoardBySelfDefined) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self.view);
        make.width.offset(80);
        make.height.offset(30);
    }];
}

- (void)shareBoardBySelfDefined {
    
    //判断手机中是否安装微信
    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    //    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    
    NSMutableArray *titlearr     = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *imageArr     = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *noInstallImageArr = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArr     = [NSMutableArray arrayWithCapacity:5];
    
    //    if (hadInstalledWeixin) {
    [titlearr addObjectsFromArray:@[@"微信好友", @"微信朋友圈"]];
    [imageArr addObjectsFromArray:@[@"share_weChat_installed",@"share_weChatFriends_installed"]];
    [noInstallImageArr addObjectsFromArray:@[@"share_weChat_uninstalled",@"share_weChatFriends_uninstalled"]];
    [typeArr addObjectsFromArray:@[@(ShareTypeWechatSession), @(ShareTypeWechatTimeLine)]];
    //    }
    //    if (hadInstalledQQ) {
    //        [titlearr addObjectsFromArray:@[@"QQ", @"QQ空间"]];
    //        [imageArr addObjectsFromArray:@[@"qq",@"qqz"]];
    //        [typeArr addObjectsFromArray:@[@(ShareTypeQQ), @(ShareTypeQZone)]];
    //    }
    //    [titlearr addObjectsFromArray:@[@"微博"]];
    //    [imageArr addObjectsFromArray:@[@"weibo"]];
    //    [typeArr addObject:@(ShareTypeSina)];
    
    ShareView *shareView = [[ShareView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andNoInstalledWeixinImageArray:noInstallImageArr andProTitle:@"分享到" InstalledWeixin:hadInstalledWeixin];
    [shareView setBtnClick:^(NSInteger btnTag) {
        NSLog(@"\n点击第几个====%d\n当前选中的按钮title====%@",(int)btnTag,titlearr[btnTag]);
        [self shareToPlatform:[typeArr[btnTag] integerValue]];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}

- (void)shareToPlatform:(ShareType)type {
    
    switch (type) {
        case ShareTypeWechatSession:
            NSLog(@"分享至微信");
            [self shareToPlatform:ShareTypeWechatSession];
            break;
        case ShareTypeWechatTimeLine:
            NSLog(@"分享至朋友圈");
             [self shareToPlatform:ShareTypeWechatTimeLine];
            break;
        case ShareTypeQQ:
            NSLog(@"分享至QQ");
            break;
        case ShareTypeQZone:
            NSLog(@"分享至QQ空间");
            break;
        case ShareTypeSina:
            NSLog(@"分享至微博");
            break;
        default:
            break;
    }
}

-(void)shareType:(ShareType)type {
    
//    if (type == ShareTypeWechatSession) {
//
//        //创建分享消息对象
//        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//        NSString *shareTitle = @"";
//
//
//
//        UIImage *image = [[UIImage alloc]init];
//
//
//
//            NSString *urlKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:self.shareUrl]];
//            image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlKey];
//
//
//
//        //创建网页内容对象
//        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareTitle descr:@"" thumImage:image];
//
//        //设置网页地址
//        shareObject.webpageUrl = @"https://www.baidu.com";
//        //分享消息对象设置分享内容对象
//        messageObject.shareObject = shareObject;
//
//        //调用分享接口
//        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
//            if (error) {
//
//                [QMUITips showInfo:@"分享失败"];
//
//            }else{
//
//                MineMessagePopAlertView *messagePopAlertView = [[MineMessagePopAlertView alloc]initWithPopAlertViewTopImageStr:@"share_success" ConcentStr:@"分享成功" ButtonTitle:@"确定"];
//
//                [messagePopAlertView show];
//
//            }
//
//
//        }];
//
//
//    } else if (type == ShareTypeWechatTimeLine) {
//
//        //创建分享消息对象
//        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//        UIImage *image = [[UIImage alloc]init];
//
//        if (![[MYCPayConfig nilStr:self.shareUrl] isEqualToString:@""]) {
//
//            NSString *urlKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:self.shareUrl]];
//            image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlKey];
//
//            if (!image) {
//
//                image = [UIImage imageNamed:@"login_Logo.png"];
//            }
//
//        }
//
//        //创建网页内容对象
//        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"" descr:nil thumImage:image];
//        //设置网页地址
//        shareObject.webpageUrl = ShareUrl;
//        //分享消息对象设置分享内容对象
//        messageObject.shareObject = shareObject;
//
//        //调用分享接口
//        [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
//            if (error) {
//
//                NSLog(@"分享失败");
//
//            }else{
//
//               NSLog(@"分享成功");
//
//            }
//
//        }];
//
//    }
    
}

@end
