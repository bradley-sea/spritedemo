//
//  PanStoppedViewController.m
//  footballtest
//
//  Created by Brad on 2/20/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import "PanStoppedViewController.h"

@interface PanStoppedViewController ()

@property (strong,nonatomic) NSArray *panStoppedOptions;
@property (strong,nonatomic) UILabel *headerLabel;
@property (strong,nonatomic) UILabel *numberLabel;

@end

@implementation PanStoppedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.preferredContentSize = CGSizeMake(200, 210);
    
    self.tableView.tableHeaderView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(50, 0, 100, 40)];
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 40)];
    [self.tableView.tableHeaderView addSubview:self.headerLabel];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    [self.tableView.tableHeaderView addSubview:self.numberLabel];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
    
    self.panStoppedOptions = @[@"Finish Route",@"Keep Tracing",@"Create Event",@"Change Player"];
    
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"stoppedCell"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.headerLabel.text = [NSString stringWithFormat:@"%@",self.playerView.player.lastName ];
    self.numberLabel.text = [NSString stringWithFormat:@"#%@",self.playerView.player.number];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.panStoppedOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"stoppedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:18];
    cell.textLabel.text = self.panStoppedOptions[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
