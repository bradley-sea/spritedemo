//
//  PlayerLayout.h
//  footballtest
//
//  Created by Brad on 2/19/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

@interface PlayerLayout : NSObject

-(NSMutableArray *)placeTeam:(Team *)team OnView:(UIView *)view ForOffense:(BOOL)offense WithBaseFormation:(NSString *)formation;


@end
