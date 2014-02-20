//
//  PlayerTableViewController.m
//  footballtest
//
//  Created by Brad on 2/19/14.
//  Copyright (c) 2014 Brad. All rights reserved.
//

#import "PlayerTableViewController.h"

@interface PlayerTableViewController ()

@property (strong,nonatomic) NSArray *mainOptions;
@property (strong,nonatomic) UILabel *headerLabel;
@property (strong,nonatomic) UILabel *numberLabel;

@end

@implementation PlayerTableViewController

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
    
    self.tableView.tableHeaderView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(50, 0, 100, 40)];
    
    self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 40)];
    [self.tableView.tableHeaderView addSubview:self.headerLabel];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
     self.headerLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    [self.tableView.tableHeaderView addSubview:self.numberLabel];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:18];
    
    
    
    self.mainOptions = @[@"Trace Route",@"Pre-Snap Movement",@"Change Player",@"Cancel"];
    
    self.preferredContentSize = CGSizeMake(200, 170);
    self.tableView.scrollEnabled = NO;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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

    // Return the number of rows in the section.
    return self.mainOptions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    

    
    // Configure the cell...
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:18];
    cell.textLabel.text = self.mainOptions[indexPath.row];
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
