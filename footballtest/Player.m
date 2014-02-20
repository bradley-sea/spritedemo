//
//  Player.m
//  footballtest
//
//  Created by Brad on 2/19/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import "Player.h"

@implementation Player

-(id)initWithFirstName:(NSString *)first LastName:(NSString *)last Position:(NSString *)position Team:(NSString*)team Number:(NSString *)number Depth:(NSNumber *)depth
{
    
    self = [self init];
    
    if (self)
    {
        self.firstName = first;
        self.lastName = last;
        self.position = position;
        self.team  = team;
        self.number = number;
        self.depth = depth;
    }
    
    return self;
}

@end
