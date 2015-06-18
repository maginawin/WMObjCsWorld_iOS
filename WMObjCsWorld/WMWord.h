//
//  WMWord.h
//  WMObjCsWorld
//
//  Created by maginawin on 15/6/18.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMWord : NSObject

@property (assign, nonatomic) int wordId;
@property (strong, nonatomic) NSString* word;
@property (strong, nonatomic) NSString* wordDetail;

@end
