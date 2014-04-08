//
//  PlayerView.h
//  footballtest
//
//  Created by Brad on 2/19/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface PlayerView : UIView

@property (strong,nonatomic) Player *player;
@property (strong,nonatomic) UILabel *numberLabel;
@property (nonatomic) CGPoint originalPosition;
@property (nonatomic) BOOL isTracing;
@property (nonatomic) CGPoint originalCenter;
@property (nonatomic) BOOL isOnOffense;








@end
