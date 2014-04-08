//
//  ViewController.m
//  footballtest
//
//  Created by Brad on 2/7/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "PlayerTableViewController.h"
#import "Player.h"
#import "Team.h"
#import "PlayerLayout.h"
#import "PlayerView.h"
#import "GameInfoTableViewController.h"
#import "PanStoppedViewController.h"
#import "EventsTableViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (strong,nonatomic) NSMutableArray *movementArray;
@property (strong,nonatomic) UIBezierPath *path;
@property (strong,nonatomic) UIBezierPath *blockPath;
@property (strong,nonatomic) CAShapeLayer *movementShape;

//POPOVER CONTROLLERS
@property (strong,nonatomic) PlayerTableViewController *playerTVC;
@property (strong,nonatomic) GameInfoTableViewController *gameInfoTVC;
@property (strong,nonatomic) PanStoppedViewController *panStoppedTVC;
@property (strong,nonatomic) EventsTableViewController *eventsTVC;
@property (strong,nonatomic) UIPopoverController *popOver;


@property (strong,nonatomic) NSArray *offense;
@property (strong,nonatomic) PlayerLayout *playerLayout;
@property (strong,nonatomic) UIButton *gameInfoButton;
@property (strong,nonatomic) UINavigationController *panStoppedNav;
@property (strong,nonatomic) Team *seahawks;
@property (strong,nonatomic) CAShapeLayer *blockShape;


@property (strong,nonatomic) NSMutableArray *onScreenOffensePlayerViews;
@property (strong,nonatomic) NSMutableArray *onScreenDefensePlayerViews;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(700, 20, 40, 40)];
    [saveButton setImage:[UIImage imageNamed:@"saveToCloud.png"] forState:UIControlStateNormal];
    
    [self.navigationController.view addSubview:saveButton];
    
    UIButton *playInfoButton = [[UIButton alloc] initWithFrame:CGRectMake(500, 10, 38, 50)];
    [playInfoButton setImage:[UIImage imageNamed:@"playInfoLabel.png"] forState:UIControlStateNormal];
    
    [self.navigationController.view addSubview:playInfoButton];
    
    self.gameInfoButton = [[UIButton alloc] initWithFrame:CGRectMake(450, 10, 38, 50)];
    [self.gameInfoButton setImage:[UIImage imageNamed:@"gameInfoLabel.png"] forState:UIControlStateNormal];
    [self.gameInfoButton addTarget:self action:@selector(gameInfoPressed:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.navigationController.view addSubview:self.gameInfoButton];

    self.seahawks = [Team new];
    [self.seahawks createSeahawks];
    self.playerLayout = [PlayerLayout new];
   self.onScreenOffensePlayerViews = [self.playerLayout placeTeam:self.seahawks OnView:self.view ForOffense:YES WithBaseFormation:@"power"];
    self.onScreenDefensePlayerViews = [self.playerLayout placeTeam:self.seahawks OnView:self.view ForOffense:NO WithBaseFormation:@"3-4"];

    for (PlayerView *playerView in self.onScreenOffensePlayerViews)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayer:)];
        [playerView addGestureRecognizer:tap];
    }
    
    for (PlayerView *playerView in self.onScreenDefensePlayerViews)
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPlayer:)];
        [playerView addGestureRecognizer:tap];
    }
    
    self.movementArray = [NSMutableArray new];
    
    self.playerTVC = [[PlayerTableViewController alloc] init];
    self.playerTVC.tableView.delegate = self;
    
    self.gameInfoTVC = [[GameInfoTableViewController alloc] init];
    self.gameInfoTVC.tableView.delegate = self;
    
    self.panStoppedTVC = [[PanStoppedViewController alloc] init];
    self.panStoppedTVC.tableView.delegate = self;
    self.panStoppedTVC.tableView.tag = 1;
    
    self.eventsTVC = [[EventsTableViewController alloc] init];
    self.eventsTVC.tableView.delegate = self;
    self.eventsTVC.tableView.tag = 2;
    
    self.panStoppedNav = [[UINavigationController alloc] initWithRootViewController:self.panStoppedTVC];

	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)drawLast:(id)sender {
    
    self.path = [UIBezierPath bezierPath];
    self.movementShape = [CAShapeLayer layer];
    self.movementShape.path = [self.path CGPath];
    self.movementShape.strokeColor = [[UIColor redColor] CGColor];
    self.movementShape.lineWidth = 10.0;
    self.movementShape.fillColor = [[UIColor clearColor] CGColor];
    
    [self.movementShape setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:20],[NSNumber numberWithInt:10],nil]];
    self.movementShape.lineJoin = kCALineJoinRound;
    self.movementShape.lineDashPhase = 100.0f;
    
    NSValue *startValue =self.movementArray[0];

    CGPoint startCenter = [startValue CGPointValue];
    [self.path moveToPoint:startCenter];
                           
    [self.movementArray removeObjectAtIndex:0];
                           
    for (NSValue *value in self.movementArray)
    {
        
        CGPoint step = [value CGPointValue];
        [self.path addLineToPoint:step];
        self.movementShape.path = [self.path CGPath];
    }

    [self.view.layer addSublayer:self.movementShape];
    
}

-(void)movePlayer:(id)sender
{
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    
    UIView *view = [pan view];
    PlayerView *playerView = (PlayerView *)view;
    
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        self.path = [UIBezierPath bezierPath];
        self.movementShape = [CAShapeLayer layer];
        self.movementShape.path = [self.path CGPath];
        if (playerView.isOnOffense)
        {
        self.movementShape.strokeColor = [[UIColor yellowColor] CGColor];
        }
        else
        {
          self.movementShape.strokeColor = [[UIColor redColor] CGColor];
        }
        self.movementShape.lineWidth = 10.0;
        self.movementShape.fillColor = [[UIColor clearColor] CGColor];
        
        [self.movementShape setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:20],[NSNumber numberWithInt:10],nil]];
        self.movementShape.lineJoin = kCALineJoinRound;
        self.movementShape.lineDashPhase = 100.0f;
        
        CGPoint startCenter = view.center;
        
        [self.path moveToPoint:startCenter];
        
        NSValue *start = [NSValue valueWithCGPoint:startCenter];
        
        PlayerView *playerView = (PlayerView *)view;
        playerView.originalCenter = playerView.center;
        playerView.isTracing = YES;
        
        [self.movementArray addObject:start];
    }
    
    if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [pan translationInView:self.view];
       view.center = CGPointMake(view.center.x + translation.x, view.center.y + translation.y);
        
        NSLog(@" %f", translation.x);
        
        CGPoint nextStep = view.center;
        
        
        NSValue *step = [NSValue valueWithCGPoint:nextStep];
        PlayerView *playerView = (PlayerView *)view;
        
        [playerView.player.routeInfo addObject:step];
        [self.path addLineToPoint:nextStep];
        self.movementShape.path = [self.path CGPath];
        [self.view.layer addSublayer:self.movementShape];
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
           }
    
    if (pan.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@" %@", self.movementArray);
      
    }
}

-(void)tapPlayer:(id)sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    PlayerView *playerView = (PlayerView *)tap.view;
    if (!playerView.isTracing)
    {
    self.playerTVC = [PlayerTableViewController new];
        self.playerTVC.tableView.delegate = self;
    self.playerTVC.playerView = playerView;
    [self.playerTVC reloadTableViewBasedOnPlayerState];
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:self.playerTVC]; 
    }
    else if (playerView.isTracing)
    {
        self.popOver = [[UIPopoverController alloc] initWithContentViewController:self.panStoppedNav];
        self.panStoppedTVC.playerView = playerView;
    }
    
    [self.popOver presentPopoverFromRect:playerView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.popOver.delegate = self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1)
    {
        if (indexPath.row ==0)
        {
            [self.panStoppedNav pushViewController:self.eventsTVC animated:YES];
        }
    }
    if (tableView.tag == 0)
    {
    if (indexPath.row == 0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.popOver dismissPopoverAnimated:YES];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePlayer:)];
        
        [self.playerTVC.playerView addGestureRecognizer:pan];
    }
    }
    if (tableView.tag == 2)
    {
        if (indexPath.row == 0)
        {
        self.panStoppedTVC.playerView.isTracing = NO;
       [self.popOver dismissPopoverAnimated:YES];
         [self.panStoppedNav popViewControllerAnimated:NO];
        
        [self createBlockLineForPlayerView:self.panStoppedTVC.playerView];
        }
        
        if (indexPath.row == 1)
        {
            self.panStoppedTVC.playerView.isTracing = NO;
            [self.popOver dismissPopoverAnimated:YES];
            [self.panStoppedNav popViewControllerAnimated:NO];
            
            [self createMoveLineForPlayerView:self.panStoppedTVC.playerView];
            
        }
        self.panStoppedTVC.playerView.player.routeFinished = YES;
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (self.panStoppedNav)
    {
        [self.panStoppedNav popViewControllerAnimated:NO];
    }
}

-(void)createBlockLineForPlayerView:(PlayerView *)playerView
{
    NSValue *endValue = [playerView.player.routeInfo lastObject];
    CGPoint endPoint = [endValue CGPointValue];
    
    NSValue *startValue = [playerView.player.routeInfo objectAtIndex:playerView.player.routeInfo.count -2];
    CGPoint startPoint = [startValue CGPointValue];
    
    float x1 = startPoint.x;
    float y1 = startPoint.y;
    
    float x2 = endPoint.x;
    float y2 = endPoint.y;
    
    float theta;
    float alpha;
    
    alpha = atanf((x2-x1)/(y2-y1));
    
    theta = (alpha);
    
    float newX = 50*cos(theta);
    float newY = 50*sin(theta);
    
    float x3 = x2-newX;
    float y3 = y2+newY;
    
    float x4 = x2+newX;
    float y4 = y2-newY;
    
    [self.path moveToPoint:endPoint];
    [self.path addLineToPoint:CGPointMake(x3, y3)];
    
   [self.path  moveToPoint:endPoint];
    [self.path addLineToPoint:CGPointMake(x4, y4)];
    
    self.movementShape.path = [self.path  CGPath];
    [self.view.layer addSublayer:self.blockShape];
    
    [UIView animateWithDuration:.5 animations:^{
        
        self.panStoppedTVC.playerView.center = playerView.originalCenter;
    }];
    
}

-(void)createMoveLineForPlayerView:(PlayerView *)playerView
{
    NSValue *endValue = [playerView.player.routeInfo lastObject];
    CGPoint endPoint = [endValue CGPointValue];
    
    NSValue *startValue = [playerView.player.routeInfo objectAtIndex:playerView.player.routeInfo.count -2];
    CGPoint startPoint = [startValue CGPointValue];
    
    float x1 = startPoint.x;
    float y1 = startPoint.y;
    
    float x2 = endPoint.x;
    float y2 = endPoint.y;
    
    float xDiff = x2 - x1;
    float yDiff = y2 - y1;
    
    float angle = atan2f(yDiff, xDiff);
    float angleD = atan2f(yDiff, xDiff) * (180 / M_PI);
    
    float theta_deg = (angle/M_PI*180) + (angle > 0 ? 0 : 360);
    float radians = theta_deg / (180/M_PI);
    
    
    
    NSLog(@"xDiff was %f",xDiff);
    NSLog(@"yDiff was %f",yDiff);
    NSLog(@" angle is %f",angle);
    
    UIImageView *imageView;
    
    if (playerView.isOnOffense)
    {
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowarrow.png"]];
    }
    else
    {
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redarrow.png"]];
    }

    imageView.center = endPoint;
    
    imageView.transform = CGAffineTransformMakeRotation(radians);
    
    [self.view addSubview:imageView];
    
    [UIView animateWithDuration:.5 animations:^{
        
        self.panStoppedTVC.playerView.center = playerView.originalCenter;
    }];
    
}

-(void)drawField
{
    for (int i=0; i <=10;i++)
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height * ((i *.1) + .085), self.view.frame.size.width, 10)];
        line.backgroundColor = [UIColor whiteColor];
        line.alpha = .25;
        [self.view addSubview:line];
    }
}

-(void)gameInfoPressed:(id)sender
{
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:self.gameInfoTVC];
    [self.popOver presentPopoverFromRect:self.gameInfoButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.popOver.delegate = self;
}

@end
