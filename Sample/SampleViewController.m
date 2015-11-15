//
//  SampleViewController.m
//  Sample
//
//  Created by Tarun on 07/11/15.
//  Copyright (c) 2015 nichepro. All rights reserved.
//

#import "SampleViewController.h"
#import "Case.h"

@interface SampleViewController ()

@end

@implementation SampleViewController

@synthesize mobile, messageLabel;
//Table View
@synthesize casesTableView, cases, caseDetailViewController;
//Table View

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.cases = [[NSMutableArray alloc] init];
    //self.casesTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dice.png"]];
    
    self.casesTableView.backgroundColor = [UIColor clearColor];
    
    for (int i = 1; i<= 10; i++) {
        Case *newcase = [[Case alloc] init];
        newcase.title = [NSString stringWithFormat:@"Name %d", i];
        newcase.description = [NSString stringWithFormat:@"Description of %d", i];
        [self.cases addObject:newcase];
    }
    [self.casesTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sendOtpClicked:(id)sender
{
    messageLabel.text = [NSString stringWithFormat:@"OTP sent to mobile %@", mobile.text];
}

// Table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cases count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *uniqueIdentifier = @"UITableViewCell";
    cell = [self.casesTableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    Case *activeCase = [self.cases objectAtIndex:[indexPath row]];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:uniqueIdentifier];
        [[cell textLabel] setText: activeCase.title];
        [[cell imageView] setImage:[UIImage imageNamed:@"dice.png"]];
        [[cell detailTextLabel] setText:@"UI Table description"];
        [[cell textLabel] setTextColor: [UIColor blackColor]];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gradient.jpeg"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"grass.png"]];
        cell.accessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    return cell;
}
// Table View

// Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"I am in didSelectRowAtIndexPath");
    if(!self.caseDetailViewController)
    {
        self.caseDetailViewController = [[CaseDetailController alloc] init];
    }
    
    Case *selectedCase = [self.cases objectAtIndex:[indexPath row]];
    self.caseDetailViewController.selectedCase = selectedCase;
    [self.navigationController pushViewController:self.caseDetailViewController animated:YES];
}

//Navigation

@end
