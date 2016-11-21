//
//  XBADmsgCell.h
//  VideoFetch
//
//  Created by luodezhao on 16/4/12.
//  Copyright © 2016年 shixinPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XBADmsgCell : UITableViewCell
@property (nonatomic,strong)  NSDictionary *data;

@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,strong) IBOutlet UIImageView *adImg;

@property (nonatomic,strong) IBOutlet UILabel *labelName;

@property (nonatomic,strong) IBOutlet UILabel *labelContent;

@end
