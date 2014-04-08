//
//  Player.h
//  footballtest
//
//  Created by Brad on 2/19/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (strong,nonatomic) NSString *position;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *team;
@property (strong,nonatomic) NSString *number;
@property (strong,nonatomic) NSNumber *depth;

@property (strong,nonatomic) NSMutableArray *routeInfo;
@property (nonatomic) BOOL routeFinished;




-(id)initWithFirstName:(NSString *)first LastName:(NSString *)last Position:(NSString *)position Team:(NSString*)team Number:(NSString *)number Depth:(NSNumber *)depth;



@end
