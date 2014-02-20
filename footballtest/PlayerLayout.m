//
//  PlayerLayout.m
//  footballtest
//
//  Created by Brad on 2/19/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import "PlayerLayout.h"
#import "PlayerView.h"

@interface PlayerLayout ()

@property (strong,nonatomic) NSDictionary *xPosDict;
@property (strong,nonatomic) NSDictionary *yPosDict;



@end


@implementation PlayerLayout

-(NSMutableArray *)placeTeam:(Team *)team OnView:(UIView *)view ForOffense:(BOOL)offense WithBaseFormation:(NSString *)formation
{
    [self createPositionDictionary];
    NSMutableArray *onScreenViews = [NSMutableArray new];
    
    if (offense)
    {
    for (Player *player in team.offense)
    {
            PlayerView *playerView = [PlayerView new];
            playerView.player = player;
            float x =  [[self.xPosDict objectForKey:player.position ] floatValue];
        float y = [[self.yPosDict objectForKey:player.position ] floatValue];
            playerView.frame = CGRectMake((view.frame.size.width * x), (view.frame.size.height * .6) + (view.frame.size.height * y), 44, 44);
            [self formatOffensePlayerView:playerView];
        playerView.numberLabel.text = player.number;
            [view addSubview:playerView];
        [onScreenViews addObject:playerView];
    }
    }
    else if (!offense)
    {
        for (Player *player in team.defense)
        {
            PlayerView *playerView = [PlayerView new];
            playerView.player = player;
            float x =  [[self.xPosDict objectForKey:player.position ] floatValue];
            float y = [[self.yPosDict objectForKey:player.position ] floatValue];
            playerView.frame = CGRectMake((view.frame.size.width * x), (view.frame.size.height * .6) - (view.frame.size.height * y), 44, 44);
            [self formatDefensePlayerView:playerView];
            playerView.numberLabel.text = player.number;
            [view addSubview:playerView];
            [onScreenViews addObject:playerView];
        }

        
    }
    return onScreenViews;
}

-(void)formatOffensePlayerView:(PlayerView *)playerView
{
    playerView.layer.cornerRadius = 22;
    //playerView.layer.borderWidth = 3;
    //playerView.layer.borderColor = [[UIColor blueColor] CGColor];
    playerView.layer.shadowOffset =CGSizeMake(3, 3);
    playerView.layer.shadowColor = [UIColor blackColor].CGColor;
    playerView.layer.shadowOpacity = .6;
    //playerView.backgroundColor = [UIColor colorWithRed:41.0/255.0 green:128.0/255.0 blue:185.0/255.0 alpha:1.0];
    playerView.backgroundColor = [UIColor whiteColor];
}

-(void)formatDefensePlayerView:(PlayerView *)playerView
{
    //playerView.layer.borderWidth = 3;
    //playerView.layer.borderColor = [[UIColor redColor] CGColor];
    playerView.layer.shadowOffset =CGSizeMake(3, 3);
    playerView.layer.shadowColor = [UIColor blackColor].CGColor;
    playerView.layer.shadowOpacity = .6;
    //playerView.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:60.0/255.0 alpha:1.0];
    playerView.backgroundColor = [UIColor whiteColor];
    
}

-(void)createPositionDictionary
{
    self.xPosDict = @{@"C": @".5",
                     @"QB": @".5",
                     @"RB": @".5",
                     @"FB": @".5",
                     @"WR1": @".1",
                     @"WR2": @".83",
                     @"LT": @".36",
                     @"LG": @".43",
                     @"RG": @".57",
                     @"RT": @".64",
                     @"TE": @".71",
                      
                     @"CB1": @".1",
                     @"CB2": @".83",
                      @"MLB": @".5",
                      @"OLB": @".43",
                      @"SAM": @".64",
                      @"DE1": @".36",
                      @"DE2": @".64",
                      @"DT1": @".45",
                      @"DT2": @".55",
                      @"SS" : @".3",
                      @"FS" :@".7",
                    };
    self.yPosDict = @{@"C": @"0",
                      @"QB": @".075",
                      @"RB": @".125",
                      @"FB": @".175",
                      @"WR1": @"0",
                      @"WR2": @"0",
                      @"LT": @"0",
                      @"LG": @"0",
                      @"RG": @"0",
                      @"RT": @"0",
                      @"TE": @"0",
                      
                      @"CB1": @".075",
                      @"CB2": @".075",
                      @"MLB": @".138",
                      @"OLB": @".138",
                      @"SAM": @".138",
                      @"DE1": @".075",
                      @"DE2": @".075",
                      @"DT1": @".075",
                      @"DT2": @".075",
                      @"SS" : @".225",
                      @"FS" :@".235",
                      };
}

@end
