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

@interface ViewController () <UIGestureRecognizerDelegate>

@property (strong,nonatomic) NSMutableArray *movementArray;
@property (strong,nonatomic) UIBezierPath *path;
@property (strong,nonatomic) CAShapeLayer *movementShape;
@property (strong,nonatomic) PlayerTableViewController *playerTVC;
@property (strong,nonatomic) UIPopoverController *popOver;
@property (strong,nonatomic) NSArray *offense;
@property (strong,nonatomic) PlayerLayout *playerLayout;



@property (strong,nonatomic) Team *seahawks;


@property (strong,nonatomic) NSMutableArray *onScreenOffensePlayerViews;
@property (strong,nonatomic) NSMutableArray *onScreenDefensePlayerViews;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self drawField];
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

	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)drawMovement:(id)sender {

    [self.movementShape removeFromSuperlayer];
    
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
    
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        self.path = [UIBezierPath bezierPath];
        self.movementShape = [CAShapeLayer layer];
        self.movementShape.path = [self.path CGPath];
        self.movementShape.strokeColor = [[UIColor yellowColor] CGColor];
        self.movementShape.lineWidth = 10.0;
        self.movementShape.fillColor = [[UIColor clearColor] CGColor];
        
        [self.movementShape setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:20],[NSNumber numberWithInt:10],nil]];
        self.movementShape.lineJoin = kCALineJoinRound;
        self.movementShape.lineDashPhase = 100.0f;
        
        CGPoint startCenter = view.center;
        
        [self.path moveToPoint:startCenter];
        
        NSValue *start = [NSValue valueWithCGPoint:startCenter];
        
        [self.movementArray addObject:start];
    }
    
    if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [pan translationInView:self.view];
       view.center = CGPointMake(view.center.x + translation.x, view.center.y + translation.y);
        NSLog(@" %f", translation.x);
        
        CGPoint nextStep = view.center;
        
        NSValue *step = [NSValue valueWithCGPoint:nextStep];
        
        [self.movementArray addObject:step];
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
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:self.playerTVC];
    self.playerTVC.playerView = playerView;
    [self.popOver presentPopoverFromRect:playerView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.popOver.delegate = self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.popOver dismissPopoverAnimated:YES];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePlayer:)];
        
        [self.playerTVC.playerView addGestureRecognizer:pan];
    }
    
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
@end
