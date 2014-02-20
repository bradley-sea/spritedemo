//
//  Team.m
//  footballtest
//
//  Created by Brad on 2/19/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import "Team.h"
#import "Player.h"

@implementation Team

-(id)init
{
    self = [super init];
    
    if (self) {
        self.roster = [NSMutableArray new];
        self.offense = [NSMutableArray new];
        self.defense = [NSMutableArray new];
    }
    
    
    return self;
}

-(void)createSeahawks
{
    
    
    self.fullName = @"Seattle Seahawlks";
    
    Player *QB = [[Player alloc]initWithFirstName:@"Russel" LastName:@"Wilson" Position:@"QB" Team:@"Seattle Seahawks" Number:@"3" Depth:@1];
    Player *RB = [[Player alloc]initWithFirstName:@"Marshawn" LastName:@"Lynch" Position:@"RB" Team:@"Seattle Seahawks" Number:@"24" Depth:@1];
    Player *WR1 = [[Player alloc]initWithFirstName:@"Percy" LastName:@"Harvin" Position:@"WR1" Team:@"Seattle Seahawks" Number:@"11" Depth:@1];
    Player *WR2 = [[Player alloc]initWithFirstName:@"Doug" LastName:@"Baldwin" Position:@"WR2" Team:@"Seattle Seahawks" Number:@"89" Depth:@2];
    Player *FB = [[Player alloc] initWithFirstName:@"Michael" LastName:@"Robinson" Position:@"FB" Team:@"Seattle Seahawks" Number:@"26" Depth:@1];
    Player *C = [[Player alloc] initWithFirstName:@"Max" LastName:@"Unger" Position:@"C" Team:@"Seattle Seahawks" Number:@"60" Depth:@1];
    Player *LT =  [[Player alloc] initWithFirstName:@"Russell" LastName:@"Okung" Position:@"LT" Team:@"Seattle Seahawks" Number:@"76" Depth:@1];
    Player *RT = [[Player alloc] initWithFirstName:@"Breno" LastName:@"Gicamini" Position:@"RT" Team:@"Seattle Seahawks" Number:@"68" Depth:@1];
    Player *RG = [[Player alloc] initWithFirstName:@"JR" LastName:@"Sweezy" Position:@"RG" Team:@"Seattle Seahawks" Number:@"64" Depth:@1];
    Player *LG =  [[Player alloc] initWithFirstName:@"Alvin" LastName:@"Bailey" Position:@"LG" Team:@"Seattle Seahawks" Number:@"78" Depth:@1];
    Player *TE =  [[Player alloc] initWithFirstName:@"Zach" LastName:@"Miller" Position:@"TE" Team:@"Seattle Seahawks" Number:@"86" Depth:@1];
    
    
    self.offense = [NSMutableArray arrayWithObjects:QB,RB,WR1,WR2,FB,C,LT,RT,RG,LG,TE, nil];
    
    Player *FS = [[Player alloc]initWithFirstName:@"Earl" LastName:@"Thomas" Position:@"FS" Team:@"Seattle Seahawks" Number:@"29" Depth:@1];
    Player *SS = [[Player alloc]initWithFirstName:@"Kam" LastName:@"Chancellor" Position:@"SS" Team:@"Seattle Seahawks" Number:@"31" Depth:@1];
    Player *CB1 = [[Player alloc]initWithFirstName:@"Richard" LastName:@"Sherman" Position:@"CB1" Team:@"Seattle Seahawks" Number:@"25" Depth:@1];
    Player *CB2 = [[Player alloc]initWithFirstName:@"Byron" LastName:@"Maxwell" Position:@"CB2" Team:@"Seattle Seahawks" Number:@"41" Depth:@2];
    Player *DT1 = [[Player alloc] initWithFirstName:@"Michael" LastName:@"Bennet" Position:@"DT1" Team:@"Seattle Seahawks" Number:@"72" Depth:@1];
    Player *DE1 = [[Player alloc] initWithFirstName:@"Cliff" LastName:@"Avirl" Position:@"DE1" Team:@"Seattle Seahawks" Number:@"56" Depth:@2];
    Player *DT2 =  [[Player alloc] initWithFirstName:@"Brandon" LastName:@"Mebane" Position:@"DT2" Team:@"Seattle Seahawks" Number:@"76" Depth:@1];
    Player *MLB = [[Player alloc] initWithFirstName:@"Bobby" LastName:@"Wagner" Position:@"MLB" Team:@"Seattle Seahawks" Number:@"54" Depth:@1];
    Player *OLB = [[Player alloc] initWithFirstName:@"KJ" LastName:@"Wright" Position:@"OLB" Team:@"Seattle Seahawks" Number:@"50" Depth:@1];
    Player *DE2 =  [[Player alloc] initWithFirstName:@"Chris" LastName:@"Clemons" Position:@"DE2" Team:@"Seattle Seahawks" Number:@"78" Depth:@1];
    Player *SAM =  [[Player alloc] initWithFirstName:@"Malcom" LastName:@"Smith" Position:@"SAM" Team:@"Seattle Seahawks" Number:@"53" Depth:@1];
    
    self.defense = [NSMutableArray arrayWithObjects:FS,SS,CB1,CB2,DT1,DT2,DE1,DE2,MLB,OLB,SAM, nil];

}

@end
