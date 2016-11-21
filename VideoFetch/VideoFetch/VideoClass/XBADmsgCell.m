//
//  XBADmsgCell.m
//  VideoFetch
//
//  Created by luodezhao on 16/4/12.
//  Copyright © 2016年 shixinPeng. All rights reserved.
//

#import "XBADmsgCell.h"


@implementation XBADmsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setData:(NSDictionary *)data {
    
    self.labelName.text = [data objectForKey:@"name"];
    self.labelName.numberOfLines = 0;
    [self.labelName setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width - 90];
    CGSize size1 = [self.labelName sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 90, MAXFLOAT)];
//    [self.labelName sizeToFit];

    self.labelContent.text = [data objectForKey:@"content"];
    self.labelContent.numberOfLines = 0;
    [self.labelContent setPreferredMaxLayoutWidth:[UIScreen mainScreen].bounds.size.width - 90];
    [self.labelContent sizeToFit];
    CGSize size2 = [self.labelContent sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - 90, MAXFLOAT)];

//    self.cellHeight = self.labelContent.frame.size.height + self.labelName.frame.size.height + 24;
    self.cellHeight = size1.height + size2.height + 24;
    NSURL *url = [NSURL URLWithString:[data objectForKey:@"imagePath"]];
    
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    
    self.adImg.image = [UIImage imageWithData:imgData];
    

    
}

@end
