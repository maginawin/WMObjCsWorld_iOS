//
//  WMBleTableViewCell.m
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/10.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMBleTableViewCell.h"

@implementation WMBleTableViewCell

+ (instancetype)sharedInstance {
    NSArray* cells = [[NSBundle mainBundle] loadNibNamed:@"WMBleTableViewCell" owner:nil options:nil];
    return cells.firstObject;
}

- (void)awakeFromNib {
    // Initialization code
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
