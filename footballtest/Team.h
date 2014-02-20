//
//  Team.h
//  footballtest
//
//  Created by Brad on 2/19/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

@property (strong,nonatomic) NSString *fullName;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *location;
@property (strong,nonatomic) NSString *baseDefense;
@property (strong,nonatomic) NSString *baseOffense;
@property (strong,nonatomic) NSMutableArray *players;
@property (strong,nonatomic) NSMutableArray *offense;
@property (strong,nonatomic) NSMutableArray *defense;
@property (strong,nonatomic) NSMutableArray *roster;


-(void)createSeahawks;
@end
