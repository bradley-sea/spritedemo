//
//  PlayerTableViewController.h
//  footballtest
//
//  Created by Brad on 2/19/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "PlayerView.h"

@interface PlayerTableViewController : UITableViewController

@property (strong,nonatomic) Player *player;
@property (weak,nonatomic) PlayerView *playerView;

@end
